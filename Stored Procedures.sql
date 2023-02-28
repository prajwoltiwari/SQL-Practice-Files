USE employees;

DROP PROCEDURE IF EXISTS select_employees;

DELIMITER $$
CREATE PROCEDURE select_employees() 
BEGIN
SELECT * FROM employees
LIMIT 1000;
END$$
DELIMITER ;

CALL select_employees();
CALL employees.select_employees();

DELIMITER $$
CREATE PROCEDURE show_average_salary()
BEGIN
SELECT AVG(salary) as average_salary
FROM salaries;
END$$
DELIMITER ;

CALL employees.show_average_salary();

DROP PROCEDURE employees.show_average_salary;  

## Create a procedure called ‘emp_info’ that uses as parameters the first and the last name of an individual, and returns their employee number.

DELIMITER $$
CREATE PROCEDURE emp_info(in emp_first_name varchar(255), in emp_last_name varchar(255), out emp_number integer)
BEGIN
SELECT e.emp_no INTO emp_number
FROM employees e
WHERE e.first_name = emp_first_name AND e.last_name = emp_last_name;
END$$
DELIMITER ;

SET @v_emp_no = 0;
call employees.emp_info('Aruna', 'Journel', @v_emp_no);
SELECT @v_emp_no;

SELECT * from employees WHERE emp_no = 10789;

DELIMITER $$
CREATE FUNCTION emp_info (emp_first_name varchar(220), emp_last_name varchar(220)) RETURNS integer
DETERMINISTIC
BEGIN
DECLARE v_salary integer;
SELECT AVG(s.salary) INTO v_salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no;
RETURN v_salary;
END$$
DELIMITER ;



DELIMITER $$
CREATE FUNCTION emp_info_course(p_first_name varchar(255), p_last_name varchar(255)) RETURNS decimal(10,2)
DETERMINISTIC
BEGIN
                DECLARE v_max_from_date date;
    DECLARE v_salary decimal(10,2);
                SELECT
    MAX(from_date)
INTO v_max_from_date FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.first_name = p_first_name
        AND e.last_name = p_last_name;
                SELECT
    s.salary
INTO v_salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.first_name = p_first_name
        AND e.last_name = p_last_name
        AND s.from_date = v_max_from_date;
                RETURN v_salary;
END$$
DELIMITER ;

SELECT emp_info_course('Aruna', 'Journel');

