CREATE TABLE IF NOT EXISTS dictionary.subscribestypes
(
    type_id SMALLSERIAL    NOT NULL
        CONSTRAINT pk_subscribestypes PRIMARY KEY,
    name    VARCHAR(64)    NOT NULL,
    months  INT            NOT NULL,
    price   NUMERIC(15, 2) NOT NULL
        CONSTRAINT ck_price CHECK ( price > 0 )
);
