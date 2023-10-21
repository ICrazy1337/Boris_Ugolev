CREATE TABLE IF NOT EXISTS humanresource.subscribers
(
    user_id     INT         NOT NULL
        CONSTRAINT pk_subscribers PRIMARY KEY,
    type_id     INT         NOT NULL,
    staff_id INT         NOT NULL,
    end_dt       TIMESTAMPTZ NOT NULL
);