CREATE OR REPLACE FUNCTION dictionary.deposits_upd(_src JSONB, _staff_id INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _book_id INT;
    _deposit NUMERIC(15, 2);
    _dt      TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
BEGIN
    SELECT s.book_id, s.deposit
    INTO _book_id, _deposit
    FROM jsonb_to_record(_src) AS s (book_id INT, deposit NUMERIC(15, 2));

    IF NOT EXISTS (SELECT 1 FROM library.books p WHERE p.book_id = _book_id) THEN
        RETURN public.errmessage(_errcode := 'dictionary.deposits_upd.book_id',
                                 _msg := 'Книга не найдена!',
                                 _detail := concat('book_id = ', _book_id));
    END IF;

    WITH ins_cte AS (
        INSERT INTO dictionary.deposits AS ec (book_id, deposit, ch_staff_id, ch_dt)
            SELECT _book_id, _deposit, _staff_id, _dt
            ON CONFLICT (book_id) DO UPDATE
                SET deposit = excluded.deposit,
                    ch_staff_id = excluded.ch_staff_id,
                    ch_dt = excluded.ch_dt
            RETURNING ec.*)

    INSERT
    INTO history.depositschanges (book_id, deposit, ch_staff_id, ch_dt)
    SELECT ic.book_id, ic.deposit, ic.ch_staff_id, ic.ch_dt
    FROM ins_cte ic;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;