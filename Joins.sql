DROP TABLE IF EXISTS departments_dup;

CREATE TABLE departments_dup
(

    dept_no CHAR(4) NULL,

    dept_name VARCHAR(40) NULL

);

INSERT INTO departments_dup
(

    dept_no,

    dept_name

)SELECT
                *
FROM
                departments; 

INSERT INTO departments_dup (dept_name)

VALUES                ('Public Relations'); 

DELETE FROM departments_dup
WHERE

    dept_no = 'd002'; 

INSERT INTO departments_dup(dept_no) VALUES ('d010'), ('d011');

#---------------------------------------------------------

DROP TABLE IF EXISTS dept_manager_dup;

CREATE TABLE dept_manager_dup (
  emp_no int(11) NOT NULL,
  dept_no char(4) NULL,
  from_date date NOT NULL,
  to_date date NULL
  );


INSERT INTO dept_manager_dup
select * from dept_manager;


INSERT INTO dept_manager_dup (emp_no, from_date)
VALUES                (999904, '2017-01-01'),

                                (999905, '2017-01-01'),

                               (999906, '2017-01-01'),

                               (999907, '2017-01-01');

DELETE FROM dept_manager_dup
WHERE
    dept_no = 'd001';
    
show databases;
USE employees;
SELECT * from dept_manager_dup ORDER BY dept_no;

SELECT * from departments_dup ORDER BY dept_no;

SELECT 
    t1.emp_no, t1.dept_no, t1.from_date, t2.dept_name
FROM
    dept_manager_dup t1
        INNER JOIN
    departments_dup t2 ON t1.dept_no = t2.dept_no
ORDER BY t1.dept_no;

SELECT 
    e.emp_no, e.first_name, e.last_name, e.hire_date, dm.dept_no
FROM
    employees e
        INNER JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
ORDER BY e.emp_no;

SELECT * from departments_dup ORDER BY dept_no DESC;
SELECT * from dept_manager_dup ORDER BY emp_no DESC;

SELECT 
    dmd.emp_no, dmd.dept_no, dd.dept_name
FROM
    dept_manager_dup dmd
        JOIN
    departments_dup dd ON dmd.dept_no = dd.dept_no
ORDER BY dmd.dept_no;

DELETE FROM departments_dup
WHERE dept_no = 'd009';

DELETE FROM dept_manager_dup
WHERE emp_no = '110228';

INSERT INTO dept_manager_dup
VALUES ('110228', 'd003', '1992-03-21', '9999-01-01');

INSERT INTO departments_dup
VALUES ('d009', 'Customer Service'); 

SELECT m.emp_no, m.dept_no, d.dept_name
FROM dept_manager_dup m
LEFT JOIN departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.emp_no;

SELECT 
    d.dept_name, d.dept_no, m.emp_no
FROM
    departments_dup d
        LEFT OUTER JOIN
    dept_manager_dup m ON d.dept_no = m.dept_no
WHERE
    emp_no IS NULL
ORDER BY d.dept_name;

SELECT e.emp_no, e.first_name, e.last_name, dm.dept_no
FROM employees e
LEFT JOIN dept_manager dm ON e.emp_no = dm.emp_no
WHERE e.last_name = 'Markovitch'
GROUP BY e.emp_no
ORDER BY dm.dept_no DESC, e.last_name;

SELECT e.emp_no, e.first_name, e.last_name, e.hire_date, dm.dept_no
FROM employees e, dept_manager dm
WHERE e.emp_no = dm.emp_no;

select @@global.sql_mode;
set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

SELECT 
    e.emp_no, e.first_name, e.last_name, t.title
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE first_name = 'Margareta'
ORDER BY e.emp_no;

SELECT dm.*, d.*
FROM dept_manager dm
CROSS JOIN departments d
WHERE d.dept_no = 'd009'
ORDER by dm.emp_no;

SELECT e.*, de.*
FROM employees e
CROSS JOIN dept_emp de
LIMIT 10;

SELECT e.*, d.*
FROM employees e
CROSS JOIN departments d
WHERE e.emp_no < 10011
ORDER BY e.emp_no, d.dept_name;	

SELECT e.first_name, e.last_name, e.hire_date, t.title, dm.from_date, d.dept_name
FROM employees e
JOIN titles t ON e.emp_no = t.emp_no
JOIN dept_manager dm ON e.emp_no = dm.emp_no
JOIN departments d on dm.dept_no = d.dept_no
WHERE t.title = 'Manager'
ORDER BY e.first_name, d.dept_name;

SELECT e.gender, COUNT(t.title) as number_of_managers
FROM employees e
JOIN titles t ON e.emp_no = t.emp_no
WHERE t.title = 'Manager'
GROUP BY e.gender;

SELECT e.gender, COUNT(dm.emp_no) AS number_of_managers
FROM employees e
JOIN dept_manager dm ON e.emp_no = dm.emp_no
GROUP BY gender;