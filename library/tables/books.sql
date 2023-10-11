CREATE TABLE IF NOT EXISTS library.books
(
    book_id INT NOT NULL
        CONSTRAINT pk_book_id PRIMARY KEY,
    genre_id INT NOT NULL,
    cell_id INT NOT NULL,
    name VARCHAR(128) NOT NULL,
    author VARCHAR(128) NOT NULL,
    desc VARCHAR(320) NOT NULL,
    is_available BOOLEAN NOT NULL
);