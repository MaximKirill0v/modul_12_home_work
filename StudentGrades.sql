/* Задание 1
Создайте следующие запросы для базы данных с оценками студентов из предыдущего практического задания: */

/* Показать ФИО всех студентов с минимальной оценкой в указанном диапазоне */
SELECT Surname, name, Patronymic
FROM StudentsGrades
WHERE AverageGradeAllSubjects BETWEEN 3.5 AND 5.0

/* Показать информацию о студентах, которым исполнилось 20 лет */
SELECT Surname, name, Patronymic, DateofBirth
FROM StudentsGrades
WHERE date('now') - DateofBirth = 20


/* Показать информацию о студентах с возрастом указанном диапазоне */
SELECT Surname, name, Patronymic, DateofBirth, date('now') - DateofBirth AS years_old
FROM StudentsGrades
WHERE date('now') - DateofBirth BETWEEN 20 and 23

/* Показать информацию о студентах с конкретным
именем. Например, показать студентов с именем Борис */
SELECT Surname, name, Patronymic, GroupName
FROM StudentsGrades
WHERE name = 'Антон'

/* Показать информацию о студентах, в чьем номере встречаются три семерки */
/* Запрос, который находит номер телефона, где подряд встречаются 777 */
SELECT Surname, name, Patronymic, ContactNumber
FROM StudentsGrades
WHERE ContactNumber like '%777%'

/* Запрос, который находит номер телефона, где встречаются 777 в разных местах номера телефона */
SELECT Surname, name, Patronymic, ContactNumber
FROM StudentsGrades
WHERE ContactNumber glob '*7*7*7*'

/* Показать электронные адреса студентов, начинающихся с конкретной буквы */
SELECT Surname, name, Patronymic, email
FROM StudentsGrades
WHERE email like 's%'



/* Задание 2
Создайте следующие запросы для базы данных с оценками студентов из предыдущего практического задания: */

/* Показать минимальную среднюю оценку по всем студентам */
SELECT min(AverageGradeAllSubjects) AS MinAvg
FROM StudentsGrades

/* Показать максимальную среднюю оценку по всем студентам */
SELECT max(AverageGradeAllSubjects) AS MinAvg
FROM StudentsGrades

/* Показать статистику городов студентов. Нужно отображать название города и количество студентов из этого города */
SELECT City, count(*) AS CountStudent
FROM StudentsGrades
GROUP BY City

/* Показать статистику стран студентов. Нужно отображать название страны и количество студентов из этой страны */
SELECT Country, count(*) AS CountStudent
FROM StudentsGrades
GROUP BY Country

/* Показать количество студентов, у которых минимальная средняя оценка по математике */
SELECT count(*) AS number_of_students
FROM StudentsGrades
WHERE MinAverageGradeSubject = 'Математика'
GROUP BY MinAverageGradeSubject

/* Показать количество студентов, у которых максимальная средняя оценка по математике */
SELECT count(*) AS number_of_students
FROM StudentsGrades
WHERE MaxAverageGradeSubject = 'Математика'
GROUP BY MaxAverageGradeSubject

/* Показать количество студентов в каждой группе */
SELECT GroupName, count(*) AS number_of_students
FROM StudentsGrades
GROUP BY GroupName

/* Показать среднюю оценку по группе */
SELECT GroupName, avg(AverageGradeAllSubjects) AS Avg_group
FROM StudentsGrades
GROUP BY GroupName