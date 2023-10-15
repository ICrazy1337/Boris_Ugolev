# SCHEMA humanresource
#

### Работа с пользователями
###### Пример добавления пользователя
```sql
select humanresource.usersupd('{
  "name": "Boris",
  "surname": "Ugolev",
  "phone_number": "+7999999999",
  "birth_day": "2004-01-02"}', 2542);
```
###### Пример изменения данных пользователя
```sql
select humanresource.usersupd('{
  "user_id": 1
  "name": "Boris",
  "surname": "Ugolev",
  "phone_number": "+7926999999",
  "birth_day": "2004-01-02"}', 2542);
```
###### Все данные дублируются в логи
