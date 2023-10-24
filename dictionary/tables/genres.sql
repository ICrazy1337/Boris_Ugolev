CREATE TABLE IF NOT EXISTS dictionary.genres
(
    genre_id SMALLSERIAL  NOT NULL
        CONSTRAINT pk_genre PRIMARY KEY,
    name     VARCHAR(128) NOT NULL
);

INSERT INTO dictionary.genres (name)
VALUES ('Фантастика'),
       ('Роман'),
       ('Детектив'),
       ('Приключения'),
       ('Нон-фикшн'),
       ('Фэнфик'),
       ('Экономика'),
       ('Философия'),
       ('Эпическая поэзия'),
       ('Документальная литература'),
       ('Психология'),
       ('Юридическая литература'),
       ('Путешествия'),
       ('Кулинария'),
       ('Спорт'),
       ('Наука'),
       ('Фольклор'),
       ('Любовное фэнтези'),
       ('Психологический триллер');