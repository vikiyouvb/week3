#1

CREATE TABLE students_summary
(
	student_id INT NOT NULL,
	student_name VARCHAR(100) NOT NULL,
	year INT NOT NULL,
	percentage DEC(5,2) NOT NULL,
	no_of_medals_received INT NOT NULL
);

#2

INSERT INTO students_summary (student_id,student_name,year,percentage,no_of_medals_received)
(SELECT temp.student_id,temp.student_name,temp.year,temp.percentage,COUNT(medals.id) AS no_of_medals_received FROM (SELECT students.id AS student_id,students.name AS student_name,COALESCE(ROUND(SUM(marks.annual)/5,2),0) AS percentage,marks.year AS year FROM students INNER JOIN marks ON marks.student_id=students.id GROUP BY marks.student_id,marks.year) AS temp LEFT OUTER JOIN medals ON medals.student_id=temp.student_id AND medals.year=temp.year GROUP BY temp.student_id,temp.year);