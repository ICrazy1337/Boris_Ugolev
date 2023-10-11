CREATE TABLE IF NOT EXISTS humanresource.subscribes
(
    user_id INT NOT NULL,
    type_id INT NOT NULL,
    is_active BOOLEAN NOT NULL,
    ch_staff_id INT NOT NULL,
    ch_dt TIMESTAMPTZ NOT NULL
);