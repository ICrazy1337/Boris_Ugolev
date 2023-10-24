CREATE OR REPLACE FUNCTION library.penalties_get(_issued_id INT) RETURNS jsonb
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT penalty_id,
                     type_id,
                     issued_id,
                     ch_staff_id,
                     ch_dt
              FROM library.penalties p
              WHERE p.issued_id = coalesce(_issued_id, p.issued_id)) res;
END
$$;