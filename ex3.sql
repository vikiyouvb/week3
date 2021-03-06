#2.1
SELECT students.name FROM students INNER JOIN marks ON students.id=marks.student_id WHERE marks.annual IS NULL;

#2.2
SELECT students.name FROM students INNER JOIN marks ON students.id=marks.student_id WHERE marks.annual IS NULL AND marks.year=2005;

#2.3
SELECT students.name,marks.year FROM students INNER JOIN marks ON students.id=marks.student_id WHERE (marks.quarterly IS NOT NULL OR marks.half_yearly IS NOT NULL OR marks.annual IS NOT NULL) AND ((marks.half_yearly IS NULL AND marks.annual IS NULL) OR (marks.quarterly IS NULL AND marks.annual IS NULL) OR (marks.quarterly IS NULL AND marks.half_yearly IS NULL));

#2.4
SELECT students.name,marks.quarterly,marks.half_yearly,marks.annual FROM students INNER JOIN marks ON marks.student_id=students.id WHERE marks.quarterly>90 AND marks.half_yearly>90 AND marks.annual>90;

#2.5
SELECT students.name,marks.subject_id,AVG(marks.quarterly) AS avg_quarterly,AVG(marks.half_yearly) AS avg_half_yearly,AVG(marks.annual) AS avg_annual,marks.year FROM students INNER JOIN marks ON marks.student_id=students.id GROUP BY marks.student_id,marks.subject_id,marks.year;

#2.6
SELECT students.name,marks.subject_id,AVG(marks.quarterly) AS avg_quarterly,AVG(marks.half_yearly) AS avg_half_yearly,AVG(marks.annual) AS avg_annual,marks.year FROM students INNER JOIN marks ON marks.student_id=students.id GROUP BY marks.student_id,marks.year,marks.subject_id HAVING marks.year IN (2003,2004);