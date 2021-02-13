#1
#Geodata
#1.1
CREATE OR REPLACE VIEW full_information_about_cities AS
SELECT DISTINCT
    geodata._cities.title AS City,
    geodata._regions.title AS Region,
    geodata._countries.title_ru AS Country
FROM
    geodata._cities
        INNER JOIN
    geodata._countries ON geodata._cities.country_id = geodata._countries.country_id
        LEFT JOIN
    geodata._regions ON geodata._regions.region_id = geodata._cities.region_id
ORDER BY City DESC;
SELECT 
    *
FROM
    full_information_about_cities;
#1.2
CREATE OR REPLACE view cities_of_MO as
SELECT 
    geodata._cities.title AS 'City of MO'
FROM
    geodata._cities,
    geodata._regions
WHERE
    geodata._cities.region_id = geodata._regions.region_id
        AND geodata._regions.title LIKE 'Московская%' and geodata._cities.title like 'Лю%';
        SELECT 
    *
FROM
    cities_of_MO;
        
#Eployees
#1.3
CREATE OR REPLACE VIEW salary_by_departament AS
    SELECT 
        employees.departments.dept_name AS Departament,
        ROUND(AVG(employees.salaries.salary), 2) AS Middle_salary
    FROM
        employees.departments departments,
        employees.salaries salaries,
        employees.employees employees,
        employees.dept_emp dept_emp
    WHERE
        departments.dept_no = dept_emp.dept_no
            AND dept_emp.to_date = '9999-01-01'
            AND dept_emp.emp_no = employees.emp_no
            AND employees.emp_no = salaries.emp_no
    GROUP BY departments.dept_no;
SELECT * from salary_by_departament;
#1.4
CREATE OR REPLACE VIEW max_salary_of_emloyer AS
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
SELECT 
    *
FROM
    max_salary_of_emloyer;
#1.5
DROP FUNCTION IF EXISTS get_employer_of_max_salary;
CREATE FUNCTION get_employer_of_max_salary()
returns int DETERMINISTIC
return(
SELECT 
        employees.salaries.emp_no
    FROM
        employees.salaries salaries,
        employees.dept_emp dept_emp,
    employees.employees employees
    WHERE
        salaries.emp_no = employees.emp_no
        AND employees.emp_no = dept_emp.emp_no
        AND dept_emp.to_date = '9999-01-01'
        AND salaries.salary = (SELECT 
            MAX(salaries.salary)
        FROM
            salaries) LIMIT 1);
		DELETE from employees.employees emp where emp.emp_no = get_employer_of_max_salary();
#1.6
CREATE OR REPLACE VIEW quantity_of_employees AS
SELECT 
    COUNT(dept_emp.emp_no) AS 'quantity of all employees'
FROM
    departments,
    dept_emp
WHERE
    departments.dept_no = dept_emp.dept_no
        AND dept_emp.to_date = '9999-01-01';
SELECT 
    *
FROM
    quantity_of_employees;
#1.7
CREATE OR REPLACE VIEW departaments_info AS
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
SELECT 
    *
FROM
    departaments_info;
#2
DROP FUNCTION IF EXISTS get_manager_no;
CREATE FUNCTION get_manager_no (first_name VARCHAR(14), last_name VARCHAR(16))
RETURNS INT READS SQL DATA
RETURN (select managers.emp_no FROM employees.dept_manager managers
INNER JOIN employees.employees empl USING(emp_no)
WHERE empl.first_name LIKE CONCAT('%',first_name,'%') AND empl.last_name LIKE concat('%',last_name,'%') LIMIT 1);
SELECT 
    *
FROM
    employees.employees
        INNER JOIN
    employees.dept_manager mang USING (emp_no)
WHERE
    mang.emp_no = GET_MANAGER_NO('gareta', 'mar');
#3
DROP TRIGGER if EXISTS PAY_BONUS_SALARY;
CREATE 
    TRIGGER  PAY_BONUS_SALARY
 AFTER INSERT ON employees.employees FOR EACH ROW 
    INSERT INTO employees.salaries VALUE (NEW.emp_no , 1000 , current_date() , current_date());
#check tringger in action
INSERT INTO employees.employees VALUE (100000001,current_date(),'Iv','AN','M',current_date());
SELECT 
    *
FROM
    employees.salaries sal
WHERE
    sal.emp_no = 100000001;
