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
    _ch_dt       TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
BEGIN
    SELECT COALESCE(st.staff_id, nextval('humanresource.staff_sq')) AS staff_id,
           name,
           surname,
           phone_number,
           post_id
    INTO _staff_id, _name, _surname, _phone_number, _post_id
    FROM jsonb_to_record(_src) AS s (staff_id INT,
                                     name VARCHAR(64),
                                     surname VARCHAR(64),
                                     phone_number VARCHAR(11),
                                     post_id INT)
             LEFT JOIN humanresource.staff st
                       ON st.staff_id = s.staff_id;

    IF NOT EXISTS (SELECT 1 FROM dictionary.posts p where p.post_id = _post_id) THEN
        RETURN public.errmessage(_errcode := 'humanresource.staff_upd.post_id',
                                 _msg := 'Нет такой должности!',
                                 _detail := concat('post_id = ', _post_id));
    END IF;

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
                SET name = excluded.name,
                    surname = excluded.surname,
                    phone_number = excluded.phone_number,
                    post_id = excluded.post_id,
                    ch_staff_id = excluded.ch_staff_id,
                    ch_dt = excluded.ch_dt;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;