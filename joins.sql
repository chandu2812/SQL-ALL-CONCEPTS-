CREATE TABLE departments (
    dept_id INTEGER PRIMARY KEY,
    dept_name TEXT,
    location TEXT
);

INSERT INTO departments VALUES
(1, 'Engineering', 'Bangalore'),
(2, 'Marketing',   'Mumbai'),
(3, 'HR',          'Delhi'),
(4, 'Finance',     'Chennai');   -- no employees yet

CREATE TABLE employees (
    emp_id INTEGER PRIMARY KEY,
    name TEXT,
    dept_id INTEGER,
    salary INTEGER
);

INSERT INTO employees VALUES
(1, 'Arjun',  1, 60000),
(2, 'Priya',  2, 45000),
(3, 'Rahul',  1, 75000),
(4, 'Sneha',  3, 40000),
(5, 'Vikram', 1, 90000),
(6, 'Meera',  2, 50000),
(7, 'Karan',  3, 42000),
(8, 'Divya',  1, 85000),
(9, 'Rohan',  NULL, 55000);   -- no department (orphan)

-- Only employees WITH a valid dept. Rohan is excluded. Finance excluded.
SELECT e.name, e.salary, d.dept_name, d.location
FROM employees e
INNER JOIN departments d
    ON e.dept_id = d.dept_id;

--Show me all employees even if they have no department.
SELECT e.name,d.dept_name 
FROM employees e
LEFT JOIN departments d
	ON e.dept_id = d.dept_id;
--RIGHT JOIN  ALL departments. Finance appears with NULL employee.
SELECT e.name,d.dept_name 
FROM employees e
RIGHT JOIN departments d
	ON e.dept_id = d.dept_id;	

--FULL OUTER JOIN — everything from both sides
SELECT e.name, d.dept_name
FROM employees e
FULL OUTER JOIN  departments d
 ON e.dept_id=d.dept_id

-- Employees with NO department
SELECT e.name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
WHERE d.dept_id IS NULL;

-- Departments with NO employees
SELECT d.dept_name
FROM departments d
LEFT JOIN employees e ON e.dept_id = d.dept_id
WHERE e.emp_id IS NULL;

--Joining 3+ tables
CREATE TABLE projects (
    proj_id INTEGER PRIMARY KEY,
    proj_name TEXT,
    emp_id INTEGER
);

INSERT INTO projects VALUES
(101, 'Data Pipeline', 1),
(102, 'Ad Campaign',   2),
(103, 'Hiring Portal', 4);
--Join chain rule: each JOIN connects the next table using a shared key.
SELECT e.name, d.dept_name, p.proj_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
INNER JOIN projects p    ON e.emp_id = p.emp_id;

--List all employees with their department name and location.
SELECT e.name,d.location
FROM employees e
INNER JOIN departments d ON  e.dept_id=d.dept_id;

--Show all departments, even those with no employees, along with employee names.
SELECT e.name,d.dept_name
FROM departments d
LEFT JOIN employees e ON e.dept_id =d.dept_id;

--Find employees who are not assigned to any project.
SELECT e.name
FROM employees e
LEFT JOIN projects p ON e.emp_id =P.emp_id
WHERE p.proj_id IS NULL;

--Show each employee's name, dept name, and project name — but only for employees who have projects.
SELECT e.name,d.dept_name ,proj_name
FROM employees e
JOIN departments d ON e.dept_id =d.dept_id
JOIN projects p  ON e.emp_id = p.emp_id;

--Count employees per department name (include departments with 0 employees → show 0).
SELECT d.dept_name,COUNT (e.emp_id)AS emp_count
FROM departments d 
LEFT JOIN employees e ON d.dept_id =  e.dept_id 
GROUP BY d.dept_name

--List project names and the employee working on each.
SELECT p.proj_name,e.name
FROM projects p
JOIN employees e ON p.emp_id=e.emp_id;

/*Write ONE query that returns, for each department:

Department name

Number of employees

Average salary (rounded to 2 decimals)

Including departments with zero employees (show 0 and NULL/0 respectively)

Sorted by employee count descending.*/

SELECT d.dept_name,
	count(e.emp_id) AS emp_count,
	ROUND(AVG(e.salary),2) AS avg_salary
FROM departments d
LEFT JOIN employees e ON d.dept_id=e.dept_id
GROUP BY d.dept_name
ORDER BY emp_count desc;

/*□ Created all 3 tables (departments, employees, projects)
□ Ran all 4 join types
□ Practiced the orphan-finder pattern
□ Solved the 6 practice queries
□ Completed the challenge
*/
	
