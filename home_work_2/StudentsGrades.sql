/* Задание 1.
Создайте базу данных для хранения оценок студентов. Внутри базы
данных создайте таблицу «Оценки студентов». Нужно хранить такую
информацию:
 ФИО студента;
 Город;
 Страна;
 Дата рожденья;
 Электронный адрес;
 Контактный телефон;
 Название группы;
 Средняя оценка за год по всем предметам;
 Название предмета с минимальной, средней оценкой;
 Название предмета с максимальной, средней оценкой.
Сохраните запрос создания таблицы БД в отдельном файле и приложите
к ответу на задание */

CREATE TABLE "StudentsGrades" (
	"ID_Student" INTEGER,
	"Surname" TEXT NOT NULL,
	"Name" TEXT NOT NULL,
	"Patronymic" TEXT NOT NULL,
	"City" TEXT NOT NULL,
	"Country" TEXT NOT NULL,
	"DateofBirth" TEXT NOT NULL,
	"email"	TEXT UNIQUE,
	"ContactNumber"	TEXT UNIQUE,
	"GroupName"	TEXT NOT NULL,
	"AverageGradeAllSubjects" REAL NOT NULL,
	"MinAverageGradeSubject" TEXT NOT NULL,
	"MaxAverageGradeSubject" TEXT NOT NULL,
	PRIMARY KEY("ID_Student" AUTOINCREMENT)
)
INSERT INTO StudentsGrades (Surname, Name, Patronymic, City, Country, DateofBirth, email, ContactNumber, GroupName,
AverageGradeAllSubjects, MinAverageGradeSubject, MaxAverageGradeSubject)
VALUES
("Степанов", "Степан", "Степанович", "Ярославль", "Россия", "2000-01-01", "stepanov@mail.ru", "8(905)111 22 33", "АТ-15", 4.6,
"Химия", "Информатика"),
("Иванов", "Иван", "Иванович", "Рыбинск", "Россия", "2000-12-23", "ivanov@mail.ru", "8(905)444 55 66", "АТ-16", 3.6,
"История", "Информатика"),
("Петров", "Пётр", "Петрович", "Тутаев", "Россия", "2001-10-08", "petrov@mail.ru", "8(905)777 88 99", "АТ-15", 4.4,
"Математика", "Физика"),
("Гусев", "Антон", "Олегович", "Минск", "Беларусь", "2000-04-19", "gusev@gmail.com", "8(930)765 23 12", "МФ-13", 3.8,
"Информатика", "Черчение"),
("Сидоров", "Евгений", "Борисович", "Тбилиси", "Грузия", "1999-03-11", "sidorov.@qmail.com", "8(910)762 90 67", 3.1, "ПГС-11",
"История", "Английский язык");