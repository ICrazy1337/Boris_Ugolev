CREATE TABLE IF NOT EXISTS humanresource.user
(
    user_id INT NOT NULL
        CONSTRAINT pk_user PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    surname VARCHAR(64) NOT NULL,
    phone_number VARCHAR(11) NOT NULL,
    birth_day DATA NOT NULL,
    ch_staff_id INT NOT NULL,
    ch_dt TIMESTAMPTZ NOT NULL
);