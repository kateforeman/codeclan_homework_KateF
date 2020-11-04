--MVP 
--Q1 

SELECT 
	e.*, 
	p.local_account_no, 
	p.local_sort_code 
FROM 
	employees AS e LEFT JOIN pay_details AS p 
	  ON e.id = p.id; 

--MVP 
--Q2 

SELECT 
	e.*, 
	p.local_account_no, 
	p.local_sort_code, 
	t.name AS team_name
FROM 
	(employees AS e LEFT JOIN pay_details AS p 
	  ON e.id = p.id)
LEFT JOIN teams AS t 
ON e.team_id = t.id; 

--MVP 
--Q3 

SELECT 
	e.first_name, 
	e.last_name, 
	t.name, 
	CAST(t.charge_cost AS INT) 
FROM employees  AS e INNER JOIN teams AS t 
ON e.team_id = t.id
WHERE CAST(charge_cost AS INT) >= 80
ORDER BY last_name ASC NULLS LAST; 

--MVP 
--Q4 

SELECT 
	t.name AS team_name, 
	COUNT(e.id) AS number_of_employers_team 
FROM employees AS e FULL OUTER JOIN teams AS t 
ON e.team_id = t.id 
GROUP BY team_name; 

--MVP 
--Q5 

SELECT 
	id,
	first_name, 
	last_name, 
	fte_hours, 
	salary, 
	salary * fte_hours AS effective_salary,
	SUM(salary * fte_hours) OVER (ORDER BY (salary * fte_hours) ASC NULLS LAST) AS running_total_effective_salary
FROM employees 
GROUP BY id, first_name, last_name, fte_hours, salary; 

--MVP 
--Q6 

SELECT  
	e.id AS employee_id,
	e.team_id, 
	t.id, 
	t.name, 
	t.charge_cost,
	COUNT(e.id) AS total_day_charge 
FROM employees AS e INNER JOIN teams AS t 
ON e.team_id = t.id 
GROUP BY t.id; 


--MVP 
--Q7 	

--I can't figure out how to get question 6 to run but I would use a WHERE 
--total_day_charge > 5000 before the group by 