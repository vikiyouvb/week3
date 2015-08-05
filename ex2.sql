SELECT * FROM students;

SELECT * FROM students WHERE name LIKE 'H%';

SELECT * FROM students WHERE name LIKE "%a%";

SELECT * FROM students ORDER BY students.name ASC;

SELECT * FROM students ORDER BY students.name ASC LIMIT 2;

SELECT * FROM students ORDER BY students.name ASC LIMIT 2,2;

SELECT * FROM marks WHERE marks.annual IS NULL;

SELECT marks.student_id,marks.subject_id,marks.year FROM marks WHERE marks.annual IS NULL AND marks.year=2005;

SELECT marks.student_id,marks.subject_id,marks.year FROM marks WHERE (marks.half_yearly IS NULL AND marks.annual IS NULL) OR (marks.quarterly IS NULL AND marks.annual IS NULL) OR (marks.quarterly IS NULL AND marks.half_yearly IS NULL);

SELECT marks.student_id,marks.subject_id,marks.quarterly,marks.half_yearly,marks.annual FROM marks WHERE marks.quarterly>90 AND marks.half_yearly>90 AND marks.annual>90;

SELECT marks.student_id,marks.subject_id,AVG(marks.quarterly) AS avg_quarterly,AVG(marks.half_yearly) AS avg_half_yearly,AVG(marks.annual) AS avg_annual,marks.year FROM marks GROUP BY marks.subject_id,marks.year;

SELECT marks.student_id,marks.subject_id,AVG(marks.quarterly) AS avg_quarterly,AVG(marks.half_yearly) AS avg_half_yearly,AVG(marks.annual) AS avg_annual,marks.year FROM marks GROUP BY marks.year,marks.subject_id HAVING marks.year IN (2003,2004);
