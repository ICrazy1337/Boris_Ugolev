CREATE OR REPLACE FUNCTION humanresource.user_upd(_src JSONB, _staff_id INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _dt          TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
BEGIN


    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;