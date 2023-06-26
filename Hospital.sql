/* Задание 1
Необходимо создать базу данных Больница (Hospital),
которая будет содержать информацию о проводимых в
больнице обследованиях.
Описание базы данных находится в конце этого
файла. */

/* Отделения (Departments) */

CREATE TABLE Departments
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	building INTEGER NOT NULL CHECK(building >= 1 AND building <= 5),
	financing REAL NOT NULL CHECK(financing >= 0) DEFAULT 0,
	name TEXT NOT NULL UNIQUE CHECK(name != '')
)

INSERT INTO Departments(building, financing, name)
VALUES
(1, 100000, 'травматологическое'),
(2, 200000, 'хирургическое'),
(3, 300000, 'кардиологическое'),
(4, 400000, 'приёмное'),
(5, 500000, 'неврологическое')


/* Заболевания (Diseases) */

CREATE TABLE Diseases
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL UNIQUE CHECK(name != ''),
	severity INTEGER NOT NULL DEFAULT 1 CHECK(severity >= 1)
)

INSERT INTO Diseases(name, severity)
VALUES
('перелом руки', 3),
('аппендицит', 5),
('сосудистая патология', 2),
('ковид', 4),
('мигрень', 1)



/* Врачи (Doctors) */

CREATE TABLE Doctors
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL CHECK(name != ''),
	surname TEXT NOT NULL CHECK(surname != ''),
	phone TEXT NOT NULL UNIQUE,
	salary REAL NOT NULL CHECK(salary > 0)
)

INSERT INTO Doctors(name, surname, phone, salary)
VALUES
('Иван', 'Кузнецов', '8(903)690 78 32', 2),
('Пётр', 'Магин', '8(930)690 45 12', 1),
('Алексей', 'Горячев', '8(920)432 54 67', 3),
('Андрей', 'Киселёв', '8(910)542 67 89', 1),
('Александр', 'Орлов', '8(910)690 65 89', 2)



/* Обследования (Examinations) */

CREATE TABLE Examinations
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	day_of_week INTEGER NOT NULL CHECK(day_of_week >= 1 AND day_of_week <= 7),
	start_time TEXT NOT NULL CHECK(start_time >= '08:00' AND start_time <= '18:00'),
	end_time TEXT NOT NULL CHECK(end_time > start_time)
	name TEXT NOT NULL CHECK(name != '')
)

INSERT INTO Examinations(day_of_week, start_time, end_time)
VALUES
(1, '09:00', '09:15', 'осмотр'),
(1, '09:20', '10:00', 'узи желудка'),
(2, '12:00', '13:00', 'рентген'),
(3, '13:00', '13:30', 'перевязка'),
(4, '09:00', '09:30', 'осмотр'),
(5, '10:00', '10:40', 'флюорография'),
(2,	'14:00', '14:30', 'сдача крови')

/* Палаты (Wards) */
CREATE TABLE Wards
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	building INTEGER NOT NULL CHECK(building >= 1 AND building <= 5),
	floor INTEGER NOT NULL CHECK(floor > 0),
	name TEXT NOT NULL UNIQUE
)

INSERT INTO Wards(building, floor, name)
VALUES
(1, 3, '310травм'),
(2, 2, '230_хир'),
(3, 2, '200_кард'),
(4, 3, '305_пр'),
(5, 4, '412_невр')

/* Задание 2
Для базы данных Больница создайте такие запросы: */

/* 1. Вывести содержимое таблицы палат. */
SELECT *
FROM Wards

/* 2. Вывести фамилии и телефоны всех врачей. */
SELECT name, surname, phone
FROM Doctors

/* 3. Вывести все этажи без повторений, на которых располагаются палаты. */
SELECT DISTINCT floor
FROM Wards

/* 4. Вывести названия заболеваний под именем “Name of
Disease” и степень их тяжести под именем “Severity
of Disease”. */
SELECT name AS 'Name of Disease', severity AS 'Severity of Disease'
FROM Diseases

/* 5. Использовать выражение FROM для любых трех таблиц базы данных, используя для них псевдонимы. */
SELECT name AS 'name of departments'
FROM Departments
SELECT name AS 'name of diseases'
FROM Diseases
SELECT surname AS 'surname of doctor'
FROM Doctors

/* 6. Вывести названия отделений, расположенных в корпусе 5 и имеющих фонд финансирования менее 30000. */
SELECT name
FROM Departments
WHERE building = 5 AND financing < 30000

/* 7. Вывести названия отделений, расположенных в 3-м
корпусе с фондом финансирования в диапазоне от 12000 до 15000. */
SELECT name
FROM Departments
WHERE building = 3 AND financing BETWEEN 12000 AND 15000

/* 8. Вывести названия палат, расположенных в корпусах 4 и 5 на 1-м этаже. */
SELECT name
FROM Wards
WHERE building IN (4, 5) AND floor = 1

/* 9. Вывести названия, корпуса и фонды финансирования отделений, расположенных в корпусах 3 или 6 и
имеющих фонд финансирования меньше 11000 или больше 25000. */
SELECT name, building, financing
FROM Departments
WHERE (building = 3 OR building = 6) AND (financing < 11000 or financing > 25000)

/* 10. Вывести фамилии врачей, чья зарплата (сумма ставки
и надбавки) превышает 1500. */
ALTER TABLE Doctors
ADD COLUMN premium REAL NOT NULL DEFAULT 0 CHECK(premium > 0)

SELECT surname
FROM Doctors
WHERE salary + premium > 1500

/* 11. Вывести фамилии врачей, у которых половина зарплаты превышает троекратную надбавку. */
SELECT surname
FROM Doctors
WHERE salary / 2 > premium * 3

/* 12. Вывести названия обследований без повторений, проводимых в первые три дня недели с 12:00 до 15:00.*/
SELECT DISTINCT name
FROM Examinations
WHERE day_of_week IN (1, 2, 3) AND start_time >= '12:00' and end_time <= '15:00'

/* 13. Вывести названия и номера корпусов отделений, расположенных в корпусах 1, 3, 8 или 10. */
SELECT name, building
FROM Departments
WHERE building IN (1, 3, 8, 10)

/* 14. Вывести названия заболеваний всех степеней тяжести, кроме 1-й и 2-й. */
SELECT name
FROM Diseases
WHERE severity NOT IN (1, 2)

/* 15. Вывести названия отделений, которые не располагаются в 1-м или 3-м корпусе. */
SELECT name
FROM Departments
WHERE building NOT IN (1, 3)

/* 16. Вывести названия отделений, которые располагаются в 1-м или 3-м корпусе. */
SELECT name
FROM Departments
WHERE building IN (1, 3)

/* 17. Вывести фамилии врачей, начинающиеся на букву “Г” */
SELECT surname
FROM Doctors
WHERE surname like 'Г%'