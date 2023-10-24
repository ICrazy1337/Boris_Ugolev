CREATE OR REPLACE FUNCTION dictionary.posts_get() RETURNS jsonb
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT p.post_id, p.name, p.salary
              FROM dictionary.posts p) res;
END
$$;