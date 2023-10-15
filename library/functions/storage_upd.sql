CREATE OR REPLACE FUNCTION library.storage_upd(_src JSONB) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _name;
    _shelvescount INT;
    _placescount INT;
    _cellscount INT;
BEGIN
    SELECT nextval('library.library_sq'), generate_series(5,10);

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;
