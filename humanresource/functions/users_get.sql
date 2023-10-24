CREATE OR REPLACE FUNCTION humanresource.users_get() RETURNS jsonb
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT u.user_id, u.name, u.surname, u.phone_number, u.birth_day, u.ch_staff_id, u.ch_dt
              FROM humanresource.users u) res;
END
$$;