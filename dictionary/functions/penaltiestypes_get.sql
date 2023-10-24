CREATE OR REPLACE FUNCTION dictionary.penaltiestypes_get() RETURNS jsonb
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT p.type_id, p.name, p.amount
              FROM dictionary.penaltiestypes p) res;
END
$$;