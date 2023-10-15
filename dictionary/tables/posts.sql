CREATE TABLE IF NOT EXISTS dictionary.posts
(
    post_id SMALLSERIAL NOT NULL
        CONSTRAINT pk_post PRIMARY KEY,
    name VARCHAR(128) NOT NULL,
    salary NUMERIC(15,2) NOT NULL
);

INSERT INTO dictionary.posts (name, salary)
VALUES
    ('Администратор', 70000.00),
    ('Менеджер', 55000.00),
    ('Бухгалтер', 55000.00);