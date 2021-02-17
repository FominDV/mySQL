#2.1
DELIMITER $
DROP PROCEDURE IF EXISTS dismiss_employee$
create PROCEDURE dismiss_employee (IN id INT)
proc: BEGIN
SET @last_day = current_date();
IF '9999-01-01' <> ALL (SELECT t.to_date FROM employees.titles t where t.emp_no = id) 
THEN leave proc;
END IF;
UPDATE employees.titles t 
SET 
    t.to_date = @last_day
WHERE
    t.emp_no = id
        AND t.to_date = '9999-01-01';
UPDATE employees.dept_emp t 
SET 
    t.to_date = @last_day
WHERE
    t.emp_no = id
        AND t.to_date = '9999-01-01';
UPDATE employees.dept_manager t 
SET 
    t.to_date = @last_day
WHERE
    t.emp_no = id
        AND t.to_date = '9999-01-01';
UPDATE employees.salaries t 
SET 
    t.to_date = @last_day
WHERE
    t.emp_no = id
        AND t.to_date = '9999-01-01';
SELECT CONCAT('Employee ', id, ' was dismissed') as 'successfully';
END$
DELIMITER ;
#2.2
DELIMITER %
START TRANSACTION;
SET @id =10023;
SET @last_day = current_date();
UPDATE employees.titles t 
SET 
    t.to_date = @last_day
WHERE
    t.emp_no = @id
        AND t.to_date = '9999-01-01';
UPDATE employees.dept_emp t 
SET 
    t.to_date = @last_day
WHERE
    t.emp_no = @id
        AND t.to_date = '9999-01-01';
UPDATE employees.dept_manager t 
SET 
    t.to_date = @last_day
WHERE
    t.emp_no = @id
        AND t.to_date = '9999-01-01';
UPDATE employees.salaries t 
SET 
    t.to_date = @last_day
WHERE
    t.emp_no = @id
        AND t.to_date = '9999-01-01';
COMMIT
DELIMITER ;
#3
EXPLAIN SELECT  `employees`.`departments`.`dept_name` AS `Departament`,
        COUNT(`employees`.`dept_emp`.`emp_no`) AS `quantity of employees`,
        SUM(`employees`.`salaries`.`salary`) AS `amount of all payments`
    FROM
        (((`employees`.`departments`
        JOIN `employees`.`salaries`)
        JOIN `employees`.`employees`)
        JOIN `employees`.`dept_emp`)
    WHERE
        ((`employees`.`departments`.`dept_no` = `employees`.`dept_emp`.`dept_no`)
            AND (`employees`.`dept_emp`.`to_date` = '9999-01-01')
            AND (`employees`.`dept_emp`.`emp_no` = `employees`.`employees`.`emp_no`)
            AND (`employees`.`employees`.`emp_no` = `employees`.`salaries`.`emp_no`)
            AND (`employees`.`salaries`.`to_date` = '9999-01-01'))
    GROUP BY `employees`.`departments`.`dept_no`
    ORDER BY `employees`.`departments`.`dept_name`