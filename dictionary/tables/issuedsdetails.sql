CREATE TABLE IF NOT EXISTS dictionary.issuedsdetails
(
    issued_id INT NOT NULL,
    book_id INT NOT NULL,
    is_returned BOOLEAN NOT NULL,
    deposit_paid BOOLEAN NOT NULL
);