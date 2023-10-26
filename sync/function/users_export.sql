CREATE OR REPLACE FUNCTION sync.users_export(_log_id BIGINT) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
DECLARE
    _dt  TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
    _res JSONB;
BEGIN
    DELETE
    FROM sync.userssync cs
    WHERE cs.log_id <= _log_id
      AND cs.sync_dt IS NOT NULL;

    WITH sync_cte AS (SELECT us.log_id,
                             us.user_id,
                             us.name,
                             us.surname,
                             us.phone_number,
                             us.birth_day,
                             us.ch_staff_id,
                             us.ch_dt,
                             us.sync_dt
                      FROM sync.userssync us
                      ORDER BY us.log_id
                      LIMIT 1000)

       , cte_upd AS (
        UPDATE sync.userssync cs
            SET sync_dt = _dt
            FROM sync_cte sc
            WHERE cs.log_id = sc.log_id)

    SELECT JSONB_BUILD_OBJECT('data', JSONB_AGG(ROW_TO_JSON(sc)))
    INTO _res
    FROM sync_cte sc;

    RETURN _res;
END
$$;