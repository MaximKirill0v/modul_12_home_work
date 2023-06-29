--База данных Больница (Hospital) содержит информацию о врачах и пожертвованиях. Врачи, работающие в
--больнице представлены в виде таблицы Врачи (Doctors),
--в которой собрана основная информация, такая как: имя,
--фамилия, а также зарплата. Специализации врачей представлены в виде таблиц Специализации (Specializations)
--и Врачи и специализации (DoctorsSpecializations). Также
--база данных содержит информацию об отпусках врачей,
--располагающуюся в таблице Отпуска (Vacations).
--Данные, относящиеся к спонсорам и пожертвованиям,
--хранятся в таблицах Спонсоры (Sponsors) и Пожертвования (Donations) соответственно.
--Также в базе данных содержится информация о палатах больницы в таблице Палаты (Wards), которые тесно
--связаны с отделениями, в которых они располагаются, и
--которые представлены таблицей Отделения (Departments).

--Отделения (Departments)
CREATE TABLE Departments
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL UNIQUE CHECK(name != '')
)

INSERT INTO Departments(name)
VALUES
('травматологическое'),
('хирургическое'),
('кардиологическое'),
('приёмное'),
('неврологическое'),
('лор')

--Врачи (Doctors)
CREATE TABLE Doctors
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

--Специализации (Specializations)
CREATE TABLE Specializations
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL UNIQUE CHECK(name != '')
)

INSERT INTO Specializations(name)
VALUES
('травматолог'),
('хирург'),
('кардиолог'),
('терапевт'),
('невролог'),
('лор')

--Врачи и специализации (DoctorsSpecializations)
CREATE TABLE DoctorsSpecializations
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	doctor_id INTEGER NOT NULL,
	specialization_id INTEGER NOT NULL,
	FOREIGN KEY(doctor_id) REFERENCES Doctors(id),
	FOREIGN KEY(specialization_id) REFERENCES Specializations(id)
)

INSERT INTO DoctorsSpecializations(doctor_id, specialization_id)
VALUES
(1, 1),
(2, 3),
(3, 6),
(4, 2),
(5, 4),
(6, 4),
(7, 5),
(8, 1),
(9, 2)

--Спонсоры (Sponsors)
CREATE TABLE Sponsors
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL UNIQUE CHECK(name != '')
)

INSERT INTO Sponsors(name)
VALUES
('спонсор_1'),
('спонсор_2'),
('спонсор_3'),
('спонсор_4')


--Пожертвования (Donations)
CREATE TABLE Donations
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	amount REAL NOT NULL DEFAULT 0 CHECK(amount >= 0),
	donation_date TEXT NOT NULL DEFAULT (date('now')) CHECK(donation_date <= date('now')),
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
(400000, '2020-04-27', 6, 1)

--Отпуска (Vacations)
CREATE TABLE Vacations
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	start_date TEXT NOT NULL,
	end_date TEXT NOT NULL CHECK(end_date > start_date),
	doctor_id INTEGER NOT NULL,
	FOREIGN KEY(doctor_id) REFERENCES Doctors(id)
)

INSERT INTO Vacations(start_date, end_date, doctor_id)
VALUES
('2022-05-25', '2022-06-12', 1),
('2021-06-01', '2022-06-15', 2),
('2022-07-02', '2022-07-16', 3),
('2023-01-01', '2023-01-14', 4),
('2022-12-15', '2022-12-30', 5),
('2023-09-01', '2023-09-16', 6),
('2022-04-15', '2022-04-30', 7),
('2023-02-14', '2023-02-28', 8),
('2022-03-01', '2022-03-15', 9)

--Палаты (Wards)
CREATE TABLE Wards
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL UNIQUE CHECK(name != ''),
	department_id INTEGER NOT NULL,
	FOREIGN KEY(department_id) REFERENCES Departments(id)
)

INSERT INTO Wards(name, department_id)
VALUES
('101 травм', 1),
('115 травм', 1),
('202 хир', 2),
('203 хир', 2),
('250 кард', 3),
('251 кард', 3),
('150 приём', 4),
('151 приём', 4),
('310 неврл', 5),
('315 неврл', 5),
('415 лор', 6),
('430 лор', 6)


--1. Вывести полные имена врачей и их специализации.
SELECT Doctors.name, Doctors.surname, Specializations.name
FROM Doctors, Specializations, DoctorsSpecializations
WHERE DoctorsSpecializations.doctor_id = Doctors.id AND DoctorsSpecializations.specialization_id = Specializations.id

--2. Вывести фамилии и зарплаты (сумма ставки и надбавки) врачей, которые не находятся в отпуске.
SELECT Doctors.surname, (Doctors.salary + Doctors.premium) AS res_salary
FROM Doctors, Vacations
WHERE Doctors.id = Vacations.doctor_id AND date('now') > Vacations.end_date

--3. Вывести названия палат, которые находятся в отделении “Кардиологии”
SELECT Wards.name
FROM Wards, Departments
WHERE Departments.id = Wards.department_id AND Departments.name = 'кардиологическое'

--4. Вывести названия отделений без повторений, которые спонсируются компанией “спонсор_2”.
SELECT DISTINCT Departments.name
FROM Departments, Sponsors, Donations
WHERE Departments.id = Donations.department_id AND
	  Sponsors.id = Donations.sponsor_id AND
	  Sponsors.name = 'спонсор_2'

--5. Вывести все пожертвования за последний месяц в виде: отделение, спонсор, сумма пожертвования, дата пожертвования.
SELECT Departments.name, Sponsors.name, Donations.amount, Donations.donation_date
FROM Departments, Sponsors, Donations
WHERE Departments.id = Donations.id AND
	  Sponsors.id = Donations.sponsor_id AND
	  Donations.donation_date BETWEEN date('now', 'start of month') AND date('now')

--6. Вывести фамилии врачей с указанием отделений, в которых они проводят обследования. Необходимо
--учитывать обследования, проводимые только в будние дни.

--7. Вывести названия палат и корпуса отделений, в которых проводит обследования врач “Helen Williams”.
--8. Вывести названия отделений, которые получали пожертвование в размере больше 100000, с указанием
--их врачей.
--9. Вывести названия отделений, в которых есть врачи
--не получающие надбавки.
--10. Вывести названия специализаций, которые используются для лечения заболеваний со степенью тяжести
--выше 3.
--11. Вывести названия отделений и названия заболеваний,
--обследования по которым они проводили за последние полгода.
--12. Вывести названия отделений и названий палат, в которых проводились обследования по заразительным
--заболеваниям.



