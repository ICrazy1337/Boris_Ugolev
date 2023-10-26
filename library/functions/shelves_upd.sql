CREATE OR REPLACE FUNCTION library.shelves_upd(_src JSONB) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _shelf_id INT;
    _room_id  INT;
BEGIN
    SELECT coalesce(sh.shelf_id, nextval('library.shelves_shelf_id_seq')) AS shelf_id, s.room_id
    INTO _shelf_id, _room_id
    FROM jsonb_to_record(_src) AS s (shelf_id INT,
                                     room_id INT)
             LEFT JOIN library.shelves sh ON sh.shelf_id = s.shelf_id;

    IF NOT EXISTS (SELECT 1 FROM library.rooms r WHERE r.room_id = _room_id) THEN
        RETURN public.errmessage(_errcode := 'library.shelves_upd.room_id',
                                 _msg := 'Нет такой комнаты!',
                                 _detail := concat('room_id = ', _room_id));
    END IF;

    INSERT INTO library.shelves AS a (shelf_id, room_id)
    SELECT _shelf_id, _room_id
    ON CONFLICT (shelf_id) DO UPDATE
        SET room_id = excluded.room_id;

    RETURN JSONB_BUILD_OBJECT('shelf_id', _shelf_id, 'room_id', _room_id);
END
$$;