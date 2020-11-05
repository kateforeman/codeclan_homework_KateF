--MVP 
--Q1 

SELECT *
FROM pay_details 
WHERE local_account_no IS NULL AND iban IS NULL; 

--MVP 
--Q2 

SELECT 
	first_name, 
	last_name, 
	country 
FROM employees 
ORDER BY country ASC, last_name NULLS LAST; 

--MVP 
--Q3 

SELECT * 
FROM employees 
ORDER BY salary DESC NULLS LAST 
LIMIT 10; 

--MVP 
--Q4 

SELECT 
	first_name, 
	last_name, 
	salary 
FROM employees 
WHERE country = 'Hungary' 
ORDER BY salary ASC NULLS LAST 
LIMIT 1; 

--MVP 
--Q5 

SELECT *
FROM employees 
WHERE email LIKE '%yahoo%'; 

--MVP 
--Q6 

SELECT 
	pension_enrol, 
	COUNT(id) 
FROM employees 
GROUP BY pension_enrol; 

--MVP 
--Q7 

SELECT 
	salary, 
	department, 
	fte_hours 
FROM employees 
WHERE fte_hours = 1.0 AND department = 'Engineering'
ORDER BY salary DESC NULLS LAST 
LIMIT 1; 

--MVP 
--Q8 

SELECT 
	country, 
	COUNT(id), 
	AVG(salary) AS mean_salary
FROM employees 
GROUP BY country
HAVING COUNT(id) > 30 
ORDER BY mean_salary DESC NULLS LAST; 

--MVP 
--Q9 

SELECT 
	first_name, 
	last_name, 
	fte_hours, 
	salary, 
	fte_hours * salary AS effective_yearly_salary 
FROM employees;  

--MVP 
--Q10 

SELECT 
	e.id, 
	e.first_name, 
	e.last_name, 
	p.local_tax_code, 
	p.id
FROM employees AS e FULL OUTER JOIN pay_details AS p
ON e.id = p.id
WHERE local_tax_code IS NULL; 

--MVP 
--Q11 

SELECT 
	first_name,
	last_name,
	(48 * 35 * CAST(t.charge_cost AS INT) - e.salary) * e.fte_hours AS expected_profit 
FROM employees AS e LEFT JOIN teams AS t 
ON e.id = t.id; 

--MVP 
--Q12 
--Legal has the most at 102 employees 
--With column specifications must have the alias names 

WITH legal_averages(department, mean_salary, mean_ftehours) AS (
SELECT 
	department,
 	AVG(salary) AS mean_salary,
	AVG(fte_hours) AS mean_ftehours 
FROM employees
GROUP BY department 
)
SELECT  
	e.department,
	e.first_name, 
	e.last_name,
	e.salary, 
	e.fte_hours,
	e.salary / legal_averages.mean_salary AS legal_average, 
	e.fte_hours / legal_averages.mean_ftehours AS fte_average
FROM employees AS e LEFT JOIN legal_averages 
ON e.department = legal_averages.department
WHERE e.department = 'Legal'; 

--Extension 
--Q1 

SELECT 
	first_name, 
	COUNT(id) 
FROM employees 
WHERE first_name IS NOT NULL
GROUP BY first_name 
HAVING COUNT(id) > 1 country;  

--Extension 
--Q2 

SELECT 
	pension_enrol, 
	COUNT(id), 
	COALESCE(CAST(pension_enrol AS VARCHAR), 'Unknown') AS pension_enrol_status 
FROM employees 
GROUP BY pension_enrol; 

--Extension 
--Q3 

SELECT 
	e.first_name, 
	e.last_name, 
	e.email, 
	e.start_date, 
	com.committee_id, 
	c.name
FROM (employees AS e RIGHT JOIN employees_committees AS com 
	ON e.id = com.employee_id) 
INNER JOIN committees AS c 
ON com.committee_id = c.id 
WHERE c.name = 'Equality and Diversity' 
ORDER BY start_date ASC NULLS LAST;  

--Extension 
--Q4 

SELECT 
	e.id, 
	com.committee_id, 
	c.name, 
	CASE 
	WHEN e.salary < 40000 THEN 'low' 
	WHEN e.salary > 40000 THEN 'high' 
	WHEN e.salary IS NULL THEN 'none' END salary_class 
FROM (employees AS e LEFT JOIN employees_committees AS com 
	ON e.id = com.employee_id) 
INNER JOIN committees AS c 
ON com.committee_id = c.id; 


	