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

SELECT *
FROM employees e ,
     salary_grades s
WHERE e.salary BETWEEN s.min_sal AND s.max_sal
AND s.grade IN  (2, 3);



