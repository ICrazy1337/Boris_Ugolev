CREATE TABLE IF NOT EXISTS dictionary.penaltiestypes
(
    type_id SMALLSERIAL NOT NULL
        CONSTRAINT pk_pentype PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    amount NUMERIC(15,2)
);

INSERT INTO dictionary.penaltiestypes (name, amount)
VALUES
    ('Просроченый возврат', 199.00),
    ('Порча', 499.00),
    ('Кража', 999.00);