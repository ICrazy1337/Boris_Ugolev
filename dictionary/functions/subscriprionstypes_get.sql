CREATE OR REPLACE FUNCTION dictionary.subscribestypes_get() RETURNS jsonb
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT s.type_id, s.name, s.months, s.price
              FROM dictionary.subscribestypes s) res;
END
$$;