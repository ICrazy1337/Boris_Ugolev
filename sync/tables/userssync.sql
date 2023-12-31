CREATE TABLE IF NOT EXISTS sync.userssync
(
    log_id       BIGSERIAL   NOT NULL
        CONSTRAINT pk_userssync PRIMARY KEY,
    user_id      INT         NOT NULL,
    name         VARCHAR(64) NOT NULL,
    surname      VARCHAR(64) NOT NULL,
    phone_number VARCHAR(11) NOT NULL,
    birth_day    DATE        NOT NULL,
    ch_staff_id  INT         NOT NULL,
    ch_dt        TIMESTAMPTZ NOT NULL,
    sync_dt      TIMESTAMPTZ NOT NULL
);