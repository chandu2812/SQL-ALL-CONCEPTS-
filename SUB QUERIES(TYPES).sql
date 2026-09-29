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

--SUB QUERIRES
--Type 1: Scalar Subquery (returns ONE value)

---- Who earns more than the company average?
SELECT name,salary
FROM employees 
WHERE salary >(SELECT AVG(salary) FROM employees);

-- Employees earning the maximum salary
SELECT name,salary
FROM employees
WHERE salary =(SELECT MAX(salary) FROM employees);

-- Type 2: Subquery with IN (returns a LIST)
-- Employees in departments located in Bangalore or Mumbai
SELECT name,(SELECT location FROM departments WHERE departments.dept_id = employees.dept_id) AS location
FROM employees
WHERE dept_id IN (
	SELECT dept_id FROM departments
	WHERE location IN ('Bangalore','Mumbai')
);

-- Type 3: Correlated Subquery (runs once PER outer row)
-- Employees earning above THEIR department's average
SELECT e.name, e.salary,e.dept_id,(SELECT dept_name FROM departments  WHERE dept_id =e.dept_id) AS dpet_name
FROM employees e
WHERE e.salary >(
	SELECT AVG(salary)
	FROM employees
	WHERE dept_id = e.dept_id -- 🔑 references outer 'e'
);
/*Key difference:

Type					Runs					Performance
Normal subquery			Once					Fast
Correlated subquery		Once per outer row		Slower (avoid on big data)
*/
-- Type 4: Subquery in FROM (derived table)

SELECT dept_id,avg_sal ,(SELECT dept_name FROM departments WHERE  departments.dept_id = dept_stats.dept_id) AS dept_name 
FROM (
	SELECT dept_id ,ROUND(AVG(salary),2) AS avg_sal
	FROM employees
	GROUP BY dept_id
)AS dept_stats
WHERE avg_sal>55000;

-- EXISTS — for "does at least one row exist?"
-- Departments that HAVE at least one employee
SELECT dept_name
FROM departments d
WHERE EXISTS (
    SELECT 1 FROM employees e WHERE e.dept_id = d.dept_id
);

-- Departments with NO employees
SELECT dept_name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1 FROM employees e WHERE e.dept_id = d.dept_id
);