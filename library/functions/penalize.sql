CREATE OR REPLACE PROCEDURE library.penalize(_type_id INT, _ch_staff_id INT)
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _ch_dt TIMESTAMPTZ := NOW() AT TIME ZONE 'Europe/Moscow';
BEGIN
    INSERT INTO library.penalties AS a (type_id, issued_id, ch_staff_id, ch_dt)
    SELECT _type_id,
           i.issued_id,
           _ch_staff_id,
           _ch_dt
    FROM library.issueds i
    WHERE i.return_date < _ch_dt::DATE
      AND NOT EXISTS(SELECT 1 FROM library.penalties p WHERE p.issued_id = i.issued_id) AND i.is_returned = FALSE;
END
$$;