SELECT first_name, last_name FROM employees;
SELECT * from employees;

SELECT dept_no from departments;
SELECT * FROM departments;

SELECT gender from employees WHERE gender = 'F';

SELECT * from employees where first_name = 'Denis';

SELECT * FROM employees WHERE first_name = 'Elvis';

SELECT * FROM employees WHERE first_name = 'Denis' AND gender = 'M';

SELECT * FROM employees WHERE first_name = 'Kellie' AND gender = 'F';

SELECT * FROM employees WHERE first_name = 'Kellie' OR first_name = 'Aruna';

SELECT * FROM employees WHERE last_name = 'Denis' AND (gender = 'M' OR gender = 'F');

SELECT * FROM employees WHERE last_name = 'Denis' AND gender = 'M' OR last_name = 'Denis' AND gender = 'F';

SELECT *  FROM employees WHERE gender = 'F' AND (first_name = 'Kellie' OR first_name = 'Aruna');

SELECT *  FROM employees WHERE gender = 'F' AND first_name = 'Kellie' OR gender = 'F' AND first_name = 'Aruna';

SELECT * FROM employees WHERE first_name IN ('Cathie', 'Nathan', 'Mark');

SELECT * FROM employees WHERE first_name IN ('Denis', 'Elvis');

SELECT * FROM employees WHERE first_name NOT IN ('John', 'Mark', 'Jacob');

SELECT * FROM employees WHERE first_name LIKE ('Mark%');

SELECT * FROM employees WHERE hire_date like ('2000%');

SELECT * FROM employees WHERE emp_no like ('1000_');

SELECT * FROM employees WHERE first_name NOT LIKE ('%jack%');

SELECT * FROM salaries WHERE salary BETWEEN 66000 AND 70000;

SELECT * FROM employees WHERE emp_no NOT BETWEEN '10004' AND '10012';

SELECT * FROM departments WHERE dept_no BETWEEN 'd003' AND 'd006';

SELECT * FROM departments;

SELECT dept_name FROM departments WHERE dept_no IS NOT NULL;

SELECT * FROM employees WHERE hire_date >= '2000-01-01' AND gender='F';

SELECT * FROM salaries WHERE salary > 150000;

USE employees;
SELECT DISTINCT hire_date from employees;

SELECT COUNT(emp_no) from employees;
SELECT COUNT(first_name) from employees;

SELECT COUNT(DISTINCT first_name) from employees;

SELECT COUNT(salary >= 100000) from salaries;
SELECT COUNT(salary) from salaries;
SELECT COUNT(*) from salaries where salary>=100000;

SELECT COUNT(emp_no) from dept_manager;
SELECT COUNT(*) from dept_manager;

SELECT * from employees ORDER BY first_name, last_name;
SELECT * from employees ORDER BY hire_date;

SELECT first_name, COUNT(first_name) from employees where gender = 'F' GROUP BY first_name ORDER BY(COUNT(first_name)) DESC;

SELECT salary, COUNT(emp_no) AS emp_with_same_salary from salaries GROUP BY salary HAVING salary >= 80000 ORDER BY salary;

SELECT emp_no,AVG(salary) AS average_salary from salaries GROUP BY emp_no HAVING AVG(salary) > 120000 ORDER BY emp_no;

SELECT 
    first_name, COUNT(first_name) AS number_of_occurance
FROM
    employees
WHERE
    hire_date > '1999-01-01'
GROUP BY first_name
HAVING COUNT(first_name) < 200
ORDER BY first_name DESC;

SELECT emp_no from dept_emp where from_date > '2020-01-01' group by emp_no having count(from_date > 1);

SELECT * from dept_emp LIMIT 100;

SELECT COUNT(DISTINCT dept_no) from dept_emp;

SELECT 
    SUM(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01';
    
SELECT MAX(emp_no), MIN(emp_no) from employees;
    
SELECT AVG(salary) from salaries where from_date > '1997-01-01';

SELECT ROUND(AVG(salary),2) from salaries where from_date > '1997-01-01';

