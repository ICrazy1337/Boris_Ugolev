CREATE TABLE IF NOT EXISTS dictionary.genres
(
    genre_id SMALLSERIAL  NOT NULL
        CONSTRAINT pk_genre PRIMARY KEY,
    name     VARCHAR(128) NOT NULL
);

INSERT INTO dictionary.genres (genre_id, name)
VALUES (1, 'Фантастика'),
       (2, 'Роман'),
       (3, 'Детектив'),
       (4, 'Приключения'),
       (5, 'Нон-фикшн'),
       (6, 'Фэнфик'),
       (7, 'Экономика'),
       (8, 'Философия'),
       (9, 'Эпическая поэзия'),
       (10, 'Документальная литература'),
       (11, 'Психология'),
       (12, 'Юридическая литература'),
       (13, 'Путешествия'),
       (14, 'Кулинария'),
       (15, 'Спорт'),
       (16, 'Наука'),
       (17, 'Фольклор'),
       (18, 'Любовное фэнтези'),
       (19, 'Психологический триллер')
ON CONFLICT DO NOTHING;