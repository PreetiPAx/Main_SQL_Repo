# CREATE DATABASE Demo;
# SHOW DATABASES;
# USE Demo;
-------------CREATE TABLE------------
CREATE TABLE student(
                        student_id INT PRIMARY KEY,
                        name VARCHAR(10),
                        major VARCHAR(10)
);
-----------SHOW STUDENT TABLE--------
SELECT * FROM student;
DESCRIBE student;

----------------INSERT VALUES----------

INSERT INTO student VAlUES(1, 'Jack', 'Biology');
INSERT INTO student VAlUES(2,'Kate', 'Sociology');
INSERT INTO student VAlUES(3,'Claire', 'English');
INSERT INTO student VAlUES(4, 'Jack', 'BIology');
INSERT INTO student VAlUES(5, 'Mike','Comp. sci.') ;


---------DELETE & UPDATE---------

UPDATE student
SET major= 'Bio'
WHERE Major ='Biology';