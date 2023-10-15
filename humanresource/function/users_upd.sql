CREATE OR REPLACE FUNCTION humanresource.usersupd(_src JSONB, _staff_id INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _user_id      INT;
    _name         VARCHAR(64);
    _surname      VARCHAR(64);
    _phone_number VARCHAR(11);
    _birth_day    DATE;
    _dt           TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
BEGIN
    SELECT COALESCE(ur.user_id, nextval('humanresource.user_sq')) AS user_id,
           s.name,
           s.surname,
           s.phone_number,
           s.birth_day
    INTO _user_id, _name, _surname, _phone_number, _birth_day
    FROM jsonb_to_record(_src) AS s (user_id int,
                                     name varchar(64),
                                     surname varchar(64),
                                     phone_number varchar(11),
                                     birth_day date)
             LEFT JOIN humanresource.users ur
                       ON ur.user_id = s.user_id;
    WITH ins_cte AS (
        INSERT INTO humanresource.users AS ec (user_id,
                                               name,
                                               surname,
                                               phone_number,
                                               birth_day,
                                               ch_staff_id,
                                               ch_dt)
            SELECT _user_id,
                   _name,
                   _surname,
                   _phone_number,
                   _birth_day,
                   _staff_id,
                   _dt
            ON CONFLICT (user_id) DO UPDATE
                SET name = excluded.name,
                    surname = excluded.surname,
                    phone_number = excluded.phone_number,
                    birth_day = excluded.birth_day,
                    ch_staff_id = excluded.ch_staff_id,
                    ch_dt = excluded.ch_dt
            RETURNING ec.*)

    INSERT INTO history.userschanges   (user_id,
                                        name,
                                        surname,
                                        phone_number,
                                        birth_day,
                                        ch_staff_id,
                                        ch_dt)
    SELECT ic.user_id,
           ic.name,
           ic.surname,
           ic.phone_number,
           ic.birth_day,
           ic.ch_staff_id,
           ic.ch_dt
    FROM ins_cte ic;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;