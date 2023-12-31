CREATE TABLE IF NOT EXISTS humanresource.staff
(
    staff_id     INT         NOT NULL
        CONSTRAINT pk_staff PRIMARY KEY,
    name         VARCHAR(64) NOT NULL,
    surname      VARCHAR(64) NOT NULL,
    phone_number VARCHAR(11) NOT NULL
        CONSTRAINT uq_staff UNIQUE,
    post_id      INT         NOT NULL,
    ch_staff_id  INT         NOT NULL,
    ch_dt        TIMESTAMPTZ NOT NULL
);