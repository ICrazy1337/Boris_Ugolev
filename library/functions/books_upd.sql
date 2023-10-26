CREATE OR REPLACE FUNCTION library.books_upd(_src JSONB) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _book_id      INT;
    _name         VARCHAR(128);
    _author       VARCHAR(128);
    _genre_id     INT;
    _description  VARCHAR(320);
    _cell_id      INT;
    _is_available BOOLEAN;
    _deposit      NUMERIC(15, 2);
BEGIN
    SELECT coalesce(b.book_id, nextval('library.books_sq')) AS book_id,
           b.name,
           b.author,
           b.genre_id,
           b.description,
           b.cell_id,
           b.is_available,
           b.deposit
    INTO _book_id, _name, _author, _genre_id, _description, _cell_id, _is_available, _deposit
    FROM jsonb_to_record(_src) AS s (book_id INT,
                                     name VARCHAR(128),
                                     author VARCHAR(128),
                                     genre_id INT,
                                     description VARCHAR(320),
                                     cell_id INT,
                                     is_available BOOLEAN,
                                     deposit NUMERIC(15, 2))
             LEFT JOIN library.books b ON b.book_id = s.book_id;

    IF NOT EXISTS (SELECT 1 FROM dictionary.genres p WHERE p.genre_id = _genre_id) THEN
        RETURN public.errmessage(_errcode := 'library.books_upd.genre_id',
                                 _msg := 'Нет такого жанра!',
                                 _detail := concat('genre_id = ', _genre_id));
    END IF;

    IF NOT EXISTS (SELECT 1
                   FROM library.cells p
                            JOIN library.places s ON p.place_id = s.place_id
                   WHERE s.genre_id = _genre_id
                     AND p.cell_id = _cell_id) THEN
        RETURN public.errmessage(_errcode := 'library.books_upd.cellsplaces',
                                 _msg := 'Нет подходящей ячейки!',
                                 _detail := concat('cell_id = ', _cell_id));
    END IF;

    UPDATE library.cells SET is_avaliable = FALSE WHERE cell_id = _cell_id;

    WITH ins_cte AS (
        INSERT INTO library.books AS ec (book_id, cell_id, genre_id, name, author, description, is_available, deposit)
            VALUES (_book_id, _cell_id, _genre_id, _name, _author, _description, _is_available, _deposit)
            ON CONFLICT (book_id) DO UPDATE
                SET cell_id = excluded.cell_id,
                    genre_id = excluded.genre_id,
                    name = excluded.name,
                    author = excluded.author,
                    description = excluded.description,
                    is_available = excluded.is_available,
                    deposit = excluded.deposit
            RETURNING ec.*)
    INSERT
    INTO history.bookschanges (book_id, cell_id, genre_id, name, author, description, is_available, deposit)
    SELECT book_id,
           cell_id,
           genre_id,
           name,
           author,
           description,
           is_available,
           deposit
    FROM ins_cte ic;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;