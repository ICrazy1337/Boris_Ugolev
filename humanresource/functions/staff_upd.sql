CREATE OR REPLACE FUNCTION humanresource.staff_upd(_src JSONB, _ch_staff_id INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _staff_id     INT;
    _name         VARCHAR(64);
    _surname      VARCHAR(64);
    _phone_number VARCHAR(11);
    _post_id      INT;
    _ch_dt        TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
BEGIN
    SELECT COALESCE(s1.staff_id, nextval('humanresource.staff_sq')) AS staff_id,
           s.name,
           s.surname,
           s.phone_number,
           s.post_id
    INTO _staff_id, _name, _surname, _phone_number, _post_id
    FROM jsonb_to_record(_src) AS s (staff_id INT,
                                     name VARCHAR(64),
                                     surname VARCHAR(64),
                                     phone_number VARCHAR(11),
                                     post_id INT)
             LEFT JOIN humanresource.staff s1 ON s1.staff_id = s.staff_id;

    INSERT INTO humanresource.staff AS ec (staff_id,
                                           name,
                                           surname,
                                           phone_number,
                                           post_id,
                                           ch_staff_id,
                                           ch_dt)
    SELECT _staff_id,
           _name,
           _surname,
           _phone_number,
           _post_id,
           _ch_staff_id,
           _ch_dt
    ON CONFLICT (staff_id) DO UPDATE
        SET name         = excluded.name,
            surname      = excluded.surname,
            phone_number = excluded.phone_number,
            post_id      = excluded.post_id,
            ch_staff_id  = excluded.ch_staff_id,
            ch_dt        = excluded.ch_dt;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;