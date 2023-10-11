CREATE TABLE IF NOT EXISTS dictionary.posts
(
    post_id SMALLSERIAL NOT NULL,
    name VARCHAR(128) NOT NULL,
    salary NUMERIC(15,2) NOT NULL
);