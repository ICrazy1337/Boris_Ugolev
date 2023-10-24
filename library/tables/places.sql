CREATE TABLE IF NOT EXISTS library.places
(
    place_id SMALLSERIAL NOT NULL
        CONSTRAINT pk_place PRIMARY KEY,
    shelf_id SMALLINT    NOT NULL,
    genre_id INT         NOT NULL
);