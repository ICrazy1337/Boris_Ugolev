CREATE OR REPLACE FUNCTION dictionary.subscriptionstypes_upd(_src JSONB) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _type_id SMALLINT;
    _name    VARCHAR(64);
    _months  INT;
    _price   NUMERIC(15, 2);
BEGIN
    SELECT coalesce(s1.type_id, nextval('dictionary.subscribestypes_type_id_seq')) as type_id,
           s1.name,
           s1.months,
           s1.price
    INTO _type_id, _name, _months, _price
    FROM jsonb_to_record(_src) AS s (type_id SMALLINT,
                                     name VARCHAR(64),
                                     months INT,
                                     price NUMERIC(15, 2))
             LEFT JOIN dictionary.subscribestypes s1 ON s1.type_id = s.type_id;

    INSERT INTO dictionary.subscribestypes AS ec (type_id, name, months, price)
    SELECT _type_id, _name, _months, _price
    ON CONFLICT (type_id) DO UPDATE
        SET name   = excluded.name,
            months = excluded.months,
            price  = excluded.price;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;