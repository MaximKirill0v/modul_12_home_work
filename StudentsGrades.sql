/* Задание 1.
Создайте следующие запросы для таблицы с оценками студентов из
предыдущего задания: */

/* Отображение всей информации из таблицы со студентами и оценками */
SELECT *
FROM StudentsGrades

/* Отображение ФИО всех студентов */
SELECT FullName
FROM StudentsGrades

/* Отображение ФИО и всех средних оценок */
SELECT FullName, AverageGradeAllSubjects
FROM StudentsGrades

/* Показать ФИО всех студентов с средней оценкой, больше 4 */
SELECT FullName
FROM StudentsGrades
WHERE AverageGradeAllSubjects > 4

/* Показать страны студентов. Названия стран должны быть уникальными */
SELECT DISTINCT Country
FROM StudentsGrades

/* Показать города студентов. Названия городов должны быть уникальными */
SELECT DISTINCT City
FROM StudentsGrades

/* Показать названия групп. Названия групп должны быть уникальными */
SELECT DISTINCT GroupName
FROM StudentsGrades

/* Показать название всех предметов с минимальными средними оценками. Названия предметов должны быть уникальными */
SELECT DISTINCT MinAverageGradeSubject
FROM StudentsGrades