CREATE TABLE IF NOT EXISTS humanresource.subscribers
(
    user_id INT NOT NULL,
    type_id INT NOT NULL,
    is_active BOOLEAN NOT NULL,
    ch_staff_id INT NOT NULL,
    ch_dt TIMESTAMPTZ NOT NULL,
    CONSTRAINT uq_subscribes UNIQUE (user_id, type_id, ch_dt)
);