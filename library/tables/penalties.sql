CREATE TABLE IF NOT EXISTS library.penalties
(
    penalty_id  INT         NOT NULL
        CONSTRAINT pk_penalty PRIMARY KEY,
    type_id     INT         NOT NULL,
    issued_id   INT         NOT NULL,
    ch_staff_id INT         NOT NULL,
    ch_dt       TIMESTAMPTZ NOT NULL
);