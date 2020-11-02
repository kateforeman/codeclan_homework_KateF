--MVP 
--Q1 

SELECT *
FROM employees 
WHERE department = 'Human Resources'; 

--MVP 
--Q2 

SELECT 
	first_name, 
	last_name, 
	country 
FROM employees 
WHERE department = 'Legal'; 

--MVP 
--Q3 

SELECT 
	COUNT(id) 
FROM employees 
WHERE country = 'Portugal'; 

--MVP 
--Q4 

SELECT 
	COUNT(id) 
FROM employees 
WHERE country = 'Portugal' OR country = 'Spain'; 

--MVP 
--Q5 

SELECT 
	COUNT(id) 
FROM pay_details 
WHERE local_account_no IS NULL; 

--MVP 
--Q6 

SELECT 
	first_name, 
	last_name 
FROM employees 
ORDER BY last_name ASC NULLS LAST; 

--MVP 
--Q7 

SELECT 
	first_name 
FROM employees 
WHERE first_name LIKE 'F%'; 

--MVP 
--Q8 

SELECT  
	COUNT(id) 
FROM employees 
WHERE country IS NOT ('France", "Spain') AND pension_enrol = TRUE;

--MVP 
--Q9 

SELECT 
	department, 
	COUNT(id) 
FROM employees 
WHERE start_date >= '2003-01-01' AND start_date >= '2003-12-31'
GROUP BY department; 

--MVP 
--Q10 

SELECT 
	department, 
	fte_hours, 
	COUNT(fte_hours) AS number_of_employees_working_each_pattern
FROM employees
GROUP BY department, fte_hours 
ORDER BY department ASC, fte_hours ASC; 

--MVP 
--Q11 

SELECT 
	department, 
	COUNT(id) 
FROM employees 
WHERE first_name IS NULL 
GROUP BY department
HAVING COUNT(id) >= 2; 

--MVP 
--G12 

SELECT 
	department, 
	COUNT(ID)
FROM employees 
GROUP BY department;  
