SHOW DATABASES;
USE DEMO;
SHOW TABLES;

-- CREATE TABLE suppliers(
--     supplier_id INT
--    , supplier_name VARCHAR(20)
--    , city VARCHAR(20)
--    , state VARCHAR(20)
--    , total_spent INT
-- );
SELECT * FROM SUPPLIERS ;

INSERT INTO suppliers VALUES(100, 'shop of Epiphany', 'Augusta', 'Georgea', 220500);
INSERT INTO suppliers VALUES(200, 'Instant Assemblers', 'Valdez', 'Alaska', 37000);
INSERT INTO suppliers VALUES(300,'Time Manufectures', 'Redwood City', 'California', 90500);
INSERT INTO suppliers VALUES(400, 'Roundhouse Inc.', 'Newyork City',  'New york' , 78150);
INSERT INTO suppliers VALUES(500,'Smiths & Berries', 'Portland', 'Oregon', 114600);
INSERT INTO suppliers VALUES(600,'Wesson LLC', 'Yuma', 'Alaska', 32000);
INSERT INTO suppliers VALUES(700, 'ICF foods', 'Orlando', 'California', 78700);
INSERT INTO suppliers VALUES(800,'Cheffmens Inc.', 'Toledo', 'Georgea', 187500);
INSERT INTO suppliers VALUES (900, 'Samwoods Drinks', 'Portland', 'Georgia', 17800);


SELECT *
FROM suppliers
WHERE state='Georgia'
   OR State='California';

SELECT *
FROM suppliers
WHERE  supplier_name LIKE '%wo%'
  AND ( supplier_name LIKE '%i%'
    OR supplier_name LIKE '%I%')
;
SELECT 'pizza' AS food
     , UPPER('fanta') AS drink
     , UPPER(CONCAT ('hello','  preeti')) AS "This is a func"
FROM DUAL;
SELECT UPPER ('jhdkeh') FROM DUAL;

SELECT CONCAT(LOWER(ename), ' is the name') FROM emp;
SELECT * FROM emp;
SELECT CONCAT(CONCAT(LOWER(ename),UPPER('  is the name')), ' and their job is:') ||job FROM emp;
SELECT CONCAT(CONCAT(LOWER(ename), ' IS THE NAME'), CONCAT(' and their job is:', job)) AS SUMMERY from emp;
SELECT INITCAP('my name is preeti') AS BIO FROM DUAL;

SELECT ename, LENGTH(ename) AS length FROM emp
WHERE LENGTH(ename)=6;

SELECT 'hello my name is preeti', SUBSTR('hello my name is preeti', 6, 6) FROM DUAL;

SELECT 'hello my name is preeti', SUBSTR('hello my name is preeti', 5, 6) FROM DUAL;

SELECT LPAD('hello', 20, '-') FROM DUAL;

SELECT RPAD('preeti',10, '*') FROM DUAL;

SELECT LTRIM('hhhheellllooooohhhhh','h') FROM DUAL;
SELECT RTRIM('hhhheeellllloooooooh', 'h') FROM DUAL;

SELECT ROUND (567.0886754, 3) FROM DUAL;
SELECT ROUND(567.89) FROM DUAL;
SELECT TRUNC(456.6672683762) FROM DUAL;
SELECT TRUNC(5748784.767487897, 3) FROM DUAL;
SELECT TRUNC(5748784.767487897, -2) FROM DUAL;

SELECT ROUND(5748784.767487897, -2) FROM DUAL;
SELECT SYSDATE FROM DUAL;
UTC
PST
CT
SELECT SYSTIMESTAMP FROM DUAL;
SELECT ADD_MONTHS(TO_DATE('2024-07-02' , 'YYYY-MM-DD'), -5) AS sa FROM DUAL;-----------------------

SELECT MONTHS_BETWEEN( TO_DATE('2024/07/02', 'YYYY/MM/DD' ), TO_DATE('2022/07/02', 'YYYY/MM/DD')  ) FROM DUAL;---------

SELECT MONTHS_BETWEEN('12/4/2023', '12/4/2023') AS rn FROM DUAL;


SELECT TRUNC(SYSTIMESTAMP) FROM DUAL;

SELECT TRUNC(SYSTIMESTAMP, 'YEAR') FROM DUAL;
SELECT TRUNC(SYSTIMESTAMP, 'MONTH') FROM DUAL;

SELECT ename, hiredate
     , TO_CHAR( hiredate , 'Dy')  hire_date_day
     ,  TRUNC(Hiredate,'DAY') AS trunc_
     , TO_CHAR( TRUNC(Hiredate,'DAY') , 'Dy') AS TRUNC_DAY FROM emp;


SELECT ename, hiredate
     ,  TRUNC(hiredate,'CC') AS trunc_
FROM emp

         SELECT TO_CHAR(SYSDATE, 'DD-MM-YYYY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'DD/MM/YYYY') FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'DDth "of" MONTH,YYYY') FROM DUAL;

SELECT * FROM EMP;
SELECT ename, sal, TO_CHAR(sal, '$99,999.000') AS saleries FROM emp;

SELECT SYSDATE FROM DUAL;
SELECT TO_DATE('25/07/2024', 'DD/MM/YYYY') FROM DUAL;

SELECT NLS_DATE_FORMATE('25/07/2024', 'DD/MM/YYYY');



ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY';
-------------------------------------------------------------------------------------------------------------------------
COMMIT;
SELECT * FROM EMP;

SELECT * FROM employee;




CREATE TABLE employee (
                          emp_id INT , --PRIMARY KEY ,
                          first_name VARCHAR(40),
                          last_name VARCHAR(40),
                          birth_day DATE,
                          sex VARCHAR(1),
                          salary INT,
                          super_id INT,
                          branch_id INT
);

COMMIT;
SELECT * FROM branch;
CREATE TABLE branch (
                        branch_id INT , --PRIMARY KEY,
                        branch_name VARCHAR(40),
                        mgr_id INT,
                        mgr_start_date DATE
--                         ,FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

-----ALTER TABLE employee
   ------ ADD FOREIGN KEY(branch_id)
     -----   REFERENCES branch(branch_id)
         ---   ON DELETE SET NULL;

----ALTER TABLE employee
   ---- ADD FOREIGN KEY(super_id)
       --- REFERENCES employee(emp_id)
           --- ON DELETE SET NULL;

CREATE TABLE client (
                        client_id INT PRIMARY KEY,
                        client_name VARCHAR(40),
                        branch_id INT
                        --FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

CREATE TABLE works_with (
                            emp_id INT,
                            client_id INT,
                            total_sales INT
                            ---PRIMARY KEY(emp_id, client_id),
                           --- FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
                            ---FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier (
                                 branch_id INT,
                                 supplier_name VARCHAR(40),
                                 supply_type VARCHAR(40)
                                 ----PRIMARY KEY(branch_id, supplier_name),
                                 ---FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);


-SELECT *FROM employee;- -----------------------------------------------------------------------------

-- Corporate
INSERT INTO employee VALUES(100, 'David', 'Wallace', TO_DATE('1967-11-17', 'YYYY-MM-DD'), 'M', 250000, NULL, NULL);

INSERT INTO branch VALUES(1, 'Corporate', 100, TO_DATE('2006-02-09', 'YYYY-MM-DD'));

SELECT * FROM branch;
SELECT * FROM employee;
UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO employee VALUES(101, 'Jan', 'Levinson', TO_DATE('1961-05-11','YYYY-MM-DD'), 'F', 110000, 100, 1);
INSERT INTO employee VALUES(102, 'Michael', 'Scott', TO_DATE('1964-03-15', 'YYYY-MM-DD' ), 'M', 75000, 100, NULL);


-------- Scranton
INSERT INTO branch VALUES(2, 'Scranton', 102, TO_DATE('1992-04-06','YYYY-MM-DD'));

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;


INSERT INTO employee VALUES(103, 'Angela', 'Martin', TO_DATE('1971-06-25', 'YYYY-MM-DD' ), 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', TO_DATE('1980-02-05', 'YYYY-MM-DD' ), 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', TO_DATE('1958-02-19', 'YYYY-MM-DD' ), 'M', 69000, 102, 2);








-- Stamford
INSERT INTO employee VALUES(106, 'Josh', 'Porter', TO_DATE('1969-09-05', 'YYYY-MM-DD'), 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, TO_DATE('1998-02-13', 'YYYY-MM-DD'));

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard',TO_DATE ('1973-07-22','YYYY-MM-DD'), 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', TO_DATE('1978-10-01', 'YYYY-MM-DD'), 'M', 71000, 106, 3);

SELECT * FROM Branch_supplier;



-- BRANCH SUPPLIER
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');


 SELECT *FROM Client;
-- CLIENT
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

SELECT *FROM Works_With;
-- WORKS_WITH
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);



-----------------------------------------------------------------------------------

SELECT * FROM user_constraints WHERE TABLE_NAME = 'BRANCH';
SELECT * FROM user_constraints WHERE TABLE_NAME = 'EMPLOYEE';
SELECT * FROM user_constraints WHERE TABLE_NAME = 'WORKS_WITH';
SELECT * FROM user_constraints WHERE TABLE_NAME = 'BRANCH_SUPPLIER';
SELECT * FROM user_constraints WHERE TABLE_NAME = 'CLIENT';

ALTER TABLE client ADD PRIMARY KEY(CLIENT_ID);


SELECT *FROM Works_with;
SELECT * FROM client;
ALTER TABLE Works_with ADD PRIMARY KEY(EMP_ID,CLIENT_ID);
ALTER TABLE Works_with ADD FOREIGN KEY(EMP_ID) REFERENCES EMPLOYEE(EMP_ID) ;
ALTER TABLE Works_with ADD FOREIGN KEY(CLIENT_ID) REFERENCES CLIENT(CLIENT_ID) ;

SELECT * FROM Branch_supplier;

SELECT * FROM employee;
ALTER TABLE Branch ADD PRIMARY KEY(Branch_Id);
ALTER TABLE Branch ADD FOREIGN KEY(MGR_ID) REFERENCES employee(EMP_ID) ;

ALTER TABLE EMPLOYEE DROP CONSTRAINT SYS_C008317;
ALTER TABLE BRANCH DROP CONSTRAINT SYS_C008318 ;
ALTER TABLE CLIENT DROP CONSTRAINT SYS_C008322 ;
ALTER TABLE WORKS_WITH DROP CONSTRAINT SYS_C008324 ;
ALTER TABLE BRANCH_SUPPLIER DROP CONSTRAINT SYS_C008327 ;

--CTAS
CREATE TABLE employee_temp AS SELECT * FROM employee;
CREATE TABLE branch_temp AS SELECT * FROM branch;

COMMIT;

DROP TABLE client;

--------QUERIES------------------------------------

SELECT * FROM employee
ORDER BY salary;

SELECT First_name, Sex
FROM employee
ORDER BY sex, First_name;

SELECT employee.first_name AS Forename, Employee.Last_name AS Surname
From Employee;

SELECT DISTINCT sex
FROM employee;

SELECT *
FROM employee
WHERE SEX = 'M';


SELECT *
FROM employee
WHERE Branch_id = 2;

SELECT Employee.emp_id
     , Employee.First_name
     , birth_day
FROM employee
-- WHERE Birth_day > TO_DATE('1969-01-01','YYYY-MM-DD');
WHERE EXTRACT(YEAR FROM Birth_day ) > 1969


SELECT *
FROM employee
WHERE SEX = 'F' AND Branch_id=2;

SELECT *
FROM employee
WHERE ( SEX = 'F' AND BIRTH_DAY> TO_DATE('1969-01-01', 'YYYY-MM-DD') )OR SALARY> 80000;


SELECT *
FROM employee
WHERE (birth_day >= TO_DATE('1970-01-01', 'YYYY-MM-DD') AND sex = 'F') OR salary > 80000;

SELECT *
FROM employee
WHERE BIRTH_DAY BETWEEN TO_DATE('1970-01-01', 'YYYY-MM-DD') AND TO_DATE('1975-01-01', 'YYYY-MM-DD');

SELECT *
FROM employee
WHERE First_name IN('Jim', 'Michael', 'Johnny','David');


