CREATE TABLE IF NOT EXISTS library.issueds
(
    issued_id   BIGINT         NOT NULL
        CONSTRAINT pk_issued PRIMARY KEY,
    user_id     INT            NOT NULL,
    return_date DATE           NOT NULL,
    is_returned BOOLEAN        NOT NULL,
    deposit     NUMERIC(15, 2) NOT NULL,
    ch_staff_id INT            NOT NULL,
    ch_dt       TIMESTAMPTZ    NOT NULL
);