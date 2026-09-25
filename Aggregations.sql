CREATE TABLE employees(
	emp_id INTEGER PRIMARY KEY ,
	name text,
	department TEXT,
	salary INTEGER,
	city text,
	hire_year INTEGER
);
INSERT INTO employees VALUES
(1, 'Arjun',  'Engineering', 60000, 'Bangalore', 2020),
(2, 'Priya',  'Marketing',   45000, 'Mumbai',    2021),
(3, 'Rahul',  'Engineering', 75000, 'Bangalore', 2019),
(4, 'Sneha',  'HR',          40000, 'Delhi',     2022),
(5, 'Vikram', 'Engineering', 90000, 'Hyderabad', 2018),
(6, 'Meera',  'Marketing',   50000, 'Mumbai',    2021),
(7, 'Karan',  'HR',          42000, 'Delhi',     2020),
(8, 'Divya',  'Engineering', 85000, 'Bangalore', 2022),
(9, 'Rohan',  'Marketing',   55000, 'Mumbai',    2019),
(10,'Ananya', 'HR',          38000, 'Delhi',     2023);


/*aggregate quries */
SELECT COUNT(*) FROM employees;
/*avg salary*/
SELECT AVG(salary) FROM employees;

SELECT ROUND(AVG(salary),2) AS AVG_Salary FROM employees;
/*sum of the salary of all dept employees*/
SELECT SUM(salary) FROM employees;
/*min and max salary*/
SELECT MIN (salary) ,MAX(salary) FROM employees;
/*avg salary for specific dept*/
SELECT AVG(SALARY) FROM employees WHERE department='Engineering';

