CREATE OR REPLACE PROCEDURE history.drop_partitions(_table_name TEXT)
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _partition_name TEXT;
    _min_date DATE;
BEGIN
    _min_date := NOW() - '3 months'::INTERVAL;
    FOR _partition_name IN
        SELECT table_name
        FROM information_schema.tables
        WHERE table_schema = 'history' AND table_name LIKE _table_name || '_%' AND _table_name != table_name
    LOOP
        IF ((SUBSTRING(_partition_name FROM '(\d{4}_\d{2})') || '_01')::DATE < _min_date) THEN
            EXECUTE 'DROP TABLE history.' || _partition_name || ' CASCADE';
        END IF;
    END LOOP;
END
$$;