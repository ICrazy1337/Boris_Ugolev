CREATE TABLE IF NOT EXISTS history.bookschanges
(
    log_id       BIGSERIAL    NOT NULL
        CONSTRAINT pk_bookschanges PRIMARY KEY,
    book_id      INT          NOT NULL,
    name         VARCHAR(128) NOT NULL,
    author       VARCHAR(128) NOT NULL,
    genre_id     INT          NOT NULL,
    description  VARCHAR(320) NOT NULL,
    cell_id      INT          NOT NULL,
    is_available BOOLEAN      NOT NULL
);