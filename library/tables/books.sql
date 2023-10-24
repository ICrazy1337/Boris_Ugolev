CREATE TABLE IF NOT EXISTS library.books
(
    book_id      INT            NOT NULL
        CONSTRAINT pk_book PRIMARY KEY,
    name         VARCHAR(128)   NOT NULL,
    author       VARCHAR(128)   NOT NULL,
    genre_id     INT            NOT NULL,
    description  VARCHAR(320)   NOT NULL,
    cell_id      INT            NOT NULL
        CONSTRAINT uq_cell UNIQUE,
    deposit      NUMERIC(15, 2) NULL
        CONSTRAINT ch_deposit CHECK ( deposit >= 0 ),
    is_available BOOLEAN        NOT NULL
);

CREATE INDEX ix_book_name ON library.books (name)
    INCLUDE (author,description)