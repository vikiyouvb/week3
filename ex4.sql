SELECT students.name AS name FROM students INNER JOIN marks ON students.id=marks.student_id WHERE marks.quarterly IS NULL AND marks.half_yearly IS NULL AND marks.annual IS NULL;

SELECT students.name,COALESCE(SUM(marks.annual),0) AS marks,marks.year FROM students INNER JOIN marks ON marks.student_id=students.id  GROUP BY marks.student_id,marks.year;

SELECT students.name,COALESCE(SUM(marks.quarterly),0) AS total,marks.grade FROM students INNER JOIN marks ON marks.student_id=students.id GROUP BY marks.student_id,marks.year HAVING marks.year=2003;


 SELECT students.name AS name,medals.grade,COUNT(medals.id) AS no_of_medals FROM medals INNER JOIN students ON medals.student_id=students.id WHERE medals.student_id IN 
 ( SELECT medals.student_id FROM medals WHERE medals.grade=6 OR medals.grade=7 GROUP BY medals.student_id HAVING COUNT(medals.id)>3) 
 AND medals.grade=6 OR medals.grade=7 GROUP BY medals.student_id,medals.grade;


SELECT students.name AS name,marks.grade AS grade,COUNT(medals.id) AS no_of_medals FROM marks LEFT OUTER JOIN medals ON marks.student_id=medals.student_id INNER JOIN students ON students.id=marks.student_id GROUP BY marks.student_id HAVING COUNT(medals.id)<2;

SELECT students.name AS name,marks.year AS year FROM marks INNER JOIN students ON students.id=marks.student_id WHERE marks.student_id IN (SELECT students.id FROM students LEFT OUTER JOIN medals ON students.id=medals.student_id GROUP BY students.id HAVING COUNT(medals.id)=0) AND marks.annual>90 GROUP BY marks.student_id,marks.year HAVING COUNT(marks.id)=5;
 
SELECT students.name,medals.game_id,medals.medal_won,medals.year,medals.grade FROM students INNER JOIN medals ON students.id=medals.student_id WHERE students.id IN (SELECT medals.student_id FROM medals GROUP BY medals.student_id HAVING COUNT(medals.id)>3);

