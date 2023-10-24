CREATE OR REPLACE FUNCTION sync.users_import(_src JSONB) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    SET TIME ZONE 'Europe/Moscow';

    WITH cte AS (SELECT s.user_id,
                        s.name,
                        s.surname,
                        s.phone_number,
                        s.birth_day,
                        s.ch_staff_id,
                        s.ch_dt,
                        ROW_NUMBER() over (PARTITION BY s.user_id ORDER BY s.ch_dt DESC) rn
                 FROM JSONB_TO_RECORDSET(_src) AS s (user_id INT,
                                                     name VARCHAR(64),
                                                     surname VARCHAR(64),
                                                     phone_number VARCHAR(11),
                                                     birth_day DATE,
                                                     ch_staff_id INT,
                                                     ch_dt TIMESTAMPTZ))

    INSERT
    INTO humanresource.users AS sd (user_id, name, surname, phone_number, birth_day, ch_staff_id, ch_dt)
    SELECT s.user_id, s.name, s.surname, s.phone_number, s.birth_day, s.ch_staff_id, s.ch_dt
    FROM cte s
    WHERE rn = 1
    ON CONFLICT (user_id) DO UPDATE
        SET name         = excluded.name,
            surname      = excluded.surname,
            phone_number = excluded.phone_number,
            birth_day    = excluded.birth_day,
            ch_staff_id  = excluded.ch_staff_id,
            ch_dt        = excluded.ch_dt
    WHERE sd.ch_dt <= excluded.ch_dt;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;