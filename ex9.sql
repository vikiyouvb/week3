#1
ALTER TABLE marks
ADD COLUMN average DEC(8,3) NOT NULL;

#2
DELIMITER $
CREATE TRIGGER after_marks_insert BEFORE INSERT ON marks FOR EACH ROW
BEGIN
SET @avgval=(COALESCE(NEW.quarterly,0)+COALESCE(NEW.half_yearly,0)+COALESCE(NEW.annual,0))/3;
SET NEW.average=@avgval;
END$

CREATE TRIGGER after_marks_update BEFORE UPDATE ON marks FOR EACH ROW
BEGIN
SET @avgval=(COALESCE(NEW.quarterly,0)+COALESCE(NEW.half_yearly,0)+COALESCE(NEW.annual,0))/3;
SET NEW.average=@avgval;
END$
DELIMITER ;

#3
ALTER TABLE medals CHANGE COLUMN medal_won medal_received VARCHAR(10);

#4
ALTER TABLE medals CHANGE COLUMN medal_received medal_won VARCHAR(10);
ALTER TABLE medals ADD COLUMN medal_received VARCHAR(10);

#5
DELIMITER $
CREATE TRIGGER after_medals_insert BEFORE INSERT ON medals FOR EACH ROW
BEGIN
IF ISNULL(NEW.medal_won) THEN
	SET NEW.medal_won=NEW.medal_received;
ELSE SET NEW.medal_received=NEW.medal_won;
END IF; 
END$

CREATE TRIGGER after_medals_update BEFORE UPDATE ON medals FOR EACH ROW
BEGIN
IF ISNULL(NEW.medal_won) THEN
	SET NEW.medal_won=NEW.medal_received;
ELSE SET NEW.medal_received=NEW.medal_won;
END IF; 
END$
DELIMITER ;

#6
ALTER TABLE medals DROP COLUMN medal_won;