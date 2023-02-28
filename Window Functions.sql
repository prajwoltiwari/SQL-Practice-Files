SELECT emp_no, salary FROM salaries;

SELECT 
emp_no, 
salary,
ROW_NUMBER() OVER() AS s_n
FROM salaries;

SELECT emp_no, salary, ROW_NUMBER() OVER(partition by emp_no ORDER BY salary)
FROM salaries;

SELECT
emp_no,
first_name,
last_name,
ROW_NUMBER() OVER(PARTITION BY first_name ORDER BY last_name) AS emp_ranking
from employees;

SELECT dm.emp_no, dm.dept_no, e.first_name, e.last_name, ROW_NUMBER() OVER(ORDER BY emp_no) AS dept_manager_number
FROM dept_manager dm
JOIN employees e ON dm.emp_no = e.emp_no;

SELECT dm.emp_no, e.first_name, e.last_name, s.salary, ROW_NUMBER () OVER() AS dept_manager_row, ROW_NUMBER() OVER(PARTITION BY e.first_name ORDER BY s.salary) AS salary_frequency 
FROM dept_manager dm
JOIN employees e ON dm.emp_no = e.emp_no
JOIN salaries s ON dm.emp_no = s.emp_no;

SELECT emp_no, first_name, last_name, gender, ROW_NUMBER() OVER(PARTITION BY first_name) AS same_emp_row
FROM employees
ORDER BY emp_no;

SELECT emp_no, first_name, last_name, gender, ROW_NUMBER() OVER(PARTITION BY first_name ORDER BY emp_no) AS same_emp_row
FROM employees;

SELECT emp_no, salary, ROW_NUMBER() OVER w as min_salary
FROM salaries
WHERE min_salary = 1
window w AS (partition by salary order by salary);

SELECT emp_no, salary, ROW_NUMBER() OVER(partition by salary order by salary) as min_salary
FROM salaries
WHERE min_salary = 1;

SELECT a.emp_no, a.salary as min_salary
FROM(SELECT emp_no, salary, ROW_NUMBER() OVER w as min_salary_rank FROM salaries WINDOW w AS (partition by emp_no order by salary asc)) a
WHERE a.min_salary_rank = 1;

SELECT emp_no, MIN(salary) as min_salary FROM(SELECT emp_no, salary, ROW_NUMBER() OVER(partition by emp_no order by salary) as min_salary_rank FROM salaries) a
GROUP BY emp_no;

SELECT emp_no, salary, ROW_NUMBER() OVER(ORDER BY salary) as salary_row
FROM salaries
WHERE emp_no = '10560';

SELECT emp_no, salary, RANK() OVER(ORDER BY salary) as salary_row
FROM salaries
WHERE emp_no = '10560';

SELECT emp_no, salary, DENSE_RANK() OVER w as salary_row
FROM salaries
WHERE emp_no = '10560'
WINDOW w AS (ORDER BY salary);

SELECT emp_no, salary, count(salary) as number_of_salaries
FROM salaries
GROUP BY emp_no;

SELECT
e.emp_no, s.salary, RANK() OVER R AS salary_rank_desc
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE e.emp_no BETWEEN '10500' AND '10600'
WINDOW R AS (PARTITION BY e.emp_no ORDER BY s.salary DESC);

SELECT
e.emp_no, e.hire_date, s.from_date, YEAR(s.from_date)-YEAR(e.hire_date) AS hire_contract_year_diff, DENSE_RANK() OVER R AS salary_rank_desc, s.salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
AND YEAR(s.from_date)-YEAR(e.hire_date) >= 4
WHERE e.emp_no BETWEEN '10500' AND '10600'
WINDOW R AS (PARTITION BY e.emp_no ORDER BY s.salary DESC);

SELECT 
emp_no,
salary,
LAG(salary) OVER w as previous_salary,
LEAD(salary) over w as next_salary,
salary - LAG(salary) OVER w as salary_diff_current_previous, 
LEAD(salary) over w - salary as salary_diff_next_current
FROM salaries
WHERE emp_no BETWEEN '10500' AND '10600'
HAVING salary > '80000'
WINDOW w AS (PARTITION BY emp_no ORDER BY salary);

SELECT emp_no, salary,
LAG(salary) OVER w as previous_salary,
LEAD(salary) OVER w as next_salary,
LAG(salary,2) OVER w as preceding_previous_salary,
LEAD(salary,2) OVER w as subsequent_next_salary
FROM salaries
WINDOW w AS (partition by emp_no order by salary)
LIMIT 1000;

# all employees first salary

SELECT
    s1.emp_no, s.salary, s.from_date, s.to_date
FROM salaries s
        JOIN
    (SELECT
        emp_no, MIN(from_date) AS from_date
    FROM
        salaries
    GROUP BY emp_no) s1 ON s.emp_no = s1.emp_no
WHERE
    s.from_date = s1.from_date;
    
/*
Exercise #1:
Consider the employees' contracts that have been signed after the 1st of January 2000 and terminated before the 1st of January 2002 (as registered in the "dept_emp" table).
Create a MySQL query that will extract the following information about these employees:
- Their employee number
- The salary values of the latest contracts they have signed during the suggested time period
- The department they have been working in (as specified in the latest contract they've signed during the suggested time period)
- Use a window function to create a fourth field containing the average salary paid in the department the employee was last working in during the suggested time period. Name that field "average_salary_per_department".

Note1: This exercise is not related neither to the query you created nor to the output you obtained while solving the exercises after the previous lecture.
Note2: Now we are asking you to practically create the same query as the one we worked on during the video lecture; the only difference being to refer to contracts that have been valid within the period between the 1st of January 2000 and the 1st of January 2002.
Note3: We invite you solve this task after assuming that the "to_date" values stored in the "salaries" and "dept_emp" tables are greater than the "from_date" values stored in these same tables. If you doubt that, you could include a couple of lines in your code to ensure that this is the case anyway!
Hint: If you've worked correctly, you should obtain an output containing 200 rows.
*/

SELECT
    de2.emp_no, d.dept_name, s2.salary, AVG(s2.salary) OVER w AS average_salary_per_department
FROM
    (SELECT
    de.emp_no, de.dept_no, de.from_date, de.to_date
FROM dept_emp de
        JOIN
(SELECT
emp_no, MAX(from_date) AS from_date
FROM
dept_emp
GROUP BY emp_no) de1 ON de1.emp_no = de.emp_no
WHERE
    de.to_date < '2002-01-01'
AND de.from_date > '2000-01-01'
AND de.from_date = de1.from_date) de2
JOIN
    (SELECT
    s1.emp_no, s.salary, s.from_date, s.to_date
FROM
    salaries s
    JOIN
    (SELECT
emp_no, MAX(from_date) AS from_date
FROM
salaries
    GROUP BY emp_no) s1 ON s.emp_no = s1.emp_no
WHERE
    s.to_date < '2002-01-01'
AND s.from_date > '2000-01-01'
AND s.from_date = s1.from_date) s2 ON s2.emp_no = de2.emp_no
JOIN
    departments d ON d.dept_no = de2.dept_no
GROUP BY de2.emp_no, d.dept_name
WINDOW w AS (PARTITION BY de2.dept_no)
ORDER BY de2.emp_no, salary;