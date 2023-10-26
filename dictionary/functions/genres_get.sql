CREATE OR REPLACE FUNCTION dictionary.genres_get() RETURNS jsonb
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT g.genre_id, g.name, g.genre_id, g.name
              FROM dictionary.genres g) res;
END
$$;