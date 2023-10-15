CREATE TABLE IF NOT EXISTS dictionary.subscribestypes
(
    type_id SMALLSERIAL NOT NULL
        CONSTRAINT pk_subtype PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    month SMALLINT NOT NULL,
    price NUMERIC(15,2) NOT NULL
);

INSERT INTO dictionary.subscribestypes (name, month, price)
VALUES
    ('Ежемесячная', 1, 199.99),
    ('Ежеквартальная', 3, 459.00),
    ('Годовая', 12, 1459.00),
    ('Пробный', 1, 0.00);