CREATE TABLE IF NOT EXISTS dictionary.penaltiestypes
(
    type_id SMALLSERIAL NOT NULL
        CONSTRAINT pk_pentype PRIMARY KEY,
    name    VARCHAR(64) NOT NULL,
    amount  NUMERIC(15, 2)
        CONSTRAINT ck_amount CHECK ( amount >= 0 )
);