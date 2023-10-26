# SCHEMA `history`

---

# TABLES `logs`

- bookchanges
- issuedschanges
- subscriberschanges
- userschanges

---

## Функция `history.create_partitions(_table_name TEXT)`

### Функция subsriptionstypes_upd() служит для создания партиций в таблице назначения

- _table_name - название таблицы для партицирования

### Пример вызова

```sql
SELECT history.create_partition('subscriberschanges')
```

## Функция `dictionary.drop_partitions(_table_name TEXT)`

### Функция drop_partitions() удаляет партиции и секции в таблице назначения

- _table_name - название таблицы для партицирования

### Пример вызова

```sql
SELECT dictionary.subsriptionstypes_get();
```
