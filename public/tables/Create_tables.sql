CREATE TABLE Goods (
ID INT NOT NULL,
Name VARCHAR(30) NOT NULL,
Price NUMERIC(10,2) NOT NULL,
CONSTRAINT PK_Goods PRIMARY KEY(ID),
CONSTRAINT ch_price CHECK (Price>0)
);

CREATE TABLE Client (
ID INT NOT NULL,
Name VARCHAR(30) NOT NULL,
Phone_number VARCHAR (11),
CONSTRAINT PK_Client PRIMARY KEY(ID)
);

CREATE TABLE Prod (
ID INT NOT NULL,
Date_and_time TIMESTAMP NOT NULL,
Client_id INT NOT NULL,
Goods_id INT NOT NULL,
Quantity INT NOT NULL,
CONSTRAINT PK_prod PRIMARY KEY(ID),
CONSTRAINT CH_Quantity CHECK(Quantity>0)
);

insert into client values
(1,'Boris','+7999999999'),
(2,'Boris','+7926999999'),
(3,'Petr','+7903999999'),
(4,'Vasya', null),
(5,'Evgeniy', null),
(6,'Karl','+7998889999'),
(7,'Micael','+7900999999'),
(8,'Polina','+7923999999'),
(9,'Yana', null),
(10,'Anastasia', null);

insert into goods values
(1,'Книга', 899.99),
(2,'Циркуль', 400),
(3,'Готовальня', 1200),
(4,'Кружка', 200),
(5,'Самолетик', 599.99),
(6,'Тетрадь', 72.50),
(7,'Компьютерная мышь', 3299),
(8,'Компьютерная клавиатура', 7369),
(9,'Расческа', 300),
(10,'Сервиз', 2999.99);

insert into prod values
(1, '2023-01-15 09:23:57', 1, 1, 2),
(2, '2023-04-06 18:47:12', 1, 2, 1),
(3, '2023-06-30 04:15:33', 2, 1, 3),
(4, '2023-07-29 12:55:42', 3, 1, 1),
(5, '2023-09-20 21:30:04', 3, 4, 1),
(6, '2023-03-11 05:12:19', 4, 8, 1),
(7, '2023-08-02 14:28:51', 3, 2, 1),
(8, '2023-05-25 02:08:37', 9, 5, 1),
(9, '2023-02-08 10:33:58', 6, 9, 2),
(10, '2023-10-17 17:40:21', 2, 8, 2),
(11, '2023-11-04 19:59:03', 5, 1, 1),
(12, '2023-04-18 07:01:45', 3, 6, 3),
(13, '2023-03-05 15:22:56', 9, 3, 2),
(14, '2023-07-12 23:27:18', 7, 4, 1),
(15, '2023-08-22 13:09:27', 8, 2, 1),
(16, '2023-12-09 11:48:34', 1, 7, 3),
(17, '2023-01-27 08:03:14', 4, 5, 3),
(18, '2023-09-08 06:16:06', 10, 10, 2),
(19, '2023-11-21 03:06:55', 2, 9, 1),
(20, '2023-02-20 16:40:10', 6, 3, 1),
(21, '2023-05-14 22:54:47', 7, 10, 2),
(22, '2023-06-09 20:37:28', 1, 5, 2),
(23, '2023-10-08 09:14:39', 8, 6, 3),
(24, '2023-12-31 01:52:58', 9, 4, 1),
(25, '2023-03-28 14:25:26', 3, 1, 3),
(26, '2023-07-01 14:07:33', 5, 8, 2),
(27, '2023-08-15 03:45:11', 4, 7, 2),
(28, '2023-04-02 06:19:47', 10, 2, 3),
(29, '2023-09-26 10:30:19', 1, 3, 1),
(30, '2023-11-14 17:59:02', 10, 4, 2);