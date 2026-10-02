CREATE TABLE departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name TEXT,
    location TEXT
);
INSERT INTO departments (dept_name, location) VALUES
('Engineering', 'Bangalore'),
('Marketing',   'Mumbai'),
('HR',          'Delhi'),
('Finance',     'Chennai');

CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    name TEXT,
    dept_id INTEGER REFERENCES departments(dept_id),
    salary INTEGER,
    hire_year INTEGER
);
INSERT INTO employees (name, dept_id, salary, hire_year) VALUES
('Arjun',  1, 60000, 2020),
('Priya',  2, 45000, 2021),
('Rahul',  1, 75000, 2019),
('Sneha',  3, 40000, 2022),
('Vikram', 1, 90000, 2018),
('Meera',  2, 50000, 2021),
('Karan',  3, 42000, 2020),
('Divya',  1, 85000, 2022),
('Rohan',  NULL, 55000, 2021),
('Ananya', 3, 38000, 2023);

-- CTEs
/*WITH cte_name AS (
SELECT ... 
)
SELECT *form cte_name ;*/
--Example 1: Clean replacement for derived table
WITH dept_avg AS(
 SELECT dept_id,AVG(salary) AS avg_sal
 FROM employees 
 GROUP BY dept_id
)
SELECT * FROM dept_avg
WHERE avg_sal >55000;

--Example 2: Chaining multiple CTEs
WITH dept_avg AS(
	SELECT dept_id ,AVG(salary) AS avg_sal
	FROM employees
	GROUP BY dept_id
),
high_paid AS(
	SELECT e.name,e.salary,e.dept_id
	FROM employees e
	JOIN dept_avg da ON e.dept_id =da.dept_id
	WHERE e.salary >da.avg_sal
)
SELECT d.dept_name,hp.name,hp.salary
FROM high_paid hp
JOIN departments d ON hp.dept_id = d.dept_id
ORDER BY hp.salary DESC;
--Example 3: Reusing the same CTE twice
WITH dept_totals AS (
	SELECT dept_id, SUM(salary) AS total_sal
	FROM employees
	GROUP BY dept_id
)
SELECT
(SELECT SUM(total_sal)FROM dept_totals) AS garnd_total,
(SELECT AVG(total_sal)FROM dept_totals) AS _dept_total;

--PRACTICE (real interview-level)
--Find employees earning more than the average salary of their own department.
SELECT e.name,e.salary,d.dept_name
FROM employees e
JOIN departments d ON e.dept_id= d.dept_id
WHERE e.salary > (
	SELECT AVG(salary) FROM employees WHERE dept_id=e.dept_id
);
--List department names that have no employees (use NOT EXISTS).
SELECT d.dept_name
FROM departments d
WHERE NOT EXISTS (
SELECT 1 FROM employees e WHERE e.dept_id = d.dept_id
);
--Find the employee(s) with the second highest salary. (Hint: subquery to exclude max)
SELECT name,salary 
FROM employees 
WHERE salary =(
	SELECT MAX(salary) FROM employees
	WHERE salary < (SELECT MAX(salary) FROM employees)
);

--Using a CTE, show each department with its employee count and average salary, only for departments with avg > 50000.
WITH dept_stats AS (
	SELECT dept_id,COUNT(*) AS emp_count,AVG(salary) AS avg_sal
	FROM employees
	GROUP BY dept_id 	
)
SELECT d.dept_name,ds.emp_count,ROUND(ds.avg_sal,2)
FROM dept_stats ds 
JOIN departments d ON ds.dept_id =d.dept_id
WHERE ds.avg_sal >50000;
--Find employees hired in the same year as the oldest hire in the company.
SELECT name ,hire_year 
FROM employees 
WHERE hire_year =(SELECT MIN(hire_year) FROM employees);

--Using CTEs, find employees who earn more than their department's average AND list the department name.
WITH dept_avg AS (
	SELECT dept_id,AVG (salary) AS avg_sal
	FROM employees e
	GROUP BY dept_id
)
SELECT e.name,e.salary,d.dept_name
FROM employees e
JOIN dept_avg da ON e.dept_id=da.dept_id
JOIN departments d ON e.dept_id=d.dept_id
WHERE e.salary > da.avg_sal;

