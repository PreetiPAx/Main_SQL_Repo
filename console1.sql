--CREATE TABLE COMMAND:
CREATE TABLE suppliers(
    supplier_id INT
   , supplier_name VARCHAR(20)
   , city VARCHAR(20)
   , state VARCHAR(20)
   , total_spent INT
);

SHOW DATABASES;

-- TEST TABLE:
SELECT * FROM SUPPLIERS ;

-- INSERT VALUES:
INSERT INTO suppliers VALUES(100, 'shop of Epiphany', 'Augusta', 'Georgea', 220500);
INSERT INTO suppliers VALUES(200, 'Instant Assemblers', 'Valdez', 'Alaska', 37000);
INSERT INTO suppliers VALUES(300,'Time Manufectures', 'Redwood City', 'California', 90500);
INSERT INTO suppliers VALUES(400, 'Roundhouse Inc.', 'Newyork City',  'New york' , 78150);
INSERT INTO suppliers VALUES(500,'Smiths & Berries', 'Portland', 'Oregon', 114600);
INSERT INTO suppliers VALUES(600,'Wesson LLC', 'Yuma', 'Alaska', 32000);
INSERT INTO suppliers VALUES(700, 'ICF foods', 'Orlando', 'California', 78700);
INSERT INTO suppliers VALUES(800,'Cheffmens Inc.', 'Toledo', 'Georgea', 187500);
INSERT INTO suppliers VALUES (900, 'Samwoods Drinks', 'Portland', 'Georgia', 17800);

-- EXERCISE::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
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

COMMIT;

CREATE TABLE student(
    student_id INT PRIMARY KEY,
    name VARCHAR(10),
    major VARCHAR(10)
    );

DESCRIBE student;



