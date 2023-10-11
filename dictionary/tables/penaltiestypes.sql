CREATE TABLE IF NOT EXISTS dictionary.penaltiestypes
(
    type_id SMALLSERIAL NOT NULL,
    name VARCHAR(64) NOT NULL,
    amount NUMERIC(15,2)
);