--Запросы этого практического задания нужно выполнить к базе данных Больница (Hospital). Описание базы
--данных находится в конце этого файла.

--Отделения (Departments)
CREATE TABLE Departments
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	building INTEGER NOT NULL CHECK(building BETWEEN 1 AND 5),
	name TEXT NOT NULL UNIQUE CHECK(name != '')
)

INSERT INTO Departments(building, name)
VALUES
(1, 'травматология'),
(2, 'хирургия'),
(2, 'кардиология'),
(5, 'приёмное'),
(3, 'неврология'),
(4, 'лор')
(2, 'стоматология')

--Врачи (Doctors)
CREATE TABLE IF NOT EXISTS Doctors
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL CHECK(name != ''),
	surname TEXT NOT NULL CHECK(surname != ''),
	premium REAL NOT NULL DEFAULT 0 CHECK(premium >= 0),
	salary REAL NOT NULL CHECK(salary > 0)
)

INSERT INTO Doctors(name, surname, premium, salary)
VALUES
('Галина', 'Кузнецова', 10000, 50000),
('Михаил', 'Гусев', 5000, 45000),
('Антон', 'Зайцев', 10000, 47000),
('Елена', 'Крылова', 7000, 55000),
('Валентина', 'Лебедева', 15000, 70000),
('Наталья', 'Горячева', 10000, 55000),
('Егор', 'Степанов', 5000, 35000),
('Ирина', 'Королёва', 10000, 50000),
('Александр', 'Пантелеев', 5000, 35000)

--Обследования (Examinations)
CREATE TABLE IF NOT EXISTS Examinations
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL UNIQUE CHECK(name != '')
)

INSERT INTO Examinations(name)
VALUES
('перевязка'),
('электрокардиограмма'),
('сдача крови'),
('флюорография'),
('наложение гипса'),
('промывка носовых пазух'),
('компьютерная томография'),
('первичный осмотр'),
('узи сосудов'),
('замер температуры тела'),
('рентген')


--Спонсоры (Sponsors)
CREATE TABLE IF NOT EXISTS Sponsors
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name NOT NULL UNIQUE CHECK(name != '')

INSERT INTO Sponsors(name)
VALUES
('спонсор_1'),
('спонсор_2'),
('спонсор_3'),
('спонсор_4')

--Палаты (Wards)
CREATE TABLE IF NOT EXISTS Wards
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL UNIQUE CHECK(name != ''),
	places INTEGER NOT NULL CHECK(places >= 1),
	department_id INTEGER NOT NULL,
	FOREIGN KEY(department_id) REFERENCES Departments(id)
)

INSERT INTO Wards(building, floor, name)
VALUES
('310 травм', 2, 1),
('311 травм', 4, 1),
('230 хир',4, 2),
('231 хир', 2, 2),
('200 кард', 2, 3),
('201 кард', 2, 3),
('305 приём', 4, 4),
('306 приём', 4, 4),
('412 неврл', 2, 5),
('413 неврл', 2, 5)

--Врачи и обследования (DoctorsExaminations)
CREATE TABLE IF NOT EXISTS DoctorsExaminations
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	start_time TEXT NOT NULL CHECK(start_time BETWEEN '08:00' AND '18:00'),
	end_time TEXT NOT NULL CHECK(end_time > start_time),
	doctor_id INTEGER NOT NULL,
	examination_id INTEGER NOT NULL,
	ward_id INTEGER NOT NULL,
	FOREIGN KEY(doctor_id) REFERENCES Doctors(id),
	FOREIGN KEY(examination_id) REFERENCES Examinations(id),
	FOREIGN KEY(ward_id) REFERENCES Wards(id)
)

INSERT INTO DoctorsExaminations(start_time, end_time, doctor_id, examination_id, ward_id)
VALUES
('08:00', '08:30', 1, 1, 1),
('09:00', '10:00', 2, 2, 2),
('09:00', '10:30', 3, 3, 3),
('08:00', '08:30', 4, 4, 4),
('10:00', '11:30', 5, 5, 5),
('11:00', '11:30', 6, 6, 6),
('09:00', '09:30', 7, 7, 7),
('10:00', '10:30', 8, 8, 8),
('08:00', '10:30', 9, 9, 9),
('09:00', '11:30', 1, 10, 10)

--Пожертвования (Donations)
CREATE TABLE IF NOT EXISTS Donations
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	amount REAL NOT NULL DEFAULT 0 CHECK(amount > 0),
	donation_date TEXT NOT NULL DEFAULT (date('now')) CHECK(donation_date <= 'CURRENT_DATE'),
	department_id INTEGER NOT NULL,
	sponsor_id INTEGER NOT NULL,
	FOREIGN KEY(department_id) REFERENCES Departments(id),
	FOREIGN KEY(sponsor_id) REFERENCES Sponsors(id)
)

INSERT INTO Donations(amount, donation_date, department_id, sponsor_id)
VALUES
(100000, '2022-06-12', 1, 2),
(200000, '2021-10-22', 2, 1),
(500000, '2019-01-20', 3, 3),
(300000, '2022-09-15', 4, 4),
(600000, '2021-05-12', 5, 2),
(400000, '2023-04-27', 6, 1),
(100000, '2020-07-12', 1, 2),
(200000, '2019-11-22', 2, 1),
(500000, '2022-01-20', 3, 3),
(300000, '2021-09-15', 4, 4),
(600000, '2020-05-12', 5, 2),
(400000, '2021-04-27', 6, 1)

--Задание 1
--1. Вывести названия отделений, что находятся в том же
--корпусе, что и отделение “кардиология”.
SELECT Departments.name
FROM Departments
WHERE building = 2 AND name != 'кардиология'

--2. Вывести названия отделений, что находятся в том же
--корпусе, что и отделения “кардиологическое” и “стоматологическое”.
INSERT INTO Departments(building, name)
VALUES
(2, 'стоматология')

SELECT Departments.name
FROM Departments
WHERE building = 2 AND Departments.name NOT IN ('кардиология', 'стоматология')

--3. Вывести название отделения, которое получило меньше всего пожертвований.
SELECT Departments.name, min(Donations.amount) AS min_amount
FROM Departments, Donations
WHERE Departments.id = Donations.department_id

--4. Вывести фамилии врачей, ставка которых больше, чем у врача "Зайцев".
SELECT Doctors.name, Doctors.surname, Doctors.salary
FROM Doctors
WHERE salary > (SELECT Doctors.salary FROM Doctors WHERE Doctors.surname = 'Зайцев')

--5. Вывести названия палат, вместимость которых больше, чем средняя вместимость в палатах отделения
--“Хирургия”.
SELECT Wards.name, Wards.places
FROM Wards
WHERE places > (SELECT avg(Wards.places)
				FROM Wards, Departments
				WHERE Wards.department_id = Departments.id AND Departments.name = 'хирургия')

--6. Вывести полные имена врачей, зарплаты которых
--(сумма ставки и надбавки) превышают более чем на
--1000 зарплату врача “Антон Зайцев”.
SELECT Doctors.name, Doctors.surname, (Doctors.salary + Doctors.premium) AS res_salary
FROM Doctors
WHERE Doctors.salary + Doctors.premium > (SELECT Doctors.salary + Doctors.premium
										  FROM Doctors
										  WHERE Doctors.surname = 'Зайцев'
										  AND Doctors.name = 'Антон') + 1000

--7. Вывести названия отделений, в которых проводит
--обследования врач “Антон Зайцев”.
SELECT Departments.name
FROM Departments
INNER JOIN Doctors, DoctorsExaminations, Wards
ON DoctorsExaminations.doctor_id = Doctors.id AND
   Doctors.name = 'Антон' AND Doctors.surname = 'Зайцев' AND
   Wards.department_id = Departments.id AND
   DoctorsExaminations.ward_id = Wards.id

--8. Вывести названия спонсоров, которые не делали пожертвования отделениям “хирургия” и “травматология”.
SELECT DISTINCT Sponsors.name
FROM Sponsors
INNER JOIN Departments, Donations
ON Donations.department_id = Departments.id AND
   Donations.sponsor_id = Sponsors.id AND
   Sponsors.id NOT IN (SELECT DISTINCT Sponsors.id
				   FROM Sponsors, Donations, Departments
                   WHERE Donations.department_id = Departments.id AND
                         Donations.sponsor_id = Sponsors.id AND
	                     Departments.name IN ('хирургия', 'травматология'))

--9. Вывести фамилии врачей, которые проводят обследования в период с 12:00 до 15:00.
