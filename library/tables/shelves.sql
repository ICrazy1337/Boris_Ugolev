CREATE TABLE IF NOT EXISTS library.shelves
(
    shelf_id SMALLSERIAL   NOT NULL
        CONSTRAINT pk_shelf PRIMARY KEY,
    room_id SMALLINT NOT NULL,
    genre_id INT NOT NULL,
    name VARCHAR(64) NOT NULL
);