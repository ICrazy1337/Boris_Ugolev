CREATE OR REPLACE FUNCTION dictionary.subscriptionstypes_upd(_src JSONB) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _type_id SMALLINT;
    _name    VARCHAR(64);
    _months  SMALLINT;
    _price   NUMERIC(15, 2);
BEGIN
    SELECT type_id, name, months, price
    INTO _type_id, _name, _months, _price
    FROM jsonb_to_record(_src) AS s (type_id SMALLINT,
                                     name VARCHAR(64),
                                     months SMALLINT,
                                     price NUMERIC(15, 2));

    INSERT INTO dictionary.subscribestypes AS ec (type_id, name, months, price)
    SELECT _type_id, _name, _months, _price
    ON CONFLICT (type_id) DO UPDATE
        SET name   = excluded.name,
            months = excluded.months,
            price  = excluded.price;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;