SELECT first_name, last_name, 
CASE WHEN gender = 'M' THEN 'Male' ELSE 'Female'
END AS gender
FROM employees;

SELECT first_name, IF(gender = 'M', 'Male', 'Female') AS gender
FROM employees;

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Employee'
    END AS is_manager
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
WHERE
    e.emp_no > 109990;
    
    
SELECT dm.emp_no, e.first_name, e.last_name, MAX(s.salary) - MIN(s.salary) AS salary_difference, 
CASE WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'The salary raise was more than $30000'
WHEN MAX(s.salary) - MIN(s.salary) BETWEEN 20000 AND 30000 THEN 'The salary raise was more than $20000 but less than $20000'
ELSE 'The salary raise was less than $20000' 
END AS salary_raise
FROM dept_manager dm
JOIN employees e ON dm.emp_no = e.emp_no
JOIN salaries s ON dm.emp_no = s.emp_no
GROUP BY s.emp_no;

SELECT e.emp_no, e.first_name, e.last_name,
CASE WHEN dm.emp_no IS NOT NULL THEN 'Manager'
ELSE 'Employee'
END AS is_manager
FROM employees e
LEFT JOIN dept_manager dm ON e.emp_no = dm.emp_no
WHERE e.emp_no > '109990'
GROUP BY e.emp_no;

SELECT e.emp_no, e.first_name, e.last_name, 
CASE WHEN MAX(de.to_date) > sysdate() THEN 'Is still employed'
ELSE 'Not an emploee anymore'
END AS current_employee
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
GROUP BY e.emp_no
LIMIT 100;