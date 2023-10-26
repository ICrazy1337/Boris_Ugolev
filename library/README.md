# SCHEMA `library`

---

## TABLE `books`

<table>
    <tr>
        <th>Атрибут</th>
        <th>Описание</th>
    </tr>
    <tr>
        <td>book_id INT NOT NULL</td>
        <td>Идентификатор книги</td>
    </tr>
    <tr>
        <td>name VARCHAR(128) NOT NULL</td>
        <td>Название книги</td>
    </tr>
    <tr>
        <td>author VARCHAR(128) NOT NULL</td>
        <td>Фамилия сотрудника</td>
    </tr>
    <tr>
        <td>genre_id INT NOT NULL</td>
        <td>Идентификатор жанра</td>
    </tr>
    <tr>
        <td>description VARCHAR(320) NOT NULL</td>
        <td>Описание книги</td>
    </tr>
    <tr>
        <td>cell_id INT NOT NULL</td>
        <td>Идентификатор ячейки хранения</td>
    </tr>
    <tr>
        <td>deposit NUMERIC(15, 2) NULL</td>
        <td>Депозит внесенный</td>
    </tr>
    <tr>
        <td>is_available BOOLEAN NOT NULL</td>
        <td>Дата и время изменения</td>
    </tr>
</table>

### Функция `library.books_upd(_src JSONB)`

#### Функция library.bookd_upd() добавляет или изменяет данные о сотруднике

- _src - json содержащий данные о книге

#### Пример вызова

```sql
SELECT library.books_upd('{
  "name": "Какая-то книга",
  "author": "Алексей",
  "genre_id": 1,
  "description": "Что-то",
  "cell_id": 5,
  "is_available": false,
  "deposit": 300
}');
```

#### Вывод

```json
{
  "data": NULL
}
```

### Функция `library.books_get(_name VARCHAR(128))`

#### Функция library.book_get() вывод данные о книгах с определенным названием

- _name- название книги

#### Пример вызова

```sql
SELECT library.books_get('Какая-то книга');
```

#### Вывод

```json
{
  "data": [
    {
      "name": "Какая-то книга",
      "author": "Алексей",
      "book_id": 9,
      "cell_id": 2,
      "genre_id": 1,
      "description": "Что-то",
      "is_available": true
    },
    {
      "name": "Какая-то книга",
      "author": "Алексей",
      "book_id": 12,
      "cell_id": 1,
      "genre_id": 1,
      "description": "Что-то",
      "is_available": true
    },
    {
      "name": "Какая-то книга",
      "author": "Алексей",
      "book_id": 15,
      "cell_id": 5,
      "genre_id": 1,
      "description": "Что-то",
      "is_available": false
    }
  ]
}
```

---

## TABLE `issueds`

<table>
    <tr>
        <th>Атрибут</th>
        <th>Описание</th>
    </tr>
    <tr>
        <td>issued_id   BIGINT         NOT NULLL</td>
        <td>Идентификатор выдачи</td>
    </tr>
    <tr>
        <td>user_id     INT            NOT NULL</td>
        <td>Идентификатор пользователя</td>
    </tr>
    <tr>
        <td>    return_date DATE           NOT NULL</td>
        <td>Дата возврата</td>
    </tr>
    <tr>
        <td>is_returned BOOLEAN NOT NULL</td>
        <td>Возвращена или нет</td>
    </tr>
    <tr>
        <td>  deposit     NUMERIC(15, 2) NOT NULL</td>
        <td>Депозит выдачи</td>
    </tr>
    <tr>
        <td>ch_staff_id INT NOT NULL</td>
        <td>Идентификатор сотрудника, который создал или изменил данные</td>
    </tr>
    <tr>
        <td>ch_dt TIMESTAMPTZ NOT NULL</td>
        <td>Дата и время изменения</td>
    </tr>
</table>

### Функция `library.issueds_upd(_src JSONB, _ch_staff_id INT)`

#### Функция library.issueds_upd() добавляет или изменяет данные о выдаче

- _src - JSON с данными о выдаче
- _ch_staff_id - идентификатор сотрудника, произвевшего выдачу

#### Пример вызова

```sql
SELECT library.issueds_upd('{
  "books": [
    {
      "book_id": 9
    },
    {
      "book_id": 15
    }
  ],
  "user_id": 2,
  "return_date": "23-10-2023",
  "is_returned": false
}', 1111);
```

#### Вывод

```json
{
  "data": NULL
}
```

### Функция `library.issueds_get(_user_id INT)`

#### Функция library.issueds_get() добавляет или изменяет данные о пользователе

#### Пример вызова

```sql
SELECT library.issueds_get(2);
```

#### Вывод

```json
{
  "data": [
    {
      "ch_dt": "2023-10-26T00:05:27.597767+00:00",
      "book_id": [
        9,
        12
      ],
      "deposit": 0.00,
      "user_id": 2,
      "issued_id": 98,
      "ch_staff_id": 1111,
      "is_returned": false,
      "return_date": "2023-10-23"
    }
  ]
}
```

---

## TABLE `penalties`

<table>
    <tr>
        <th>Атрибут</th>
        <th>Описание</th>
    </tr>
    <tr>
        <td>penalty_id  BIGSERIAL   NOT NULL</td>
        <td>Идентификатор штрафа</td>
    </tr>
    <tr>
        <td>type_id     INT         NOT NULL</td>
        <td>Идентификатор типа штрафа</td>
    </tr>
    <tr>
        <td>issued_id   INT         NOT NULL</td>
        <td>Идентификатор оштрафованой выдачи</td>
    </tr>
    <tr>
        <td>ch_staff_id INT NOT NULL</td>
        <td>Идентификатор сотрудника, который создал или изменил данные</td>
    </tr>
    <tr>
        <td>ch_dt TIMESTAMPTZ NOT NULL</td>
        <td>Дата и время изменения</td>
    </tr>
</table>

### Функция `library.penalties_upd(_src JSONB, _ch_staff_id INT)`

#### Функция library.penalties_upd() добавляет или изменяет данные о штрафе

- _src - JSON, содержащий данные о штрафах выдач
- _ch_staff_id - идентификатор сотрудника добавившего или изменившегося штраф

#### Пример вызова

```sql
SELECT library.penalties_upd('{
  "type_id": 1,
  "issued_id": 98
}', 2542)
```

#### Вывод

```json
{
  "data": NULL
}
```

### Функция `library.penalties_get(_issued_id INT)`

#### Функция library.penalties_get() выводит штрафы по выдачи

- _issued_id - идентификатор выдачи

#### Пример вызова

```sql
SELECT library.penalties_get(98);
```

#### Вывод

```json
{
  "data": [
    {
      "ch_dt": "2023-10-26T11:40:33.25371+00:00",
      "type_id": 1,
      "issued_id": 98,
      "penalty_id": 20,
      "ch_staff_id": 2542
    }
  ]
}
```

### Функция `library.penalize(_type_id INT, _ch_staff_id INT)`

#### Функция library.penalize() - штрафует всех пользователей у которых просроченна дата возврата

- _type_id - идентификатор типа штрафа
- _ch_staff_id - идентификатор сотрудника выписавшего штраф

#### Пример вызова

```sql
CALL library.penalize(1, 2542);
```

---

## Система хранения

## TABLE `rooms`

<table>
    <tr>
        <th>Атрибут</th>
        <th>Описание</th>
    </tr>
    <tr>
        <td>room_id SMALLSERIAL NOT NULL</td>
        <td>Идентификатор комнаты</td>
    </tr>
    <tr>
        <td>name VARCHAR(64) NOT NULL</td>
        <td>Название комнаты</td>
    </tr>
</table>

## TABLE `shelves`

<table>
    <tr>
        <th>Атрибут</th>
        <th>Описание</th>
    </tr>
    <tr>
        <td>shelf_id SMALLSERIAL NOT NULL</td>
        <td>Идентификатор шкафа</td>
    </tr>
    <tr>
        <td>room_id  SMALLINT    NOT NULL</td>
        <td>Идентификатор комнаты</td>
    </tr>
</table>

## TABLE `places`

<table>
    <tr>
        <th>Атрибут</th>
        <th>Описание</th>
    </tr>
    <tr>
        <td>place_id SMALLSERIAL NOT NULL</td>
        <td>Идентификатор полки</td>
    </tr>
    <tr>
        <td>shelf_id  SMALLINT    NOT NULL</td>
        <td>Идентификатор шкафа</td>
    </tr>
    <tr>
        <td>genre_id INT NOT NULL</td>
        <td>Идентификатор жанра</td>
    </tr>
</table>

## TABLE `cells`

<table>
    <tr>
        <th>Атрибут</th>
        <th>Описание</th>
    </tr>
    <tr>
        <td>cell_id SMALLSERIAL NOT NULL</td>
        <td>Идентификатор полки</td>
    </tr>
    <tr>
        <td>place_id  SMALLINT    NOT NULL</td>
        <td>Идентификатор полки</td>
    </tr>
</table>

### Функция `library.rooms_upd(_src JSONB)`

#### Функция library.rooms_upd() добавляет или изменяет данные о комнате

- _src - json содержащий данные о комнате

#### Пример вызова

```sql
SELECT library.rooms_upd('{"name": "Читательская"}');
```

#### Вывод

```json
{
  "name": "Читательская",
  "room_id": 2
}
```

### Функция `library.shelves_upd(_src JSONB)`

#### Функция library.shelves_upd() добавляет или изменяет данные о шкафе

- _src - json содержащий данные о шкафе

#### Пример вызова

```sql
SELECT library.shelves_upd('{"room_id": 1}');
```

#### Вывод

```json
{
  "room_id": 1,
  "shelf_id": 2
}
```

### Функция `library.places_upd(_src JSONB)`

#### Функция library.places_upd() добавляет или изменяет данные о полке

- _src - json содержащий данные о полке

#### Пример вызова

```sql
SELECT library.places_upd('{"shelf_id": 1, "genre_id":  1}');
```

#### Вывод

```json
{
  "genre_id": 1,
  "place_id": 2,
  "shelf_id": 1
}
```

### Функция `library.cells_upd(_src JSONB)`

#### Функция library.cells_upd() добавляет или изменяет данные о ячейке

- _src - json содержащий данные о ячейке

#### Пример вызова

```sql
SELECT library.cells_upd('{"place_id": 1}');
```

#### Вывод

```json
{
  "cell_id": 6,
  "place_id": 1
}
```

### Функция `library.placeofstorage_get(_book_id INT)`

#### Функция library.placeofstorage_get() выводит место хранения книги

- _book_id - идентификатор книги

#### Пример вызова

```sql
SELECT library.placeofstorage_get(15);
```

#### Вывод

```json
{
  "data": [
    {
      "book_id": 15,
      "cell_id": 5,
      "room_id": 1,
      "place_id": 1,
      "shelf_id": 1
    }
  ]
}
```