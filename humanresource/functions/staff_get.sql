CREATE OR REPLACE FUNCTION humanresource.staff_get(_phone_number VARCHAR(11)) RETURNS jsonb
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT staff_id, name, surname, phone_number, post_id, ch_staff_id, ch_dt
              FROM humanresource.staff s
              WHERE s.phone_number = COALESCE(_phone_number, s.phone_number)) res;
END
$$;