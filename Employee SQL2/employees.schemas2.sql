-- Create the 'titles' table
CREATE TABLE titles (
    title_id CHAR(5) PRIMARY KEY,
    title VARCHAR(255) NOT NULL
);

-- Create the 'employees' table
CREATE TABLE employees (
    emp_no SERIAL PRIMARY KEY,
    title_id CHAR(5) REFERENCES titles (title_id),
    birth_date DATE,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    sex CHAR(1),
    hire_date DATE
);

-- Create the 'departments' table
CREATE TABLE departments (
    dept_no CHAR(4) PRIMARY KEY,
    dept_name VARCHAR(255) NOT NULL
);

-- Create the 'dept_emp' table
CREATE TABLE dept_emp (
    id SERIAL PRIMARY KEY,
    emp_no INT REFERENCES employees (emp_no),
    dept_no CHAR(4) REFERENCES departments (dept_no)
);

-- Create the 'dept_manager' table
CREATE TABLE dept_manager (
	id SERIAL PRIMARY KEY,
    dept_no CHAR(4),
    emp_no INT REFERENCES employees (emp_no)
);

-- Create the 'salaries' table
CREATE TABLE salaries (
    emp_no INT REFERENCES employees (emp_no),
    salary INT,
    PRIMARY KEY (emp_no, salary) -- Assuming multiple salary entries for employees
);

SELECT
    e.emp_no AS employee_number,
    e.last_name,
    e.first_name,
    e.sex,
    s.salary
FROM
    employees e
JOIN
    salaries s
ON
    e.emp_no = s.emp_no;
--------
SELECT
    first_name,
    last_name,
    hire_date
FROM
    employees
WHERE
    EXTRACT(YEAR FROM hire_date) = 1986;
---------
SELECT
    dm.dept_no AS department_number,
    d.dept_name AS department_name,
    dm.emp_no AS manager_employee_number,
    e.last_name AS manager_last_name,
    e.first_name AS manager_first_name
FROM
    dept_manager dm
JOIN
    departments d
ON
    dm.dept_no = d.dept_no
JOIN
    employees e
ON
    dm.emp_no = e.emp_no;
---------
SELECT
    e.emp_no AS employee_number,
    e.last_name,
    e.first_name,
    d.dept_no AS department_number,
    d.dept_name AS department_name
FROM
    employees e
JOIN
    dept_emp de
ON
    e.emp_no = de.emp_no
JOIN
    departments d
ON
    de.dept_no = d.dept_no;
-------------
SELECT
    first_name,
    last_name,
    sex
FROM
    employees
WHERE
    first_name = 'Hercules'
    AND last_name LIKE 'B%';
----------------

SELECT
    e.emp_no AS employee_number,
    e.last_name,
    e.first_name
FROM
    employees e
JOIN
    dept_emp de
ON
    e.emp_no = de.emp_no
JOIN
    departments d
ON
    de.dept_no = d.dept_no
WHERE
    d.dept_name = 'Sales';
---------------

SELECT
    e.emp_no AS employee_number,
    e.last_name,
    e.first_name,
    d.dept_name AS department_name
FROM
    employees e
JOIN
    dept_emp de
ON
    e.emp_no = de.emp_no
JOIN
    departments d
ON
    de.dept_no = d.dept_no
WHERE
    d.dept_name IN ('Sales', 'Development');
--------------------
SELECT
    last_name,
    COUNT(*) AS name_count
FROM
    employees
GROUP BY
    last_name
ORDER BY
    name_count DESC, last_name;
