CREATE OR REPLACE PROCEDURE library.penalize(_type_id INT, _ch_staff_id INT)
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _ch_dt TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
BEGIN
    INSERT INTO library.penalties AS a (type_id, issued_id, ch_staff_id, ch_dt)
    SELECT _type_id,
           i.issued_id,
           _ch_staff_id,
           _ch_dt
    FROM library.issueds i
    WHERE i.return_date < _ch_dt AND i.issued_id NOT IN (SELECT issued_id FROM library.penalties);

END
$$;