CREATE TABLE Departments (
    dept_no VARCHAR   NOT NULL,
    dept_name VARCHAR   NOT NULL,
    CONSTRAINT pk_Departments PRIMARY KEY (
        dept_no
     )
);

CREATE TABLE Dept_emp (
    emp_no INTEGER   NOT NULL,
    dept_no VARCHAR   NOT NULL
);

CREATE TABLE Dept_manager (
    dept_no VARCHAR   NOT NULL,
    emp_no INTEGER   NOT NULL
);

CREATE TABLE Employee (
    emp_no INTEGER   NOT NULL,
    emp_title VARCHAR   NOT NULL,
    birth_date DATE   NOT NULL,
    first_name VARCHAR   NOT NULL,
    last_name VARCHAR   NOT NULL,
    sex VARCHAR   NOT NULL,
    hire_date DATE   NOT NULL,
    CONSTRAINT pk_Employee PRIMARY KEY (
        emp_no
     )
);

CREATE TABLE Salaries (
    emp_no INTEGER   NOT NULL,
    salary INTEGER   NOT NULL
);

CREATE TABLE Title (
    title_id VARCHAR   NOT NULL,
    title VARCHAR   NOT NULL,
    CONSTRAINT pk_Title PRIMARY KEY (
        title_id
     )
);

ALTER TABLE Dept_emp ADD CONSTRAINT fk_Dept_emp_emp_no FOREIGN KEY(emp_no)
REFERENCES Employee (emp_no);

ALTER TABLE Dept_emp ADD CONSTRAINT fk_Dept_emp_dept_no FOREIGN KEY(dept_no)
REFERENCES Departments (dept_no);

ALTER TABLE Dept_manager ADD CONSTRAINT fk_Dept_manager_dept_no FOREIGN KEY(dept_no)
REFERENCES Departments (dept_no);

ALTER TABLE Dept_manager ADD CONSTRAINT fk_Dept_manager_emp_no FOREIGN KEY(emp_no)
REFERENCES Employee (emp_no);

ALTER TABLE Employee ADD CONSTRAINT fk_Employee_emp_title FOREIGN KEY(emp_title)
REFERENCES Title (title_id);

ALTER TABLE Salaries ADD CONSTRAINT fk_Salaries_emp_no FOREIGN KEY(emp_no)
REFERENCES Employee (emp_no);

--Verify that the data imported correctly
SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM employee;
SELECT * FROM salaries;
SELECT * FROM title;

--List employee number, first name, last name, sex, and salary
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employee AS e
JOIN salaries AS s
ON e.emp_no = s.emp_no;

--List first name, last name, and hire date for employees hired in 1986
SELECT first_name, last_name, hire_date 
FROM employee
WHERE hire_date BETWEEN '1/1/1986' AND '12/31/1986'
ORDER BY hire_date;

--List dept no, dept name, emp no, last name, and first name of each manager
SELECT d.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name
FROM departments AS d
JOIN dept_manager AS m
ON d.dept_no = m.dept_no
JOIN employee AS e
ON m.emp_no = e.emp_no;

--List emp no, last name, first name, and dept name for each employee
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp AS de
JOIN employee AS e
ON de.emp_no = e.emp_no
JOIN departments AS d
ON de.dept_no = d.dept_no;

--List first name, last name, and sex of employees with first name "Hercules" last name starting with B
