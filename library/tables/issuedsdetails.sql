CREATE TABLE IF NOT EXISTS library.issuedsdetails
(
    issued_id INT NOT NULL,
    book_id INT NOT NULL,
    is_returned BOOLEAN NOT NULL,
    deposit_paid BOOLEAN NOT NULL,
    CONSTRAINT uq_subscribes UNIQUE (issued_id, book_id)
);