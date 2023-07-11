--Кураторы (Curators)
CREATE TABLE IF NOT EXISTS curators
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL,
	surname TEXT NOT NULL
);

INSERT INTO curators (name, surname) VALUES
("Keeley", "Thrash"),
("Giovanna", "Lacey"),
("Alvaro", "Tong"),
("Reyna", "Macmillan"),
("Galina", "Salyer"),
("Destiny", "Schott"),
("An", "Mendoza"),
("Shalon", "Fielder");


--Кафедры (Departments)
CREATE TABLE IF NOT EXISTS departments
(
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    building INTEGER NOT NULL CHECK(Building BETWEEN 1 AND 5),
	financing REAL DEFAULT 0 CHECK(financing >= 0),
	facultieId INTEGER NOT NULL,
	FOREIGN KEY (facultieId) REFERENCES faculties (id)
);

INSERT INTO departments (name, building, financing, facultieId) VALUES
("Microelectronics", 1, 200000, 1),
("Computer Science", 5, 300000, 2),
("Software Development", 3, 50000, 2),
("Robotics", 2, 150000, 1);


--Факультеты (Faculties)
CREATE TABLE IF NOT EXISTS faculties
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL
);

INSERT INTO faculties (name) VALUES
("Computer science and engineering"),
("Сybernetics");


--Группы (Groups)
CREATE TABLE IF NOT EXISTS groups
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL UNIQUE,
	course INTEGER DEFAULT 1 CHECK(course BETWEEN 1 AND 5),
	departmentId INTEGER NOT NULL,
    FOREIGN KEY(departmentId) REFERENCES departments(id)
);

INSERT INTO groups (name, course, departmentId) VALUES
("D221", 2, 4),
("W101", 1, 3),
("S377", 3, 2),
("A405", 4, 1),
("F503", 5, 1),
("F501", 5, 2),
("S307", 3, 3),
("D201", 2, 4);

--Группы и кураторы (GroupsCurators)
CREATE TABLE IF NOT EXISTS groups_curators
(
	groupId INTEGER NOT NULL,
	curatorId INTEGER NOT NULL,
	FOREIGN KEY(groupId) REFERENCES groups(id),
    FOREIGN KEY(curatorId) REFERENCES curators(id)
);

INSERT INTO groups_curators (groupId, curatorId) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8);


--Группы и лекции (GroupsLectures)
CREATE TABLE IF NOT EXISTS groups_lectures
(
	groupId INTEGER NOT NULL,
	lectureId INTEGER NOT NULL,
    FOREIGN KEY(groupId) REFERENCES groups(id),
	FOREIGN KEY(lectureId) REFERENCES lectures(id)
);

INSERT INTO groups_lectures (groupId, lectureId) VALUES
(1, 1),
(1, 10),
(1, 4),
(1, 7),
(1, 6),
(1, 5),
(1, 2),
(2, 7),
(2, 1),
(2, 6),
(2, 5),
(2, 9),
(2, 8),
(2, 3),
(3, 6),
(3, 1),
(3, 3),
(3, 9),
(3, 8),
(3, 10),
(3, 5),
(4, 3),
(4, 1),
(4, 9),
(4, 2),
(4, 8),
(4, 10),
(4, 4),
(5, 7),
(5, 6),
(5, 5),
(5, 1),
(5, 9),
(5, 2),
(5, 3),
(6, 7),
(6, 2),
(6, 6),
(6, 1),
(6, 9),
(6, 5),
(6, 10),
(7, 6),
(7, 3),
(7, 4),
(7, 8),
(7, 7),
(7, 1),
(7, 2),
(8, 8),
(8, 2),
(8, 5),
(8, 4),
(8, 3),
(8, 7),
(8, 10);


--Группы и студенты (GroupsStudents)
CREATE TABLE IF NOT EXISTS groups_students
(
	groupId INTEGER NOT NULL,
	studentId INTEGER NOT NULL,
    FOREIGN KEY(groupId) REFERENCES groups(id),
	FOREIGN KEY(studentId) REFERENCES students(id)
);

INSERT INTO groups_students(groupId, studentId) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(2, 11),
(2, 12),
(2, 13),
(2, 14),
(2, 15),
(2, 16),
(2, 17),
(2, 18),
(2, 19),
(2, 20),
(3, 21),
(3, 22),
(3, 23),
(3, 24),
(3, 25),
(3, 26),
(3, 27),
(3, 28),
(3, 29),
(3, 30),
(4, 31),
(4, 32),
(4, 33),
(4, 34),
(4, 35),
(4, 36),
(4, 37),
(4, 38),
(4, 39),
(4, 40),
(5, 41),
(5, 42),
(5, 43),
(5, 44),
(5, 45),
(5, 46),
(5, 47),
(5, 48),
(5, 49),
(5, 50),
(6, 51),
(6, 52),
(6, 53),
(6, 54),
(6, 55),
(6, 56),
(6, 57),
(6, 58),
(6, 59),
(6, 60),
(7, 61),
(7, 62),
(7, 63),
(7, 64),
(7, 65),
(7, 66),
(7, 67),
(7, 68),
(7, 69),
(7, 70),
(8, 71),
(8, 72),
(8, 73),
(8, 74),
(8, 75),
(8, 76),
(8, 77),
(8, 78),
(8, 79),
(8, 80);


--Лекции (Lectures)
CREATE TABLE IF NOT EXISTS lectures
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	dateOfLecture TEXT DEFAULT CURRENT_DATE CHECK(dateOfLecture <= CURRENT_DATE),
	subjectId INTEGER NOT NULL,
	teacherId INTEGER NOT NULL,
	FOREIGN KEY (subjectId) REFERENCES subjects (id),
	FOREIGN KEY (teacherId) REFERENCES teachers (id)
);

INSERT INTO lectures (dateOfLecture, subjectId, teacherId) VALUES
("2023-06-22", 9, 2),
("2023-06-28", 3, 1),
("2023-06-25", 10, 2),
("2023-06-23", 10, 9),
("2023-06-29", 8, 10),
("2023-06-18", 3, 5),
("2023-06-23", 5, 5),
("2023-06-01", 7, 4),
("2023-06-15", 6, 7),
("2023-06-12", 2, 3),
("2023-06-11", 7, 10),
("2023-06-12", 4, 4),
("2023-06-11", 10, 1),
("2023-06-15", 7, 9),
("2023-06-28", 5, 2),
("2023-06-08", 2, 2),
("2023-06-12", 3, 8),
("2023-06-25", 9, 10),
("2023-06-12", 4, 10),
("2023-06-26", 5, 3),
("2023-06-20", 7, 1),
("2023-06-02", 1, 1),
("2023-06-22", 5, 8),
("2023-06-27", 2, 4),
("2023-06-25", 2, 9),
("2023-06-28", 6, 6),
("2023-06-27", 5, 2),
("2023-06-21", 4, 3),
("2023-06-21", 1, 9),
("2023-06-21", 3, 4),
("2023-06-11", 2, 5),
("2023-06-04", 4, 8),
("2023-06-06", 9, 6),
("2023-06-06", 8, 7),
("2023-06-07", 7, 4),
("2023-06-05", 7, 3),
("2023-06-16", 3, 8),
("2023-06-26", 9, 6),
("2023-06-28", 7, 6),
("2023-06-06", 2, 7),
("2023-06-22", 8, 4),
("2023-06-23", 7, 4),
("2023-06-06", 2, 8),
("2023-06-25", 10, 2),
("2023-06-26", 1, 10),
("2023-06-28", 9, 6),
("2023-06-01", 10, 6),
("2023-06-24", 8, 7),
("2023-06-29", 10, 9),
("2023-06-15", 1, 8),
("2023-06-09", 8, 9),
("2023-06-07", 9, 5),
("2023-06-09", 5, 6),
("2023-06-14", 9, 8),
("2023-06-12", 3, 4),
("2023-06-05", 4, 2),
("2023-06-10", 7, 3),
("2023-06-25", 1, 10),
("2023-06-03", 8, 4),
("2023-06-12", 8, 8),
("2023-06-12", 5, 8),
("2023-06-19", 5, 7),
("2023-06-19", 4, 6),
("2023-06-11", 1, 6),
("2023-06-12", 9, 10),
("2023-06-19", 5, 4),
("2023-06-24", 1, 5),
("2023-06-20", 6, 7),
("2023-06-15", 5, 6),
("2023-06-24", 5, 6),
("2023-06-02", 9, 8),
("2023-06-19", 4, 7),
("2023-06-07", 8, 3),
("2023-06-12", 10, 6),
("2023-06-17", 1, 2),
("2023-06-18", 9, 2),
("2023-06-02", 3, 4),
("2023-06-26", 10, 1),
("2023-06-19", 4, 1),
("2023-06-04", 2, 5);


--Студенты (Students)
CREATE TABLE IF NOT EXISTS students
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL,
	surname TEXT NOT NULL,
	rating INTEGER NOT NULL CHECK(rating BETWEEN 0 AND 5)
);

INSERT INTO students (name, surname, rating) VALUES
("Stanley", "Purdy", 5),
("Albertina", "Oneal", 2),
("Cordie", "Pruitt", 2),
("Gearldine", "Lytle", 5),
("Percy", "Littlejohn-Magnuson", 3),
("Pearlene", "Bergeron", 4),
("Octavia", "Gamez", 4),
("Blair", "Bivens", 4),
("Minta", "Parrott", 4),
("Simonne", "Harry", 4),
("Jocelyn", "Conaway", 3),
("Louella", "Lundy", 1),
("Karyn", "Malloy", 4),
("Clorinda", "Atchison", 4),
("Mariann", "Woo", 2),
("Marlon", "Briley", 2),
("Aileen", "Hare", 2),
("Alexia", "Trotter", 1),
("Millicent", "Rudd", 5),
("Maryln", "Gaston", 4),
("Kaylene", "Crocker", 4),
("Latasha", "Kirk", 2),
("Devon", "Sweat", 4),
("Marinda", "Greco", 1),
("Reid", "Lashley", 2),
("Carol", "Wyatt", 4),
("Verda", "Wilkes", 2),
("Remona", "Day", 3),
("Chas", "Dominquez", 1),
("Norris", "Ritchie", 5),
("Tesha", "Knowlton", 4),
("Valentine", "Collado", 4),
("Ingrid", "Compton", 3),
("Reagan", "Belanger", 2),
("Tonita", "Ryder", 3),
("Olin", "Cranford", 3),
("Min", "Sikes", 2),
("Mitzie", "Moen", 5),
("Franchesca", "Laughlin", 5),
("Maynard", "Limon", 4),
("Wen", "Morse", 1),
("Ona", "Himes", 1),
("Dominic", "Enright", 3),
("Valeri", "Seitz", 3),
("Nohemi", "Bower", 2),
("Floyd", "Marlowe", 4),
("Yolonda", "Stegall", 4),
("Vernon", "Moriarty", 4),
("Don", "Seay", 4),
("Kamala", "Moye", 1),
("Henrietta", "Winter", 3),
("Annabell", "Schulte", 2),
("Katharine", "Moses", 3),
("Lucile", "Beaman", 1),
("Elisabeth", "Gutierrez", 1),
("Charise", "Summers", 2),
("Wilfredo", "Gage", 4),
("Olin", "Burkhart", 5),
("Doretha", "Tompkins", 1),
("Danial", "Ortiz", 1),
("Linnie", "Lopes", 4),
("Francie", "Staten", 2),
("Vaughn", "Hostetler", 2),
("Mabelle", "Noriega", 4),
("Raven", "Walton", 3),
("Fannie", "Haywood", 2),
("Stephenie", "Garvin", 4),
("Ola", "Peck", 3),
("Dewey", "Diehl", 4),
("Eleanor", "Bauer", 4),
("Kathern", "Wilhite", 1),
("Ashton", "Cruse", 2),
("Marquis", "Donohue", 2),
("Jettie", "Hollenbeck", 2),
("Ressie", "Hawk", 1),
("Ronald", "Oliver", 4),
("Tania", "Meadows", 3),
("Timothy", "Cooks", 1),
("Rina", "Mccabe", 2),
("George", "Hensley", 5);



--Дисциплины (Subjects)
CREATE TABLE IF NOT EXISTS subjects
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL UNIQUE
);

INSERT INTO subjects (name) VALUES
("Mathematics"),
("Physics"),
("Chemistry"),
("Biology"),
("English"),
("History"),
("Computer Science"),
("Art"),
("Physical Education"),
("Geography");


--Преподаватели (Teachers)
CREATE TABLE IF NOT EXISTS teachers
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL,
	surname TEXT NOT NULL,
	isProfessor BLOB DEFAULT 0,
	salary REAL NOT NULL CHECK(salary > 0)
);

INSERT INTO teachers (name, surname, isProfessor, salary) VALUES
("Kassie", "Mcdougall", 1, 17675),
("Kenton", "Jamison", 1, 19552),
("Ivan", "Prieto", 1, 18093),
("Mike", "Falls", 1, 18684),
("Piper", "Franklin", 0, 17856),
("Li", "Terrill", 0, 16146),
("Nancie", "Ulmer", 0, 15240),
("Isabell", "Dodd", 0, 14375),
("Latina", "Bickford", 0, 15700),
("Matilda", "Lynch-Wentworth", 0, 14924);


--Задание 1
--1. Вывести количество преподавателей кафедры "Software
--Development”.
SELECT count(DISTINCT teachers.id) AS count_teacher_on_software_development
FROM teachers
INNER JOIN lectures, groups_lectures, groups, departments
ON teachers.id = lectures.teacherId AND
   lectures.id = groups_lectures.groupId AND
   groups_lectures.groupId = groups.id AND
   groups.departmentId = departments.id
WHERE departments.name = 'Software Development'


--2. Вывести количество лекций, которые читает преподаватель “Piper Franklin”.
SELECT count(lectures.teacherId) AS count_lectures
FROM lectures, teachers
WHERE lectures.teacherId = teachers.id AND
teachers.name = 'Piper' AND
teachers.surname = 'Franklin'


--3. Вывести количество занятий, проводимых в аудитории “D201”.
--4. Вывести названия аудиторий и количество лекций,
--проводимых в них.
--5. Вывести количество студентов, посещающих лекции
--преподавателя “Kassie Mcdougall”.
SELECT count(DISTINCT students.id) AS count_student_Kassie_Mcdougall
FROM students
INNER JOIN groups_students, groups, groups_lectures, lectures, teachers
ON students.id = groups_students.studentId AND
   groups_students.groupId = groups.id AND
   groups.id = groups_lectures.groupId AND
   groups_lectures.lectureId = lectures.teacherId
WHERE teachers.name = 'Kassie' AND teachers.surname = 'Mcdougall'

--6. Вывести среднюю ставку преподавателей факультета
--“Computer science and engineering”.
SELECT avg(teachers.salary) AS average_salary_computer_science
FROM teachers
INNER JOIN lectures, groups_lectures, groups, departments, faculties
ON teachers.id = lectures.teacherId AND
   lectures.id = groups_lectures.lectureId AND
   groups_lectures.groupId = groups.id AND
   groups.departmentId = departments.id AND
   departments.facultieId = faculties.id
WHERE faculties.name = 'Computer science and engineering'

--7. Вывести минимальное и максимальное количество
--студентов среди всех групп.
SELECT count(studentId) AS min_and_max_count_student
FROM groups_students
GROUP BY groupId
HAVING min(studentId) AND max(studentId) LIMIT 2


--8. Вывести средний фонд финансирования кафедр.
SELECT avg(financing) AS average_financing
FROM departments

--9. Вывести полные имена преподавателей и количество
--читаемых ими дисциплин.
SELECT teachers.id, teachers.name, teachers.surname, count(DISTINCT(lectures.subjectId)) AS count_lectures
FROM teachers, lectures
WHERE teachers.id = lectures.teacherId
GROUP BY teachers.id


--10. Вывести количество лекций в каждый день недели.
SELECT strftime('%w', dateOfLecture) AS week_day, count(strftime('%w', dateOfLecture)) AS count_week_day
FROM lectures
GROUP BY week_day

--11. Вывести номера аудиторий и количество кафедр, чьи
--лекции в них читаются.
--12. Вывести названия факультетов и количество дисциплин, которые на них читаются.
SELECT faculties.name, count(subjects.name)
FROM subjects, faculties
INNER JOIN departments, groups, groups_lectures, lectures
ON faculties.id = departments.facultieId AND
   departments.id = groups.departmentId AND
   groups.id = groups_lectures.groupId AND
   groups_lectures.lectureId = lectures.id AND
   lectures.subjectId = subjects.id
GROUP BY faculties.name

--13. Вывести количество лекций для каждой пары преподаватель-аудитория.

--Задание 2

--1. Вывести номера корпусов, если суммарный фонд финансирования расположенных в них кафедр превышает 100000.
SELECT departments.building, sum(financing) AS sum_financing
FROM departments
GROUP BY departments.building
HAVING sum_financing > 100000
ORDER BY sum_financing

--2. Вывести названия групп 5-го курса кафедры "Software
--Development”, которые имеют более 5 пар в первые четыре
--недели.
SELECT groups.name, count(lectures.dateOfLecture) AS count_lectures
FROM lectures, groups
INNER JOIN groups_lectures, departments
ON lectures.id = groups_lectures.groupId AND
   groups_lectures.groupId = groups.id AND
   groups.departmentId = departmentId
WHERE  dateOfLecture BETWEEN date('now', '-28 days') AND date('now') AND
       groups.course = 5 AND departments.name = 'Software Development'
GROUP BY groups.name
HAVING count_lectures > 5

--3. Вывести названия групп, имеющих рейтинг(средний
--рейтинг всех студентов группы) больше, чем рейтинг
--группы “D221”.
SELECT groups.name, avg(students.rating) AS average_rating_group
FROM students, groups
INNER JOIN groups_students
ON students.id = groups_students.studentId AND
   groups_students.groupId = groups.id
GROUP BY groupId
HAVING average_rating_group > (SELECT avg(students.rating)
							  FROM students
                              INNER JOIN groups_students, groups
                              ON students.id = groups_students.studentId AND
                                 groups_students.groupId = groups.id
                              WHERE groups.name = 'D201')
ORDER BY average_rating_group


--4. Вывести фамилии и имена преподавателей, ставка
--которых выше средней ставки профессоров.
SELECT teachers.name, teachers.surname
FROM teachers
WHERE isProfessor = 0 AND
      salary > (SELECT avg(salary)
				FROM teachers
				WHERE isProfessor = 1)

--5. Вывести названия групп, у которых больше одного
--куратора.
SELECT groups.name, count(curators.id) AS count_curators
FROM groups, curators
INNER JOIN groups_curators
ON groups.id = groups_curators.groupId AND
   groups_curators.curatorId = curators.id
GROUP BY groups.name
HAVING count_curators > 1

--6. Вывести названия групп, имеющих рейтинг(средний
--рейтинг всех студентов группы) меньше, чем минимальный рейтинг групп 4-го курса.
SELECT groups.name, avg(students.rating) AS average_rating_group
FROM students, groups
INNER JOIN groups_students
ON students.id = groups_students.studentId AND
   groups_students.groupId = groups.id
GROUP BY groupId
HAVING average_rating_group < (SELECT avg(students.rating) AS average_rating_group
								  FROM students, groups
								  INNER JOIN groups_students
								  ON students.id = groups_students.studentId AND
								     groups_students.groupId = groups.id
								  WHERE groups.course = 4
								  GROUP BY groupId
								  ORDER BY average_rating_group LIMIT 1)
ORDER BY average_rating_group

--7. Вывести названия факультетов, суммарный фонд финансирования кафедр которых больше суммарного
--фонда финансирования кафедр факультета “Computer
--Science”.
--8. Вывести названия дисциплин и полные имена преподавателей, читающих наибольшее количество лекций
--по ним.
--9. Вывести название дисциплины, по которому читается
--меньше всего лекций.
--10. Вывести количество студентов и читаемых дисциплин