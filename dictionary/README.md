# SCHEMA dictionary
# Справочники

### Справочник депозитов
```sql
CREATE TABLE IF NOT EXISTS dictionary.deposits
(
    book_id INT NOT NULL,
    deposit NUMERIC(15,2) NOT NULL,
    ch_staff_id INT NOT NULL,
    ch_dt TIMESTAMPTZ NOT NULL
);
```
### Справочник жанров
```sql
CREATE TABLE IF NOT EXISTS dictionary.genres
(
    genre_id SMALLSERIAL NOT NULL
        CONSTRAINT pk_genre PRIMARY KEY,
    name VARCHAR(128) NOT NULL
);

INSERT INTO dictionary.genres (name)
VALUES
    ('Фантастика'),
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
```
### Справочник типов штрафов
```sql
CREATE TABLE IF NOT EXISTS dictionary.penaltiestypes
(
    type_id SMALLSERIAL NOT NULL
        CONSTRAINT pk_pentype PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    amount NUMERIC(15,2)
);

INSERT INTO dictionary.penaltiestypes (name, amount)
VALUES
    ('Просроченый возврат', 199.00),
    ('Порча', 499.00),
    ('Кража', 999.00);
```
### Справочник должностей
```sql
CREATE TABLE IF NOT EXISTS dictionary.posts
(
    post_id SMALLSERIAL NOT NULL
        CONSTRAINT pk_post PRIMARY KEY,
    name VARCHAR(128) NOT NULL,
    salary NUMERIC(15,2) NOT NULL
);

INSERT INTO dictionary.posts (name, salary)
VALUES
    ('Администратор', 70000.00),
    ('Менеджер', 55000.00),
    ('Бухгалтер', 55000.00);
```
### Справочник типов подписок
```sql
CREATE TABLE IF NOT EXISTS dictionary.subscribestypes
(
    type_id SMALLSERIAL NOT NULL
        CONSTRAINT pk_subtype PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    month SMALLINT NOT NULL,
    price NUMERIC(15,2) NOT NULL
);

INSERT INTO dictionary.subscribestypes (name, month, price)
VALUES
    ('Ежемесячная', 1, 199.99),
    ('Ежеквартальная', 3, 459.00),
    ('Годовая', 12, 1459.00),
    ('Пробный', 1, 0.00);
```
### Работа с депозитами
```sql
select dictionary.deposits_upd('{
  "book_id": 1,
  "deposit": 299.00}', 2542);
```
##### Работа с депозитами