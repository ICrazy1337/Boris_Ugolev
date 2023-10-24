CREATE OR REPLACE FUNCTION library.penalties_upd(_src JSONB, _ch_staff_id INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _penalty_id  INT;
    _type_id     INT;
    _issued_id   INT;
    _ch_dt       TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
BEGIN
    SELECT coalesce(penalty_id, nextval('library.penalties_penalty_id_seq')) AS penalty_id, type_id, issued_id
    INTO _penalty_id, _type_id, _issued_id
    FROM jsonb_to_record(_src) AS s (penalty_id INT,
                                     type_id INT,
                                     issued_id INT);

     IF NOT EXISTS (SELECT 1 FROM library.issueds p WHERE p.issued_id = _issued_id) THEN
        RETURN public.errmessage(_errcode := 'library.penalties_upd.issued_id',
                                 _msg := 'Нет такой выдачи!',
                                 _detail := concat('issued_id = ', _issued_id));
    END IF;

    INSERT INTO library.penalties AS a (penalty_id, type_id, issued_id, ch_staff_id, ch_dt)
    SELECT _penalty_id, _type_id, _issued_id, _ch_staff_id, _ch_dt
        ON CONFLICT (penalty_id) DO UPDATE
            SET type_id = excluded.type_id,
                issued_id = excluded.issued_id,
                ch_staff_id = excluded.ch_staff_id,
                ch_dt = excluded.ch_dt;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;