CREATE TABLE IF NOT EXISTS library.issuedsbooks
(
    issued_id INT NOT NULL,
    book_id INT NOT NULL,
    dt TIMESTAMPTZ NOT NULL,
    CONSTRAINT pk_issuedsbooks PRIMARY KEY (issued_id, book_id)
);