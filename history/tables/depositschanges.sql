CREATE TABLE IF NOT EXISTS history.depositschanges
(
    log_id      BIGSERIAL      NOT NULL
        CONSTRAINT pk_depositschanges PRIMARY KEY,
    book_id     INT            NOT NULL,
    deposit     NUMERIC(15, 2) NOT NULL,
    ch_staff_id INT            NOT NULL,
    ch_dt       TIMESTAMPTZ    NOT NULL
);