CREATE TABLE IF NOT EXISTS dictionary.genres
(
    genre_id SMALLSERIAL NOT NULL
        CONSTRAINT pk_genre PRIMARY KEY,
    name VARCHAR(128) NOT NULL
);