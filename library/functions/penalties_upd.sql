CREATE OR REPLACE FUNCTION library.penalties_upd(_src JSONB, _ch_staff_id INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _penalty_id INT;
    _type_id    INT;
    _issued_id  INT;
    _ch_dt      TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
BEGIN
    SELECT coalesce(p.penalty_id, nextval('library.penalties_penalty_id_seq')) AS penalty_id, s.type_id, s.issued_id
    INTO _penalty_id, _type_id, _issued_id
    FROM jsonb_to_record(_src) AS s (penalty_id INT,
                                     type_id INT,
                                     issued_id INT)
             LEFT JOIN library.penalties p ON p.issued_id = s.issued_id;

    INSERT INTO library.penalties AS a (penalty_id, type_id, issued_id, ch_staff_id, ch_dt)
    SELECT _penalty_id, _type_id, _issued_id, _ch_staff_id, _ch_dt
    ON CONFLICT (penalty_id) DO UPDATE
        SET type_id     = excluded.type_id,
            issued_id   = excluded.issued_id,
            ch_staff_id = excluded.ch_staff_id,
            ch_dt       = excluded.ch_dt;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;