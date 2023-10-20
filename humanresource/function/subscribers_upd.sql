CREATE OR REPLACE FUNCTION humanresource.subscribers_upd(_src JSONB, _staff_id INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _user_id INT;
    _type_id INT;
    _months INTERVAL;
    _end_dt TIMESTAMPTZ;
BEGIN
    SELECT user_id, type_id
    INTO _user_id, _type_id
    FROM jsonb_to_record(_src) AS s (user_id INT, type_id INT);

    IF NOT EXISTS (SELECT 1 FROM humanresource.users p where p.user_id = _user_id) THEN
        RETURN public.errmessage(_errcode := 'humanresource.subscribers_upd.user_id',
                                 _msg := 'Нет такого пользователя!',
                                 _detail := concat('user_id = ', _user_id));
    END IF;

    IF NOT EXISTS (SELECT 1 FROM dictionary.subscribestypes p where p.type_id = _type_id) THEN
        RETURN public.errmessage(_errcode := 'dictionary.subscribestypes.type_id',
                                 _msg := 'Нет такой подписки!',
                                 _detail := concat('type_id = ', _type_id));
    END IF;

    SELECT months INTO _months FROM dictionary.subscribestypes WHERE type_id = _type_id;

    SELECT now() + _months INTO _end_dt;

    WITH ins_cte AS (
        INSERT INTO humanresource.subscribers AS ec (user_id, type_id, staff_id, end_dt)
            SELECT _user_id, _type_id, _staff_id, _end_dt
            ON CONFLICT (user_id) DO UPDATE
                SET type_id = excluded.type_id,
                    staff_id = excluded.staff_id,
                    end_dt = excluded.end_dt +
                             (SELECT months FROM dictionary.subscribestypes s WHERE s.type_id = _type_id)
            RETURNING ec.*
    )

    INSERT INTO history.subscriberschanges (user_id, type_id, staff_id, ch_dt)
    SELECT ic.user_id, ic.type_id, ic.staff_id, now() AT TIME ZONE 'Europe/Moscow'
    FROM ins_cte ic;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;