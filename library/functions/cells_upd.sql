CREATE OR REPLACE FUNCTION library.cells_upd(_src JSONB) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _cell_id  INT;
    _place_id INT;
BEGIN
    SELECT coalesce(cell_id, nextval('library.cells_cell_id_seq')) AS cell_id, place_id
    INTO _cell_id, _place_id
    FROM jsonb_to_record(_src) AS s (cell_id INT,
                                     place_id INT);

    INSERT INTO library.cells AS a (cell_id, place_id, is_avaliable)
    SELECT _cell_id, _place_id, TRUE
        ON CONFLICT (cell_id) DO UPDATE
            SET place_id = excluded.place_id;

    RETURN JSONB_BUILD_OBJECT('cell_id', _cell_id, 'place_id', _place_id);
END
$$;