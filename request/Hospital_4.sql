--Кураторы (Curators)
CREATE TABLE IF NOT EXISTS curators
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL,
	surname TEXT NOT NULL
);


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


--Факультеты (Faculties)
CREATE TABLE IF NOT EXISTS faculties
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL
);


--Группы (Groups)
CREATE TABLE IF NOT EXISTS groups
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL UNIQUE,
	course INTEGER DEFAULT 1 CHECK(course BETWEEN 1 AND 5),
	departmentId INTEGER NOT NULL,
    FOREIGN KEY(departmentId) REFERENCES departments(id)
);

 INSERT INTO groups (name, course, departmentId)
 VALUES
 ('D221', 1, 1),
 ('E222', 2, 2),
 ('F223', 3, 3),
 ('A224', 4, 4),
 ('D225', 5, 1),
 ('E221', 1, 2),
 ('F225', 5, 3),
 ('A223', 3, 4)

--Группы и кураторы (GroupsCurators)
CREATE TABLE IF NOT EXISTS groups_curators
(
	groupId INTEGER NOT NULL,
	curatorId INTEGER NOT NULL,
	FOREIGN KEY(groupId) REFERENCES groups(id),
    FOREIGN KEY(curatorId) REFERENCES curators(id)

);


--Группы и лекции (GroupsLectures)
CREATE TABLE IF NOT EXISTS groups_lectures
(
	groupId INTEGER NOT NULL,
	lectureId INTEGER NOT NULL,
    FOREIGN KEY(groupId) REFERENCES groups(id),
	FOREIGN KEY(lectureId) REFERENCES lectures(id)
);


--Группы и студенты (GroupsStudents)
CREATE TABLE IF NOT EXISTS groups_students
(
	groupId INTEGER NOT NULL,
	stydentId INTEGER NOT NULL,
    FOREIGN KEY(groupId) REFERENCES groups(id),
	FOREIGN KEY(stydentId) REFERENCES students(id)
);


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


--Студенты (Students)
CREATE TABLE IF NOT EXISTS students
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL,
	surname TEXT NOT NULL,
	rating INTEGER NOT NULL CHECK(rating BETWEEN 0 AND 5)
);

INSERT INTO students (name, surname, rating)
VALUES ('Isiah', 'Spaulding', '2');
INSERT INTO students (name, surname, rating)
VALUES ('Christopher', 'Lew', '4');
INSERT INTO students (name, surname, rating)
VALUES ('Tyesha', 'Mcknight-Flores', '4');
INSERT INTO students (name, surname, rating)
VALUES ('Vanna', 'Purcell', '2');
INSERT INTO students (name, surname, rating)
VALUES ('Wilma', 'Seymour', '4');
INSERT INTO students (name, surname, rating)
VALUES ('Darcey', 'Chalmers', '3');
INSERT INTO students (name, surname, rating)
VALUES ('Iola', 'Sigmon', '4');
INSERT INTO students (name, surname, rating)
VALUES ('Gerry', 'Stump', '1');
INSERT INTO students (name, surname, rating)
VALUES ('Sherri', 'Nettles', '2');
INSERT INTO students (name, surname, rating)
VALUES ('Leanne', 'Santana', '4');
INSERT INTO students (name, surname, rating)
VALUES ('Randall', 'Clayton', '3');
INSERT INTO students (name, surname, rating)
VALUES ('Francina', 'Meier-Gall', '1');
INSERT INTO students (name, surname, rating)
VALUES ('Wendie', 'Palacios', '3');
INSERT INTO students (name, surname, rating)
VALUES ('Shellie', 'Latham', '3');
INSERT INTO students (name, surname, rating)
VALUES ('Felecia', 'Gomez', '2');
INSERT INTO students (name, surname, rating)
VALUES ('Caryl', 'Mcmullin', '1');
INSERT INTO students (name, surname, rating)
VALUES ('Cassidy', 'Gaither', '4');
INSERT INTO students (name, surname, rating)
VALUES ('Lea', 'Quezada', '1');
INSERT INTO students (name, surname, rating)
VALUES ('Normand', 'Singleton', '2');
INSERT INTO students (name, surname, rating)
VALUES ('Bernita', 'Brinson', '3');
INSERT INTO students (name, surname, rating)
VALUES ('August', 'Elliot-Fife', '3');
INSERT INTO students (name, surname, rating)
VALUES ('Darin', 'Flanagan', '2');
INSERT INTO students (name, surname, rating)
VALUES ('Cathie', 'Weatherly', '3');
INSERT INTO students (name, surname, rating)
VALUES ('Celinda', 'Griffin', '3');
INSERT INTO students (name, surname, rating)
VALUES ('Bunny', 'Denney', '2');
INSERT INTO students (name, surname, rating)
VALUES ('Carolin', 'Bowman', '3');
INSERT INTO students (name, surname, rating)
VALUES ('Diane', 'Gilbertson', '1');
INSERT INTO students (name, surname, rating)
VALUES ('Daine', 'Casey', '3');
INSERT INTO students (name, surname, rating)
VALUES ('Torrie', 'Somers-Woodley', '2');
INSERT INTO students (name, surname, rating)
VALUES ('Len', 'Mora', '3');
INSERT INTO students (name, surname, rating)
VALUES ('Eulah', 'Hobbs', '2');
INSERT INTO students (name, surname, rating)
VALUES ('Susanne', 'Mccombs', '3');
INSERT INTO students (name, surname, rating)
VALUES ('Shonta', 'Snowden', '3');
INSERT INTO students (name, surname, rating)
VALUES ('Alyson', 'Mosier', '2');
INSERT INTO students (name, surname, rating)
VALUES ('Tyra', 'Combs', '2');
INSERT INTO students (name, surname, rating)
VALUES ('Deandra', 'Tibbetts', '3');
INSERT INTO students (name, surname, rating)
VALUES ('Beau', 'Rose', '4');
INSERT INTO students (name, surname, rating)
VALUES ('Devona', 'Schaefer', '1');
INSERT INTO students (name, surname, rating)
VALUES ('Beckie', 'Hutchens', '1');
INSERT INTO students (name, surname, rating)
VALUES ('Shon', 'Petrie', '1');
INSERT INTO students (name, surname, rating)
VALUES ('Bianca', 'Sellers', '1');
INSERT INTO students (name, surname, rating)
VALUES ('Estefana', 'Rodrigues', '2');
INSERT INTO students (name, surname, rating)
VALUES ('Mara', 'Costa', '3');
INSERT INTO students (name, surname, rating)
VALUES ('Shirely', 'Garland', '4');
INSERT INTO students (name, surname, rating)
VALUES ('Francesca', 'Linkous', '4');
INSERT INTO students (name, surname, rating)
VALUES ('Annetta', 'Gillum-Valenzuela', '4');
INSERT INTO students (name, surname, rating)
VALUES ('Sanjuana', 'Ragan', '4');
INSERT INTO students (name, surname, rating)
VALUES ('Anne', 'Foret', '1');
INSERT INTO students (name, surname, rating)
VALUES ('Vella', 'Munn', '4');
INSERT INTO students (name, surname, rating)
VALUES ('Rosie', 'Branson', '2');
INSERT INTO students (name, surname, rating)
VALUES ('Brock', 'Leger', '2');
INSERT INTO students (name, surname, rating)
VALUES ('Amelia', 'Dodson-Roberts', '1');
INSERT INTO students (name, surname, rating)
VALUES ('Cole', 'Vallejo', '1');
INSERT INTO students (name, surname, rating)
VALUES ('Tempie', 'Gracia-Reuter', '4');
INSERT INTO students (name, surname, rating)
VALUES ('Clara', 'Acevedo', '3');
INSERT INTO students (name, surname, rating)
VALUES ('Kanesha', 'Acuna', '1');
INSERT INTO students (name, surname, rating)
VALUES ('Corie', 'Chiu', '4');
INSERT INTO students (name, surname, rating)
VALUES ('Earl', 'Totten', '1');
INSERT INTO students (name, surname, rating)
VALUES ('Mittie', 'Kopp', '1');
INSERT INTO students (name, surname, rating)
VALUES ('Owen', 'Schaeffer', '4');
INSERT INTO students (name, surname, rating)
VALUES ('Jane', 'Villasenor', '4');
INSERT INTO students (name, surname, rating)
VALUES ('Bernetta', 'Dent', '3');
INSERT INTO students (name, surname, rating)
VALUES ('Wilfredo', 'Keating', '1');
INSERT INTO students (name, surname, rating)
VALUES ('Marta', 'Frey', '2');
INSERT INTO students (name, surname, rating)
VALUES ('Chloe', 'Chism-Cheek', '3');
INSERT INTO students (name, surname, rating)
VALUES ('Elli', 'Winn', '2');
INSERT INTO students (name, surname, rating)
VALUES ('Nedra', 'Mcmillan', '3');
INSERT INTO students (name, surname, rating)
VALUES ('Kesha', 'Greenwood', '2');
INSERT INTO students (name, surname, rating)
VALUES ('Hank', 'Tong', '1');
INSERT INTO students (name, surname, rating)
VALUES ('Doreatha', 'Seaton', '1');
INSERT INTO students (name, surname, rating)
VALUES ('Claudie', 'Mcgraw', '1');
INSERT INTO students (name, surname, rating)
VALUES ('Loraine', 'Thigpen', '4');
INSERT INTO students (name, surname, rating)
VALUES ('Ulysses', 'Gavin', '2');
INSERT INTO students (name, surname, rating)
VALUES ('Summer', 'Cranford', '3');
INSERT INTO students (name, surname, rating)
VALUES ('Loree', 'Bell', '2');
INSERT INTO students (name, surname, rating)
VALUES ('Marian', 'Meeker', '4');
INSERT INTO students (name, surname, rating)
VALUES ('Elida', 'Duong', '1');
INSERT INTO students (name, surname, rating)
VALUES ('Alejandrina', 'Arndt', '4');
INSERT INTO students (name, surname, rating)
VALUES ('Norma', 'Jaime', '2');
INSERT INTO students (name, surname, rating)
VALUES ('Melynda', 'Stiltner-Bird', '3');


--Дисциплины (Subjects)
CREATE TABLE IF NOT EXISTS subjects
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL UNIQUE
);


--Преподаватели (Teachers)
CREATE TABLE IF NOT EXISTS teachers
(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL,
	surname TEXT NOT NULL,
	isProfessor BLOB DEFAULT 0,
	salary REAL NOT NULL CHECK(salary > 0)
);

