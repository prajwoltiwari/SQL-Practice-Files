SELECT e.emp_no, e.first_name, e.last_name
from employees e
WHERE emp_no IN (SELECT dm.emp_no FROM dept_manager dm)
HAVING e.hire_date = '1990-01-01';

USE employees;

SELECT 
    *
FROM
    dept_manager
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            employees
        WHERE
            hire_date BETWEEN '1990-01-01' AND '1995-01-01');


SELECT * from employees e
WHERE EXISTS(SELECT * FROM titles t WHERE t.emp_no = e.emp_no AND title = 'Assistant Engineer')
ORDER BY emp_no;

USE employees;
DROP TABLE IF EXISTS emp_manager;
CREATE TABLE emp_manager (
   emp_no INT(11) NOT NULL,
   dept_no CHAR(4) NULL,
   manager_no INT(11) NOT NULL
);

INSERT INTO emp_manager
SELECT U.* FROM
(SELECT A.* FROM
(SELECT 
    e.emp_no AS Employee_ID,
    MIN(de.dept_no) AS Department_ID,
    (SELECT 
            emp_no
        FROM
            dept_manager
        WHERE
            emp_no = '110022') AS Manager_ID
FROM
    employees e
        JOIN
    dept_emp de ON e.emp_no = de.emp_no
WHERE
    e.emp_no <= '10020'
GROUP BY e.emp_no
ORDER BY e.emp_no) as A
UNION SELECT B.* FROM
(SELECT 
    e.emp_no AS Employee_ID,
    MIN(de.dept_no) AS Department_ID,
    (SELECT 
            emp_no
        FROM
            dept_manager
        WHERE
            emp_no = '110039') AS Manager_ID
FROM
    employees e
        JOIN
    dept_emp de ON e.emp_no = de.emp_no
WHERE
    e.emp_no > '10020'
    
GROUP BY e.emp_no
ORDER BY e.emp_no
LIMIT 20) as B
UNION SELECT C.* FROM
(SELECT 
    e.emp_no AS Employee_ID,
    MIN(de.dept_no) AS Department_ID,
    (SELECT 
            emp_no
        FROM
            dept_manager
        WHERE
            emp_no = '110039') AS Manager_ID
FROM
    employees e
        JOIN
    dept_emp de ON e.emp_no = de.emp_no
WHERE
    e.emp_no = '110022'
    
GROUP BY e.emp_no
ORDER BY e.emp_no) as C
UNION SELECT D.* FROM
(SELECT 
    e.emp_no AS Employee_ID,
    de.dept_no AS Department_ID,
    (SELECT 
            emp_no
        FROM
            dept_manager
        WHERE
            emp_no = '110022') AS Manager_ID
FROM
    employees e
        JOIN
    dept_emp de ON e.emp_no = de.emp_no
WHERE
    e.emp_no = '110039'
    
GROUP BY e.emp_no
ORDER BY e.emp_no) as D)as U;

SELECT * FROM emp_manager;