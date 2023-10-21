CREATE TABLE IF NOT EXISTS library.books
(
    book_id      INT          NOT NULL
        CONSTRAINT pk_book PRIMARY KEY,
    name         VARCHAR(128) NOT NULL,
    author       VARCHAR(128) NOT NULL,
    genre_id     INT          NOT NULL,
    description  VARCHAR(320) NOT NULL,
    cell_id      INT          NOT NULL
        CONSTRAINT uq_cell UNIQUE,
    is_available BOOLEAN      NOT NULL
);