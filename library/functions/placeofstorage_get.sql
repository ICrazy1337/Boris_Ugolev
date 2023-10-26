CREATE OR REPLACE FUNCTION library.placeofstorage_get(_book_id INT) RETURNS jsonb
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT b.book_id, c.cell_id, p.place_id, s.shelf_id, r.room_id
              FROM library.books b
                       JOIN library.cells c ON b.cell_id = c.cell_id
                       JOIN library.places p ON c.place_id = p.place_id
                       JOIN library.shelves s ON p.shelf_id = s.shelf_id
                       JOIN library.rooms r ON s.room_id = r.room_id
              WHERE b.book_id = coalesce(_book_id, b.book_id)) res;
END
$$;