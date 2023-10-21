CREATE OR REPLACE FUNCTION library.places_upd(_src JSONB) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _place_id INT;
    _shelf_id INT;
    _genre_id INT;
BEGIN
    SELECT coalesce(place_id, nextval('library.places_place_id_seq')) AS place_id, shelf_id, genre_id
    INTO _place_id, _shelf_id, _genre_id
    FROM jsonb_to_record(_src) AS s (place_id INT, shelf_id INT, genre_id VARCHAR(320));

    IF NOT EXISTS (SELECT 1 FROM dictionary.genres p WHERE p.genre_id = _genre_id) THEN
        RETURN public.errmessage(_errcode := 'library.places_upd.genre_id',
                                 _msg := 'Нет такого жанра!',
                                 _detail := concat('genre_id = ', _genre_id));
    END IF;

    INSERT INTO library.places (place_id, shelf_id, genre_id)
    VALUES (_place_id, _shelf_id, _genre_id)
    ON CONFLICT (place_id) DO UPDATE
        SET genre_id = excluded.genre_id;

    RETURN JSONB_BUILD_OBJECT('shelf_id', _shelf_id, 'place_id', _place_id, 'genre_id', _genre_id);
END
$$;