CREATE OR REPLACE FUNCTION humanresource.subscribers_get(_type_id INT) RETURNS jsonb
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT s.user_id, s.type_id, s.staff_id, s.end_dt
              FROM humanresource.subscribers s
              WHERE s.type_id = COALESCE(_type_id, s.type_id)) res;
END
$$;