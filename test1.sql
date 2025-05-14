SHOW DATABASES;


CREATE TABLE employees (
                           emp_id INT PRIMARY KEY,
                           emp_name VARCHAR(50) NOT NULL,
                           job_name VARCHAR(50) NOT NULL,
                           manager_id INT NULL,
                           hire_date DATE NOT NULL,
                           salary DECIMAL(10,2) NOT NULL,
                           commission DECIMAL(10,2) NULL,
                           dep_id INT NOT NULL
);

INSERT INTO employees (emp_id, emp_name, job_name, manager_id, hire_date, salary, commission, dep_id) VALUES
                                                                                                          (68319, 'KAYLING', 'PRESIDENT', NULL, '1991-11-18', 6000.00, NULL, 1001),
                                                                                                          (66928, 'BLAZE', 'MANAGER', 68319, '1991-05-01', 2750.00, NULL, 3001),
                                                                                                          (67832, 'CLARE', 'MANAGER', 68319, '1991-06-09', 2550.00, NULL, 1001),
                                                                                                          (65646, 'JONAS', 'MANAGER', 68319, '1991-04-02', 2957.00, NULL, 2001),
                                                                                                          (67858, 'SCARLET', 'ANALYST', 65646, '1997-04-19', 3100.00, NULL, 2001),
                                                                                                          (69062, 'FRANK', 'ANALYST', 65646, '1991-12-03', 3100.00, NULL, 2001),
                                                                                                          (63679, 'SANDRINE', 'CLERK', 69062, '1990-12-18', 900.00, NULL, 2001),
                                                                                                          (64989, 'ADELYN', 'SALESMAN', 66928, '1991-02-20', 1700.00, 400.00, 3001),
                                                                                                          (65271, 'WADE', 'SALESMAN', 66928, '1991-02-22', 1350.00, 600.00, 3001),
                                                                                                          (66564, 'MADDEN', 'SALESMAN', 66928, '1991-09-28', 1350.00, 1500.00, 3001),
                                                                                                          (68454, 'TUCKER', 'SALESMAN', 66928, '1991-09-08', 1600.00, 0.00, 3001),
                                                                                                          (68736, 'ADNRES', 'CLERK', 67858, '1997-05-23', 1200.00, NULL, 2001),
                                                                                                          (69000, 'JULIUS', 'CLERK', 66928, '1991-12-03', 1050.00, NULL, 3001),
                                                                                                          (69324, 'MARKER', 'CLERK', 67832, '1992-01-23', 1400.00, NULL, 1001);

CREATE TABLE departments (
                             dep_id INT PRIMARY KEY,
                             dep_name VARCHAR(50) NOT NULL,
                             dep_location VARCHAR(50) NOT NULL
);

INSERT INTO departments (dep_id, dep_name, dep_location) VALUES
                                                             (1001, 'FINANCE', 'SYDNEY'),
                                                             (2001, 'AUDIT', 'MELBOURNE'),
                                                             (3001, 'MARKETING', 'PERTH'),
                                                             (4001, 'PRODUCTION', 'BRISBANE');


CREATE TABLE salary_grades (
                               grade INT PRIMARY KEY,
                               min_sal INT NOT NULL,
                               max_sal INT NOT NULL
);

INSERT INTO salary_grades (grade, min_sal, max_sal) VALUES
                                                        (1, 800, 1300),
                                                        (2, 1301, 1500),
                                                        (3, 1501, 2100),
                                                        (4, 2101, 3100),
                                                        (5, 3101, 9999);




SELECT * FROM employees;
SELECT * FROM salary_grades;
select * FROM employees
WHERE job_name = 'manager';

===================1st answer==================
SELECT *
FROM employees
WHERE emp_id IN
      (SELECT manager_id
       FROM employees);
===============================================


SELECT CURRENT_DATE;
SELECT CURRENT_TIMESTAMP ;


==============================2nd answer====================================
SELECT emp_id,
       emp_name,
       job_name,
       hire_date,
       CONCAT(
               TIMESTAMPDIFF(YEAR, hire_date, CURDATE()), ' years, ',
               TIMESTAMPDIFF(MONTH, hire_date, CURDATE()) % 12, ' months, ',
               DATEDIFF(CURDATE(),
                        DATE_ADD(
                                DATE_ADD(hire_date, INTERVAL TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) YEAR),
                                INTERVAL TIMESTAMPDIFF(MONTH, hire_date, CURDATE()) % 12 MONTH
                        )
               ), ' days'
       ) AS experience
FROM employees
WHERE emp_id IN (SELECT manager_id FROM employees);

============================================================================

SELECT * FROM departments;


=========================3rd answer=========================================

SELECT e.emp_id,
       e.emp_name,
       e.salary,
       d.dep_name
FROM employees e,
     departments d
WHERE d.dep_location IN('SYDNEY', 'PERTH')
    AND e.dep_id = d.dep_id
    AND e.emp_id IN(SELECT e.emp_id FROM employees e
                                    WHERE e.job_name IN('MANAGER', 'ANALYST')
                                    AND TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) > 5
                                        AND e.commission IS NULL)
                                    ORDER BY d.dep_location ASC;
==============================================================================
============================or===============================================
SELECT e.emp_id,
       e.emp_name,
       e.salary,
       d.dep_name,
       d.dep_location,
       e.job_name,
       e.hire_date,
       e.commission
FROM employees e
         JOIN departments d ON e.dep_id = d.dep_id  -- Assuming `dep_id` is the common key
WHERE d.dep_location IN ('SYDNEY', 'PERTH')
  AND e.job_name IN ('MANAGER', 'ANALYST')
  AND (EXTRACT(YEAR FROM CURRENT_DATE()) -
       EXTRACT(YEAR FROM STR_TO_DATE(e.hire_date, '%Y-%m-%d'))) > 5
  AND e.commission IS NULL;
================================or answer============================

SELECT e.emp_id,
       e.emp_name,
       e.salary,
       d.dep_name
      FROM employees e,
     departments d
WHERE d.dep_location IN('SYDNEY', 'PERTH')
AND e.job_name IN('MANAGER', 'ANALYST')
AND e.dep_id = d.dep_id
AND (EXTRACT(YEAR FROM CURDATE()) - (EXTRACT(YEAR FROM e.hire_date))) > 5
AND e.commission IS NULL;

===========================4th answer=====================================

SELECT e.emp_id,
       e.emp_name,
       e.salary,
       d.dep_name,
       d.dep_location,
       d.dep_id,
       e.job_name
FROM employees e
JOIN departments d ON e.dep_id = d.dep_id
WHERE (d.dep_location = 'SYDNEY'
OR d.dep_name = 'FINANCE')
AND e.emp_id IN(SELECT e.emp_id FROM employees
                WHERE (12*e.salary) > 28000
                AND e.salary NOT IN(3000, 2800)
                AND e.job_name != 'MANAGER'
                AND (CONVERT(emp_id, CHAR) LIKE '__3%'
                    OR CONVERT(emp_id, CHAR) LIKE '--7%'))
ORDER BY e.emp_id ASC,
         e.job_name DESC;

#=================================5th answer========================================

# Method :1
SELECT *
FROM employees e ,
     salary_grades s
WHERE e.salary BETWEEN s.min_sal AND s.max_sal
AND s.grade IN  (2, 3);

==================================6th answer========================================
SELECT *
FROM employees e,
     salary_grades s
WHERE e.salary BETWEEN s.min_sal AND s.max_sal
  AND s.grade IN (4, 5)
  AND e.emp_id IN (SELECT e.emp_id
                   FROM EMPLOYEES e
                   WHERE e.job_name IN ('ANALYST', 'MANAGER'))
;
================================  or==============================
SELECT *
FROM employees e,
     salary_grades s
WHERE e.salary BETWEEN s.min_sal AND s.max_sal
AND s.grade IN (4,5)
AND e.job_name IN ('MANAGER', 'ANALYST');

===================================7th answer=======================

SELECT *
FROM employees
WHERE salary >(SELECT salary FROM employees
    WHERE emp_name= 'JONAS');

===================================8th answer========================

SELECT *
FROM employees
WHERE job_name =(SELECT job_name FROM employees
                                 WHERE emp_name= 'FRANK') ;

=================================9th answer=========================

SELECT *
FROM employees
WHERE hire_date<(SELECT hire_date FROM employees
                                   WHERE emp_name= 'ADELYN');
=================================10th answer========================

SELECT *
FROM employees e
JOIN departments d ON e.dep_id= d.dep_id
WHERE d.dep_id=2001
AND JOB_NAME IN ( SELECT e.job_name FROM employees e, departments d
                                      WHERE e.dep_id= d.dep_id
                                      AND    d.dep_id= 1001
                                     );

===============================or==========================

SELECT *
FROM employees e
WHERE e.dep_id = 2001
  AND e.job_name IN (
    SELECT job_name
    FROM employees
    WHERE dep_id = 1001
);

==================================== 11th answer======================

SELECT *
FROM employees
WHERE salary IN( SELECT salary FROM employees e
                               WHERE emp_name IN('FRANK', 'SANDRINE')
                               AND employees.emp_id <> e.emp_id)
ORDER BY salary DESC;

===================================12th answer=======================

SELECT *
FROM employees
WHERE Job_name=(SELECT job_name FROM employees
                                WHERE emp_name='MARKER')
                                OR salary>(SELECT salary FROM employees
                                                          WHERE emp_name='ADELYN');

=================================13th answer========================

SELECT *
FROM employees
WHERE salary >(SELECT MAX(salary + commission)
               FROM employees
               WHERE job_name ='SALESMAN');
================or===============

SELECT *
FROM employees
WHERE salary > (
    SELECT SUM(salary + IFNULL(commission, 0))
    FROM employees
    WHERE job_name = 'SALESMAN'
);
=======================14th answer===========================
SELECT *
FROM employees e
JOIN departments d ON e.dep_id=d.dep_id
WHERE e.hire_date <( SELECT e.hire_date FROM employees e
                     WHERE e.emp_name='BLAZE')
                     AND d.dep_location IN ('PERTH', 'BRISBANE')
;

=====================15th question============================

SELECT *
FROM employees e
JOIN departments d ON e.dep_id=d.dep_id
JOIN salary_grades s ON e.salary BETWEEN s.min_sal AND s.max_sal
WHERE d.dep_name IN ('FINANCE', 'AUDIT')
AND s.grade IN (3,4)
AND e.salary > (
    SELECT salary
    FROM employees
    WHERE emp_name='ADELYN')
AND hire_date<(SELECT hire_date FROM employees  WHERE
emp_name='FRANK');

=======================16th answer================================

SELECT *
FROM employees
WHERE  job_name IN (SELECT job_name  FROM employees
WHERE emp_name IN ('SANDRINE', 'ADELYN'));

======================17th anwer=================================

SELECT e.job_name
FROM employees e
                  WHERE e.dep_id = 1001
AND e.job_name NOT IN (SELECT job_name FROM employees
                                       WHERE dep_id = 2001
                                       );

=======================18th answer===============================

SELECT *
FROM employees e
WHERE  e.salary =(SELECT MAX(SALARY)
                  FROM employees
                  );

====================19TH ANSWER==================================

SELECT *
FROM employees e
JOIN departments d ON e.dep_id=d.dep_id
WHERE d.dep_name = 'MARKETING'
AND e.salary=(SELECT MAX(salary)
              FROM employees e1
              JOIN departments d1 ON e1.dep_id=d1.dep_id
              WHERE d1.dep_name='MARKETING');

===================20th answer===================================

SELECT e.emp_id,
       e.emp_name,
       e.job_name,
       e.hire_date,
       e.salary
FROM employees e
JOIN departments d ON e.dep_id=d.dep_id
JOIN salary_grades s ON e.salary BETWEEN s.min_sal AND s.max_sal
WHERE s.grade=3
  AND d.dep_location ='PERTH'
AND e.hire_date=(SELECT MAX(e1.hire_date)
    FROM employees e1
JOIN departments d1 ON e1.dep_id=d1.dep_id
    WHERE d1.dep_location ='PERTH'
    AND e1.salary BETWEEN s.min_sal AND s.max_sal
    );

===================21 answer======================================


SELECT *
FROM employees e
WHERE e.hire_date < (
SELECT MAX(e1.hire_date)
                            FROM employees e1
                            WHERE e1.manager_id IN
                            (SELECT emp_id FROM employees
                            WHERE emp_name='KAYLING'));


============================answer 22================================

SELECT *
FROM employees e
JOIN departments d
    ON e.dep_id = d.dep_id
JOIN salary_grades s
    ON e.salary BETWEEN s.min_sal AND s.max_sal
WHERE s.grade BETWEEN 3 AND 5
AND d.dep_location='SYDNEY'
AND e.job_name != 'PRESIDENT'
AND e.salary > (SELECT MAX(e1.salary)
                FROM employees e1
                JOIN departments d1
                    ON e1.dep_id = d1.dep_id
                WHERE d1.dep_location = 'PERTH'
                  AND e1.manager_id <> (SELECT emp_id
                                       FROM employees
                                       WHERE emp_name = 'KAYLING')
                  AND e1.job_name IN ('MANAGER', 'SALESMAN'));

=============================or
SELECT *
FROM employees A , salary_grades B , departments C
WHERE A.salary BETWEEN B.min_sal AND B.max_sal
AND B.grade BETWEEN 3 AND 5
AND C.dep_location = 'SYDNEY'
AND A.dep_id = C.dep_id
AND A.job_name <> 'PRESIDENT'
AND A.salary > (

    SELECT
#     *
MAX(salary)
    FROM employees A1 , departments B1
    WHERE A1.dep_id = B1.dep_id
      AND B1.dep_location = 'PERTH'
      AND A1.job_name IN ( 'MANAGER' , 'SALESMAN' )
      AND A1.manager_id <> ( SELECT emp_id
                             FROM employees
                             WHERE emp_name = 'KAYLING' )


);

=================================23 answer========================

SELECT *
FROM employees
WHERE hire_date < '1991-01-01';

=======0r

SELECT *
FROM employees
WHERE hire_date IN(SELECT MIN(hire_date)
                   FROM employees
                   WHERE YEAR(hire_date)<'1991');

SELECT NOW();  ---------for find current timestamp

===================================24 answer====================================

SELECT *
FROM employees
WHERE YEAR(hire_date) = 1991
  AND job_name = (
    SELECT job_name
    FROM employees
    WHERE YEAR(hire_date) = 1991
    ORDER BY hire_date ASC
    LIMIT 1
);

========================25 answer================================

SELECT *
FROM employees a, salary_grades b
WHERE hire_date IN(SELECT MIN(hire_date)
    FROM employees
        WHERE emp_id IN (SELECT A.emp_id
                 FROM employees A, salary_grades B
                 WHERE B.grade IN (4,5)
                 AND A.salary BETWEEN B.min_sal AND B.max_sal))
AND a.manager_id IN (SELECT emp_id
                   FROM employees
                   WHERE emp_name='KAYLING')
AND b.grade IN (4,5)
AND a.salary BETWEEN b.min_sal AND b.max_sal;
=========================or
SELECT *
FROM employees e
JOIN salary_grades s ON e.salary BETWEEN s.min_sal AND s.max_sal
WHERE s.grade IN (4,5)
AND e.hire_date IN(SELECT MIN(hire_date)
                   FROM employees
                   WHERE emp_id IN (SELECT E.emp_id
                                    FROM employees E
                                    JOIN salary_grades S ON E.salary BETWEEN S.min_sal AND s.max_sal
                                    WHERE S.grade IN(4,5  )))
AND e.manager_id IN(SELECT emp_id
                    FROM employees
                    WHERE emp_name='KAYLING');

=======================26 answer==========================================================================

SELECT SUM(salary) AS total_salary
FROM employees
WHERE job_name='MANAGER';

========================27 answer=========================================================================
SELECT SUM(salary) AS total_sum
FROM employees a
JOIN salary_grades b ON a.salary BETWEEN b.min_sal AND b.max_sal
WHERE b.grade = 3;

========================28 answer==========================================================================
SELECT *
FROM employees
WHERE dep_id=1001
AND salary > (SELECT AVG(salary)
              FROM employees
              WHERE dep_id=2001);

=======================29 answer=========================================================================
SELECT
COUNT(*),
d.dep_id,
d.dep_location,
d.dep_name
FROM employees e
JOIN departments d ON e.dep_id = d.dep_id
GROUP BY d.dep_id
HAVING COUNT(*)IN (SELECT MAX(mycount)
                      FROM (SELECT COUNT(*)mycount
                            FROM employees
                            GROUP BY dep_id)AS COUNT);

=============================30 answer=========================================

SELECT *
FROM employees
WHERE manager_id =(SELECT emp_id
                   FROM employees
                   WHERE emp_name='JONAS');

=============================31 answer==========================================
SELECT *
FROM employees e
JOIN departments d ON e.dep_id= d.dep_id
WHERE dep_name <>'MARKETING';

============================32 answer===========================================

SELECT e.emp_name,
       e.job_name,
       d.dep_name,
       d.dep_location
FROM employees e
JOIN departments d ON e.dep_id=d.dep_id
WHERE e.emp_id IN(SELECT manager_id
                  FROM employees);

==========================33 answer==============================================

SELECT e.emp_name,
       e.dep_id,
       e.salary
FROM employees e
WHERE e.salary=(SELECT MAX(b.salary)
              FROM employees b
             WHERE b.dep_id= e.dep_id);

=============================34 answer==========================================

SELECT *
FROM employees
WHERE salary>=(SELECT (MAX(salary)+MIN(salary))/2
               FROM employees);

============================35 answer==========================================

SELECT *
FROM employees m
WHERE m.emp_id IN( SELECT manager_id
                     FROM employees)
AND m.salary>
    (SELECT avg(e.salary)
     FROM employees e
     WHERE e.manager_id=m.emp_id );


=========================36 answer============================================
SELECT *
FROM employees e, employees m
WHERE e.manager_id = m.emp_id
AND e.salary<m.salary
AND e.salary>ANY
(SELECT salary
 FROM employees
 WHERE emp_id IN(
     SELECT manager_id
     FROM employees));

=======================37 answer==============================================

SELECT e.emp_name,
       e.dep_id,
       d.avg_salary AS "avgsal"
FROM employees e
JOIN (SELECT dep_id, AVG(salary) AS avg_salary
                  FROM employees
                  GROUP BY dep_id)d ON e.dep_id=d.dep_id;

=====================38 answer===============================================

SELECT *
FROM employees
ORDER BY salary ASC
               LIMIT 5;

==================39 answer==================================================

SELECT *
FROM employees
WHERE emp_id IN (
    SELECT manager_id
    FROM employees)
    AND manager_id IN
    (SELECT emp_id
     FROM employees
     WHERE job_name <>'PRESIDENT'
    );

=========================40 answer============================================

SELECT *
FROM departments d
WHERE LENGTH(dep_name)=(SELECT
                            COUNT(*)
                        FROM employees e
                        WHERE e.dep_id=d.dep_id);

==========================41 answer===========================================
SELECT d.dep_name
FROM departments d
JOIN employees e ON d.dep_id=e.dep_id
GROUP BY d.dep_id
HAVING COUNT(*) IN (SELECT MAX(mycount)
                    FROM (SELECT COUNT(*)mycount
                          FROM employees
                          GROUP BY dep_id)AS dept_count)
                  ;
============================42 answer========================================

SELECT *
FROM employees
WHERE hire_date IN (SELECT hire_date
                    FROM employees
                   GROUP BY hire_date
                   HAVING COUNT(*)>1);

=============================43 answer=======================================

SELECT d.dep_name
FROM departments d
JOIN employees e ON d.dep_id=e.dep_id
GROUP BY d.dep_id
HAVING COUNT(*) > (SELECT AVG(mycount)
                 FROM (SELECT COUNT(*)mycount
                      FROM employees
                      GROUP BY dep_id) AS avg_count);


=============================44 answer============================================

SELECT e.emp_name,
       COUNT(*)
FROM employees e
    JOIN employees m ON m.manager_id=e.emp_id
GROUP BY e.emp_name
HAVING COUNT(*)=(SELECT MAX(mycount)
                 FROM (SELECT COUNT(*)mycount
                       FROM employees
                       GROUP BY manager_id)AS count
                 );

========================45 answer=================================================

SELECT DISTINCT m.*
FROM employees e
JOIN employees m
    ON m.emp_id=e.manager_id
WHERE m.salary<e.salary;

DISTINCT m.*: shows unique managers who earn less than at least one of their employees.
===========================0r=====================
WITH CTE AS (
    SELECT DISTINCT A.emp_name  , A.emp_id , A.salary
    FROM employees A,
         employees B
    WHERE A.emp_id = B.manager_id
)


SELECT DISTINC B.*
FROM employees A , CTE B
WHERE A.manager_id = B.emp_id
AND A.salary > B.salary

===================================46 answer============================================

SELECT *
FROM employees
WHERE  manager_id = (SELECT emp_id
                  FROM employees
                  WHERE emp_name='BLAZE');

===========================47 answer============================================

SELECT *
FROM employees e1
WHERE e1.emp_id IN(SELECT manager_id
              FROM employees
             );

=========================48 answer===============================================
SELECT e.emp_name,
       a.emp_name AS "manager for employees",
       m.emp_name AS "manager for JONAS"
FROM employees e
  JOIN employees a ON e.manager_id=a.emp_id
  JOIN employees m ON a.manager_id=m.emp_id
WHERE a.emp_name='JONAS'
;

=====================49 answer==========================================

SELECT *
FROM employees
WHERE salary IN (SELECT MIN(salary)
                 FROM employees
                 GROUP BY job_name)
ORDER BY salary ASC;

====================50 answer===================================

SELECT *
FROM employees
WHERE salary IN (SELECT MAX(salary)
                 FROM employees
                 GROUP  BY job_name)
ORDER BY salary DESC;

===================51 answer=======================================
SELECT *
FROM employees e
WHERE hire_date IN (SELECT MAX(hire_date)
                 FROM employees
                 WHERE e.dep_id=dep_id)
ORDER BY hire_date DESC;

==================52 answer========================================

SELECT emp_name,
       salary,
       dep_id
FROM employees e
WHERE salary >(SELECT AVG(salary)
               FROM employees
               WHERE e.dep_id=dep_id)
ORDER BY dep_id ASC;

=================53 answer=========================================
SELECT *
FROM employees
WHERE Salary IN (SELECT MAX(salary)
                 FROM employees
                 WHERE commission IS NOT NULL )
;
================54 answer==========================================

SELECT
    emp_name,
    job_name,
    salary
FROM employees
WHERE dep_id<>1001
AND job_name IN (SELECT job_name
                 from employees
                 WHERE dep_id =3001
                )
AND salary IN (SELECT salary
               FROM employees
               WHERE dep_id=3001);


=====================55 answer===========================================
SELECT dep_id,
       emp_name,
       job_name,
       salary,
       (commission+salary) AS net_salary
FROM employees
WHERE job_name='SALESMAN'
AND salary+commission IN (SELECT MAX(salary+commission)
                   FROM employees
                   WHERE commission IS NOT NULL);

===================56 answer==========================================

SELECT dep_id,
       emp_name,
       job_name,
       salary,
       (salary + commission) AS net_salary
FROM employees
WHERE (salary + commission) IN (SELECT MAX(salary + commission)
                                FROM employees
                                WHERE (salary + commission) <
                                      (SELECT MAX(salary + commission)
                                FROM employees))
AND commission IS NOT NULL;

=====================================57 answer================================================
SELECT dep_id,
       salary,
       avg(salary)
FROM employees
GROUP BY dep_id
HAVING AVG(salary)<(SELECT AVG(salary)
                    FROM employees);

=================================58 answer===========================================
SELECT *
FROM departments d
WHERE dep_id IN (SELECT DISTINCT dep_id
FROM employees);

SELECT COUNT(1), dep_id
    FROM employees
GROUP BY dep_id

SELECT dep_id FROM employees
    UNION
SELECT dep_id FROM employees;

===== or======error
SELECT *
FROM departments d
JOIN employees e ON e.dep_id=d.dep_id
WHERE e.dep_id IN(SELECT dep_id
                FROM employees
                GROUP BY dep_id
                HAVING COUNT(*) <> 0
    );

====================================59 answer================================================

SELECT *
FROM employees e
JOIN departments d ON e.dep_id=d.dep_id
WHERE d.dep_location = 'PERTH';

===================================60 answer=====================================
SELECT *
FROM employees e
JOIN departments