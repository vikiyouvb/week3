#1
SELECT students.name AS name FROM students INNER JOIN marks ON students.id=marks.student_id WHERE marks.quarterly IS NULL AND marks.half_yearly IS NULL AND marks.annual IS NULL;

#2
SELECT students.name,COALESCE(SUM(marks.annual),0) AS marks,marks.year FROM students INNER JOIN marks ON marks.student_id=students.id  GROUP BY marks.student_id,marks.year;

#3
SELECT students.name,COALESCE(SUM(marks.quarterly),0) AS total,marks.grade FROM students INNER JOIN marks ON marks.student_id=students.id GROUP BY marks.student_id,marks.year HAVING marks.year=2003;

#4
SELECT students.name AS name,medals.grade,COUNT(medals.id) AS no_of_medals FROM medals INNER JOIN students ON medals.student_id=students.id WHERE medals.student_id IN 
( SELECT medals.student_id FROM medals WHERE medals.grade=6 OR medals.grade=7 GROUP BY medals.student_id HAVING COUNT(medals.id)>3) 
AND medals.grade=6 OR medals.grade=7 GROUP BY medals.student_id,medals.grade;

#5
SELECT students.name AS name,marks.grade AS grade,COUNT(medals.id) AS no_of_medals FROM marks LEFT OUTER JOIN medals ON marks.student_id=medals.student_id INNER JOIN students ON students.id=marks.student_id GROUP BY marks.student_id HAVING COUNT(medals.id)<2;

#6
SELECT students.name AS name,marks.year AS year FROM marks INNER JOIN students ON students.id=marks.student_id WHERE marks.student_id IN (SELECT students.id FROM students LEFT OUTER JOIN medals ON students.id=medals.student_id GROUP BY students.id HAVING COUNT(medals.id)=0) AND marks.annual>90 GROUP BY marks.student_id,marks.year HAVING COUNT(marks.id)=5;

#7 
SELECT students.name,medals.game_id,medals.medal_won,medals.year,medals.grade FROM students INNER JOIN medals ON students.id=medals.student_id WHERE students.id IN (SELECT medals.student_id FROM medals GROUP BY medals.student_id HAVING COUNT(medals.id)>3);

#8
SELECT students.name,COUNT(medals.id) AS medals,temp.quarterly_per,temp.half_yearly_per,temp.annual_per,temp.year,temp.grade FROM 
(SELECT marks.student_id AS student_id,COALESCE(ROUND(SUM(marks.quarterly)/5,2),0) AS quarterly_per,COALESCE(ROUND(SUM(marks.half_yearly)/5,2),0) AS half_yearly_per,COALESCE(ROUND(SUM(marks.annual)/5,2),0) AS annual_per,marks.year AS year,marks.grade AS grade FROM marks GROUP BY marks.student_id,marks.year)
AS temp LEFT OUTER JOIN medals ON temp.student_id=medals.student_id AND temp.year=medals.year INNER JOIN students ON students.id=temp.student_id GROUP BY temp.student_id,temp.year;

#9
DELIMITER $
CREATE FUNCTION getRating(total INT) RETURNS CHAR(1)
BEGIN
DECLARE res CHAR(1);
IF total BETWEEN 450 AND 500 THEN
SET res='S';
ELSEIF total BETWEEN 400 AND 449 THEN
SET res='A';
ELSEIF total BETWEEN 350 AND 399 THEN
SET res='B';
ELSEIF total BETWEEN 300 AND 349 THEN
SET res='C';
ELSEIF total BETWEEN 250 AND 299 THEN
SET res='D';
ELSEIF total BETWEEN 200 AND 249 THEN
SET res='E';
ELSE
SET res='F';
END IF;
RETURN res;
END$
DELIMITER ;

SELECT students.name,getRating(temp.quarterly_total) AS quarterly_rating,getRating(temp.half_yearly_total) AS half_yearly_rating,getRating(temp.annual_total) AS annual_rating,temp.year,temp.grade
FROM (SELECT marks.student_id AS student_id,COALESCE(SUM(marks.quarterly),0) AS quarterly_total,COALESCE(SUM(marks.half_yearly),0) AS half_yearly_total,COALESCE(SUM(marks.annual),0) AS annual_total,marks.year AS year,marks.grade AS grade FROM marks GROUP BY marks.student_id,marks.year) AS temp INNER JOIN students ON students.id=temp.student_id; 