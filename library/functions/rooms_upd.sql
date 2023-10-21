CREATE OR REPLACE FUNCTION library.rooms_upd(_src JSONB) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _room_id INT;
    _name    VARCHAR(64);
BEGIN
    SELECT coalesce(room_id, nextval('library.rooms_room_id_seq')) AS room_id, name
    INTO _room_id, _name
    FROM jsonb_to_record(_src) AS s (room_id SMALLINT,
                                     name VARCHAR(64));

    INSERT INTO library.rooms AS a (room_id, name)
    SELECT _room_id, _name
    ON CONFLICT (room_id) DO UPDATE
        SET name = excluded.name;

    RETURN JSONB_BUILD_OBJECT('room_id', _room_id, 'name', _name);
END
$$;