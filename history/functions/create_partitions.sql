CREATE OR REPLACE PROCEDURE history.create_partitions(_table_name TEXT)
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _start_date TIMESTAMPTZ := DATE_TRUNC('YEAR', NOW()) AT TIME ZONE 'Europe/Moscow';
    _end_date   TIMESTAMPTZ;
    _table      TEXT;
BEGIN
    FOR i IN 0..11
        LOOP
            _end_date := _start_date + interval '1 month';
            _table := 'history.' || _table_name || TO_CHAR(_start_date, '_YYYY_MM');
            IF (TO_REGCLASS(_table::TEXT) ISNULL) THEN
                EXECUTE FORMAT('CREATE TABLE ' || _table ||
                               ' PARTITION OF history.' || _table_name || ' FOR VALUES FROM (''' || _start_date ||
                               ''') TO (''' || _end_date || ''')');
            END IF;
            _start_date := _end_date;
        END LOOP;
END;
$$;

call history.create_partitions('subscriberschanges')