CREATE TABLE IF NOT EXISTS library.rooms
(
    room_id SMALLSERIAL NOT NULL
        CONSTRAINT pk_room PRIMARY KEY,
    name VARCHAR(64) NOT NULL
);