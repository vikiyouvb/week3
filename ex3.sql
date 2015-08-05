SELECT students.name FROM students INNER JOIN marks ON students.id=marks.student_id WHERE marks.annual IS NULL;

SELECT students.name FROM students INNER JOIN marks ON students.id=marks.student_id WHERE marks.annual IS NULL AND marks.year=2005;

SELECT students.name,marks.year FROM students INNER JOIN marks ON students.id=marks.student_id WHERE (marks.half_yearly IS NULL AND marks.annual IS NULL) OR (marks.quarterly IS NULL AND marks.annual IS NULL) OR (marks.quarterly IS NULL AND marks.half_yearly IS NULL);

SELECT students.name,marks.quarterly,marks.half_yearly,marks.annual FROM students INNER JOIN marks WHERE marks.quarterly>90 AND marks.half_yearly>90 AND marks.annual>90;
