CREATE TABLE IF NOT EXISTS library.bookcells
(
    book_id INT NOT NULL
        CONSTRAINT uq_book UNIQUE,
    cell_id INT NOT NULL
);