CREATE TABLE IF NOT EXISTS dictionary.posts
(
    post_id SMALLSERIAL    NOT NULL
        CONSTRAINT pk_post PRIMARY KEY,
    name    VARCHAR(128)   NOT NULL,
    salary  NUMERIC(15, 2) NOT NULL
        CONSTRAINT ck_salary CHECK ( salary > 0 )
);