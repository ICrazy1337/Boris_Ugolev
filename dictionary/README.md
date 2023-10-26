# SCHEMA `dictionary`

---

## TABLE `genre`

<table>
    <tr>
        <th>Атрибут</th>
        <th>Описание</th>
    </tr>
    <tr>
        <td>genre_id INT NOT NULL</td>
        <td>Идентификатор жанра</td>
    </tr>
    <tr>
        <td>name VARCHAR(128) NOT NULL</td>
        <td>Название жанра</td>
    </tr>
</table>

### Жанры

```sql
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
       (19, 'Психологический триллер') ON CONFLICT DO NOTHING;
```

### Функция `dictionary.genres_get()`

#### Функция dictionary.genres_get() выводит список всех жанров

#### Пример вызова

```sql
SELECT dictionary.genres_get();
```

#### Вывод

```json
{
  "data": [
    {
      "name": "Фантастика",
      "genre_id": 1
    },
    {
      "name": "Роман",
      "genre_id": 2
    },
    {
      "name": "Детектив",
      "genre_id": 3
    }
    и
    тд
  ]
}
```

---

## TABLE `penaltiestypes`

<table>
    <tr>
        <th>Атрибут</th>
        <th>Описание</th>
    </tr>
    <tr>
        <td>type_id SMALLSERIAL NOT NULL</td>
        <td>Идентификатор типа штрафа</td>
    </tr>
    <tr>
        <td>name VARCHAR(64) NOT NULL</td>
        <td>Описание штрафа</td>
    </tr>
    <tr>
        <td>amount NUMERIC(15, 2) NOT NULL</td>
        <td>Сумма штрафа</td>
    </tr>
</table>

### Функция `dictionary.penaltiestypes_upd(_src jsonb)`

#### Функция dictionary.penaltiestypes_upd() служит для добавления новых типов штрафов

- _src - json содержащий данные о типе штафа

#### Пример вызова

```sql
SELECT dictionary.penaltiestypes_upd('{
  "type_id": 1,
  "name": "Просроченная дата возврата",
  "amount": 500
}');
```

#### Результат правильного выполнения

```json
{
  "data": NULL
}
```

### Функция `dictionary.penaltiestypes_get()`

#### Функция dictionary.penaltiestypes_get() выводит список всех типов штрафов

#### Пример вызова

```sql
SELECT dictionary.penaltiestypes_get();
```

#### Вывод

```json
{
  "data": NULL
}
```

## TABLE `posts`

<table>
    <tr>
        <th>Атрибут</th>
        <th>Описание</th>
    </tr>
    <tr>
        <td>post_id SMALLSERIAL NOT NULL</td>
        <td>Идентификатор типа должности</td>
    </tr>
    <tr>
        <td>name VARCHAR(64) NOT NULL</td>
        <td>Название должности</td>
    </tr>
    <tr>
        <td>salary NUMERIC(15, 2) NOT NULL</td>
        <td>Зарплата на данной должности</td>
    </tr>
</table>

### Функция `dictionary.posts_upd(_src jsonb)`

#### Функция dictionary.posts_upd() служит для добавления новых типов должностей

- _src - json содержащий данные о должности

#### Пример вызова

```sql
SELECT dictionary.posts_upd('{
  "post_id": 1,
  "name": "Администратор",
  "salary": 50000
}');
```

#### Результат правильного выполнения

```json
{
  "data": NULL
}
```

### Функция `dictionary.posts_get()`

#### Функция dictionary.posts_get() выводит список всех должностей

#### Пример вызова

```sql
SELECT dictionary.posts_get();
```

#### Вывод

```json
{
  "data": NULL
}
```

---

## TABLE `subsriptionstypes`

<table>
    <tr>
        <th>Атрибут</th>
        <th>Описание</th>
    </tr>
    <tr>
        <td>type_id SMALLSERIAL NOT NULL</td>
        <td>Идентификатор типа подписки</td>
    </tr>
    <tr>
        <td>name VARCHAR(64) NOT NULL</td>
        <td>Название подписки</td>
    </tr>
    <tr>
        <td>month INT NOT NULL</td>
        <td>Количество месяцев длительности подписки</td>
    </tr>
    <tr>
        <td>price NUMERIC(15, 2) NOT NULL</td>
        <td>Стоимость подписки</td>
    </tr>
</table>

### Функция `dictionary.subscriptionstypes_upd(_src jsonb)`

#### Функция dictionary.subsriptionstypes_upd() служит для добавления новых типов подписок

- _src - json содержащий данные о типе подписки

#### Пример вызова

```sql
SELECT dictionary.subscriptionstypes_upd('{
  "type_id": 1,
  "name": "Месячная",
  "months": 1,
  "price": 50000
}');
```

#### Результат правильного выполнения

```json
{
  "data": NULL
}
```

### Функция `dictionary.subscriptionstypes_get()`

#### Функция dictionary.subsriptionstypes_get() выводит список всех должностей

#### Пример вызова

```sql
SELECT dictionary.subsriptionstypes_get();
```

#### Вывод

```json
{
  "data": NULL
}
```
