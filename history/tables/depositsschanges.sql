CREATE TABLE IF NOT EXISTS history.deposits
(
    log_id BIGINT NOT NULL,
    book_id INT NOT NULL,
    deposit NUMERIC(15,2) NOT NULL,
    ch_staff_id INT NOT NULL,
    ch_dt TIMESTAMPTZ NOT NULL
);