CREATE TABLE IF NOT EXISTS history.issuedschanges
(
    log_id      BIGSERIAL      NOT NULL,
    issued_id   BIGINT         NOT NULL,
    user_id     INT            NOT NULL,
    return_date DATE           NOT NULL,
    is_returned BOOLEAN        NOT NULL,
    deposit     NUMERIC(15, 2) NOT NULL,
    ch_staff_id INT            NOT NULL,
    ch_dt       TIMESTAMPTZ    NOT NULL
);