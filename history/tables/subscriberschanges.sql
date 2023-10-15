CREATE TABLE IF NOT EXISTS history.subscriberschanges
(
    log_id      BIGSERIAL   NOT NULL
        CONSTRAINT pk_subscriberschanges PRIMARY KEY,
    user_id     INT         NOT NULL,
    type_id     INT         NOT NULL,
    is_active   BOOLEAN     NOT NULL,
    ch_staff_id INT         NOT NULL,
    ch_dt       TIMESTAMPTZ NOT NULL
);