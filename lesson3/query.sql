#Geodata
USE geodata;
#1
SELECT DISTINCT
    _cities.title AS City,
    _regions.title AS Region,
    _countries.title_ru AS Country
FROM
    _cities
        INNER JOIN
    _countries ON _cities.country_id = _countries.country_id
        LEFT JOIN
    _regions ON _regions.region_id = _cities.region_id
ORDER BY City;
#2
SELECT 
    _cities.title AS 'City of MO'
FROM
    _cities,
    _regions
WHERE
    _cities.region_id = _regions.region_id
        AND _regions.title LIKE 'Московская%';
#Eployees
USE employees;
#1
SELECT 
    departments.dept_name AS Departament,
    ROUND(AVG(salaries.salary), 2) AS Middle_salary
FROM
    departments,
    salaries,
    employees,
    dept_emp
WHERE
    departments.dept_no = dept_emp.dept_no
        AND dept_emp.to_date = '9999-01-01'
        AND dept_emp.emp_no = employees.emp_no
        AND employees.emp_no = salaries.emp_no
GROUP BY departments.dept_no;
#2
SELECT 
    CONCAT(employees.first_name,
            ' ',
            employees.last_name) name,
    MAX(salaries.salary) AS max_salary
FROM
    employees,
    salaries,
    dept_emp
WHERE
    employees.emp_no = salaries.emp_no
        AND employees.emp_no = dept_emp.emp_no
        AND dept_emp.to_date = '9999-01-01'
GROUP BY name;
#3
DELETE FROM employees 
WHERE
    emp_no IN (SELECT 
        salaries.emp_no
    FROM
        salaries,
        dept_emp
    
    WHERE
        salaries.emp_no = employees.emp_no
        AND employees.emp_no = dept_emp.emp_no
        AND dept_emp.to_date = '9999-01-01'
        AND salaries.salary = (SELECT 
            MAX(salaries.salary)
        FROM
            salaries)) LIMIT 1;
#4.1
SELECT 
    departments.dept_name AS Departament,
    COUNT(dept_emp.emp_no) AS 'quantity of employees'
FROM
    departments,
    dept_emp
WHERE
    departments.dept_no = dept_emp.dept_no
        AND dept_emp.to_date = '9999-01-01'
GROUP BY departments.dept_no
ORDER BY departments.dept_name;
#4.2
SELECT 
    COUNT(dept_emp.emp_no) AS 'quantity of all employees'
FROM
    departments,
    dept_emp
WHERE
    departments.dept_no = dept_emp.dept_no
        AND dept_emp.to_date = '9999-01-01';
#5
SELECT 
    departments.dept_name AS Departament,
    COUNT(dept_emp.emp_no) AS 'quantity of employees',
    sum(salaries.salary) as 'amount of all payments'
FROM
    departments,
    salaries,
    employees,
    dept_emp
WHERE
    departments.dept_no = dept_emp.dept_no
        AND dept_emp.to_date = '9999-01-01'
        AND dept_emp.emp_no = employees.emp_no
        AND employees.emp_no = salaries.emp_no
        AND salaries.to_date='9999-01-01'
GROUP BY departments.dept_no
ORDER BY departments.dept_name;