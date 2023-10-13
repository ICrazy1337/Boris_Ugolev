CREATE TABLE IF NOT EXISTS dictionary.subscribestypes
(
    type_id SMALLSERIAL NOT NULL
        CONSTRAINT pk_subtype PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    month SMALLINT NOT NULL,
    price NUMERIC(15,2)
);