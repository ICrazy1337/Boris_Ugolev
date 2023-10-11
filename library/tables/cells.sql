CREATE TABLE IF NOT EXISTS library.cells
(
    cell_id SMALLSERIAL NOT NULL
        CONSTRAINT pk_cell_id PRIMARY KEY,
    place_id SMALLINT NOT NULL
);