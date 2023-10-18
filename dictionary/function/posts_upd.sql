CREATE OR REPLACE FUNCTION dictionary.posts_upd(_src JSONB) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _post_id SMALLINT;
    _name VARCHAR(128);
    _salary NUMERIC(15,2);
BEGIN
    SELECT post_id, name, salary
    INTO _post_id, _name, _salary
    FROM jsonb_to_record(_src) AS s (post_id SMALLINT,
                                     name VARCHAR(128),
                                     salary NUMERIC(15, 2));

    INSERT INTO dictionary.posts AS ec (post_id, name, salary)
    SELECT _post_id, _name, _salary
    ON CONFLICT (post_id) DO UPDATE
        SET name     = excluded.name,
            salary      = excluded.salary;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;