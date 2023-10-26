CREATE OR REPLACE FUNCTION library.books_get(_name VARCHAR(128)) RETURNS jsonb
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT b.book_id,
                     b.name,
                     b.author,
                     b.genre_id,
                     b.description,
                     b.cell_id,
                     b.is_available
              FROM library.books b
              WHERE b.name = coalesce(_name, b.name)) res;
END
$$;