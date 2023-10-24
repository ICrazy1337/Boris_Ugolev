CREATE OR REPLACE FUNCTION library.books_get(_name VARCHAR(128)) RETURNS jsonb
SECURITY DEFINER
LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT book_id,
                     name,
                     author,
                     genre_id,
                     description,
                     cell_id,
                     is_available
              FROM library.books b WHERE b.name = coalesce(_name, b.name)) res;
END
$$;