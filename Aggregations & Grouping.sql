/*group by function*/
--TOP SALARY PER DEPARTMENT
SELECT department ,sum(salary) AS total_salary
FROM employees
GROUP BY department ;
--AVG SALARY PER DEPARTMENT
SELECT department ,ROUND(AVG(salary),2) AS avg_salary
FROM employees
GROUP BY department ;

--COUNT EMPLOYYES PER CITY
SELECT city,count(*) FROM employees
GROUP BY city;

-- GROUPING MULTIPLE COLUMS
SELECT department,city,count(*), STRING_AGG(name, '/ 'ORDER BY name ASC) AS employee_names
from employees
group by  department ,city;	

-- BY THE HIRING YEAR 
SELECT department,hire_year, COUNT(*) AS total_hired ,STRING_AGG(name,', ' ORDER BY name ASC) as employee_name 
from employees
group by  hire_year,department
order by hire_year ASC;

--where used before groupig
SELECT hire_year ,department,ROUND(AVG(salary),2)
FROM employees 
WHERE hire_year >=2020
GROUP BY department,hire_year;

--having used after grouping
SELECT department,ROUND(AVG(salary),2)AS avg_sla 
FROM employees
GROUP BY department 
HAVING AVG (salary)> 50000;

--BOTH TOGETHER 
SELECT department ,COUNT (*) AS cnt
FROM employees
WHERE salary >40000
GROUP BY department
HAVING COUNT (*)>=4;

--COUNT TOTAL EMPLOYEES 
SELECT COUNT(*) as total_employees FROM employees ;
--Find total salary paid per city.
SELECT city,ROUND(SUM(salary),2) AS  Total_salary 
FROM employees
GROUP BY city;

--Show departments with more than 2 employees.

SELECT department,COUNT(*) FROM employees
GROUP BY department HAVING COUNT(*)>=2;
--Average salary of employees hired after 2020, grouped by department.
SELECT department,ROUND(AVG(salary),2) AS AVG_salary FROM employees
WHERE hire_year >2020
GROUP BY department;

--For each city, show the highest salary.
SELECT city,MAX(salary) AS highest_salary FROM employees GROUP BY city;

--Count how many employees have salary between 45000 and 80000, per department.
SELECT department ,COUNT (*) AS TOTAL_EMP_SAL  FROM employees 
where salary BETWEEN 45000 AND 80000
GROUP BY department;

--Departments where average salary is above 60000, sorted by avg descending.
SELECT department ,ROUND(AVG(salary),2)AS avg_sal FROM employees
GROUP BY department HAVING AVG(salary) >60000
order by avg_sal desc;
/*Write a query that shows for each department:

Department name

Number of employees

Total salary

Average salary (rounded to 2 decimals)
ut only include departments where total salary > 100000, sorted by total salary descending.*/
SELECT 
    department,
    COUNT(*) AS emp_count,
    SUM(salary) AS total_salary,
    ROUND(AVG(salary), 2) AS avg_salary
FROM employees
GROUP BY department
HAVING SUM(salary) > 100000
ORDER BY total_salary DESC;
