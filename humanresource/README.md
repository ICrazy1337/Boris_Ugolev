# SCHEMA humanresource

---

## TABLE `staff`

<table>
    <tr>
        <th>Атрибут</th>
        <th>Описание</th>
    </tr>
    <tr>
        <td>staff_id INT NOT NULL</td>
        <td>Идентификатор сотрудника</td>
    </tr>
    <tr>
        <td>name VARCHAR(64) NOT NULL</td>
        <td>Имя сотрудника</td>
    </tr>
    <tr>
        <td>surname VARCHAR(64) NOT NULL</td>
        <td>Фамилия сотрудника</td>
    </tr>
    <tr>
        <td>phone_number VARCHAR(11) NOT NULL</td>
        <td>Номер телефона</td>
    </tr>
    <tr>
        <td>post_id INT NOT NULL</td>
        <td>Идентификатор должности сотрудника</td>
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

### Функция `humanresource.staff_upd(_src JSONB, _ch_staff_id INT)`

#### Функция humanresource.staff_upd() добавляет или изменяет данные о сотруднике

#### Пример вызова

```sql
SELECT humanresource.staff_upd('{
  "name": "Boris",
  "surname": "Ugolev",
  "phone_number": "+7999999979",
  "post_id": 1
}', 2542);
```

#### Вывод

```json
{
  "data": NULL
}
```

### Функция `humanresource.staff_upd(_src JSONB, _ch_staff_id INT)`

#### Функция humanresource.staff_upd() добавляет или изменяет данные о сотруднике

- _src - json содержащий данные о сотруднике
- _ch_staff_id - идентификатор сотрудника

#### Пример вызова

```sql
SELECT humanresource.staff_upd('{
  "name": "Boris",
  "surname": "Ugolev",
  "phone_number": "+7999999999",
  "post_id": 1
}', 2542);
```

#### Вывод

```json
{
  "data": NULL
}
```

### Функция `humanresource.staff_get(_phone_number VARCHAR(11))`

#### Функция humanresource.staff_get выводит сотрудника по номеру телефона

- _phone_number - номер телефона сотрудника

#### Пример вызова

```sql
SELECT humanresource.staff_get('+7999999999');
```

#### Вывод

```json
{
  "data": [
    {
      "name": "Boris",
      "ch_dt": "2023-10-23T15:06:43.149957+00:00",
      "post_id": 1,
      "surname": "Ugolev",
      "staff_id": 2,
      "ch_staff_id": 2542,
      "phone_number": "+7999999999"
    }
  ]
}
```

---

## TABLE `users`

<table>
    <tr>
        <th>Атрибут</th>
        <th>Описание</th>
    </tr>
    <tr>
        <td>user_id INT NOT NULL</td>
        <td>Идентификатор пользователя</td>
    </tr>
    <tr>
        <td>name VARCHAR(64) NOT NULL</td>
        <td>Имя пользователя</td>
    </tr>
    <tr>
        <td>surname VARCHAR(64) NOT NULL</td>
        <td>Фамилия пользователя</td>
    </tr>
    <tr>
        <td>phone_number VARCHAR(11) NOT NULL</td>
        <td>Номер телефона</td>
    </tr>
    <tr>
        <td>birth_day DATE NOT NULL</td>
        <td>Дата рождения</td>
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

### Функция `humanresource.users_upd(_src JSONB, _ch_staff_id INT)`

#### Функция humanresource.users_upd добавляет или изменяет данные о пользователе

- _src - json содержащий данные о сотруднике
- _ch_staff_id - идентификатор сотрудника

#### Пример вызова

```sql
SELECT humanresource.users_upd('{
  "name": "Boris",
  "surname": "Ugolev",
  "phone_number": "+7926999999",
  "birth_day": "2004-01-02"}', 2542);
```

#### Вывод

```json
{
  "data": NULL
}
```

### Функция `humanresource.users_get(_phone_number VARCHAR(11))`

#### Функция humanresource.users_get выводит пользователя по номеру телефона

- _phone_number - номер телефона пользователя

#### Пример вызова

```sql
SELECT humanresource.users_get('+7999999999');
```

#### Вывод

```json
{
  "data": [
    {
      "name": "Boris",
      "ch_dt": "2023-10-23T22:00:21.015484+00:00",
      "surname": "Ugolev",
      "user_id": 2,
      "birth_day": "2004-01-25",
      "ch_staff_id": 2542,
      "phone_number": "+7999999999"
    }
  ]
}
```

---

## TABLE `subscribers`

<table>
    <tr>
        <th>Атрибут</th>
        <th>Описание</th>
    </tr>
    <tr>
        <td>user_id INT NOT NULL</td>
        <td>Идентификатор пользователя имееющего подписку</td>
    </tr>
    <tr>
        <td>staff_id INT NOT NULL</td>
        <td>Идентификатор сотрудника выдавшего подписку</td>
    </tr>
    <tr>
        <td>type_id INT NOT NULL</td>
        <td>Идентификатор типа подписки</td>
    </tr>
    <tr>
        <td>end_dt TIMESTAMPTZ NOT NULL</td>
        <td>Дата и время конца подписки</td>
    </tr>
</table>

### Функция `humanresource.subscribers_upd(_src JSONB, _staff_id INT)`

#### Функция humanresource.subscribers_upd() добавляет или изменяет данные о подписчике

- _src - json содержащий данные о подписке
- _staff_id идентификатор сотрудника

#### Пример вызова

```sql
select humanresource.subscribers_upd('{
  "user_id": 2,
  "type_id": 5
}', 2542);
```

#### Вывод

```json
{
  "data": NULL
}
```

### Функция `humanresource.subscribers_get(_type INT)`

#### Функция humanresource.users_get() выводит всех пользователей с определенным типом подписки

- _type_id - идентификатор типа подписки

#### Пример вызова

```sql
SELECT humanresource.subscribers_get(1);
```

#### Вывод

```json
{
  "data": [
    {
      "end_dt": "2028-01-23T22:18:34.057085+00:00",
      "type_id": 5,
      "user_id": 2,
      "staff_id": 2542
    }
  ]
}
```