
--Drop table if exists
DROP TABLE IF EXISTS departments cascade;
DROP TABLE IF EXISTS dept_emp cascade;
DROP TABLE IF EXISTS dept_manager cascade;
DROP TABLE IF EXISTS employees cascade;
DROP TABLE IF EXISTS salaries cascade;
DROP TABLE IF EXISTS titles cascade;

-- Create new tables to import data
CREATE TABLE departments (
dept_no VARCHAR PRIMARY KEY,
dept_name VARCHAR
);

CREATE TABLE dept_emp (
	emp_no INT,
	dept_no VARCHAR, 
	PRIMARY KEY (emp_no, dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);

CREATE TABLE dept_manager (
	dept_no VARCHAR,
	emp_no INT,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (dept_no, emp_no)
	
);

CREATE TABLE employees (
	emp_no INT,
	emp_title_id VARCHAR,
	birth_date DATE,
	first_name VARCHAR,
	last_name VARCHAR,
	sex VARCHAR,
	hire_date DATE,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_title_id) REFERENCES titles (title_id)
);

CREATE TABLE salaries (
	emp_no INT PRIMARY KEY,
	salary INT,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

CREATE TABLE titles (
	title_id VARCHAR PRIMARY KEY,
	title VARCHAR
);


-- View the table to ensure all data has been imported correctly
SELECT * FROM dept_manager;


-- List the employee number, last name, first name, sex, and salary of each employee.
SELECT
employees.emp_no,
last_name,
first_name,
sex,
salary
FROM
employees
LEFT JOIN salaries ON salaries.emp_no = employees.emp_no
ORDER BY salary DESC;


-- List the first name, last name, and hire date 
--for the employees who were hired in 1986.
SELECT
first_name,
last_name,
hire_date
FROM 
employees
WHERE  hire_date >= '1/1/1986'
AND hire_date <= '12/12/1986'
ORDER BY hire_date ASC;


-- List the manager of each department along with their department number, 
-- department name, employee number, last name, and first name.
SELECT
dept_manager.dept_no,
departments.dept_name,
dept_manager.emp_no,
employees.last_name,
employees.first_name
FROM 
employees
LEFT JOIN dept_manager ON dept_manager.emp_no = employees.emp_no
INNER JOIN departments ON dept_manager.dept_no = departments.dept_no;



-- List the department number for each employee along with that employee’s employee number, 
-- last name, first name, and department name.
SELECT
dept_emp.dept_no,
employees.emp_no,
last_name,
first_name,
departments.dept_name
FROM
employees
LEFT JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON departments.dept_no = dept_emp.dept_no;



-- List first name, last name, and sex of each employee whose first name is Hercules 
-- and whose last name begins with the letter B.
SELECT
last_name,
first_name,
sex
FROM
employees
WHERE first_name = 'Hercules'
AND last_name LIKE '%B%';



-- REDO List each employee in the Sales department, including their 
-- employee number, last name, and first name.
SELECT 
employees.emp_no,
last_name,
first_name,
dept_emp.dept_no
FROM 
employees
LEFT JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';



-- List each employee in the Sales and Development departments, including their:
-- employee number, last name, first name, and department name.
SELECT 
employees.emp_no,
last_name,
first_name,
dept_emp.dept_no,
departments.dept_name
FROM 
employees
LEFT JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name IN ('Sales','Development')



-- List the frequency counts, in descending order, of all the employee last names 
-- (that is, how many employees share each last name).
SELECT
last_name, COUNT (*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;


-- View tables data
Select * from departments