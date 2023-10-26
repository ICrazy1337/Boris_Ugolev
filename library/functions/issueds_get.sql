CREATE OR REPLACE FUNCTION library.issueds_get(_user_id INT) RETURNS jsonb
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT DISTINCT b.issued_id,
                              (SELECT jsonb_agg(book_id)
                               FROM library.issuedsbooks i1
                               WHERE i1.issued_id = i.issued_id) AS book_id,
                              b.user_id,
                              b.return_date,
                              b.is_returned,
                              b.deposit,
                              b.ch_staff_id,
                              b.ch_dt
              FROM library.issueds b
                       JOIN library.issuedsbooks i on b.issued_id = i.issued_id
              WHERE b.user_id = coalesce(_user_id, b.user_id)) res;
END
$$;