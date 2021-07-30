create table departments(
	dept_no Varchar(4) Not Null,
	dept_name Varchar(40) Not Null,
	Primary Key (dept_no),
	unique(dept_name)

);

select * from departments;

create table employees(
	emp_no int not null,
	birth_date date not null,
	first_name varchar not null,
	last_name varchar not null,
	gender varchar not null,
	hire_date date not null,
	Primary Key(emp_no)
	
);

select * from employees;

create table dept_manager(
	dept_no varchar(4) not null,
	emp_no int not null,
	from_date date not null,
	to_date date not null,
	foreign key(emp_no) references employees(emp_no),
	foreign key(dept_no) references departments(dept_no),
	primary key(emp_no,dept_no)

);
select * from dept_manager;

create table salarys(
	emp_no int not null,
	salary int not null,
	from_date date not null,
	to_date date not null,
	foreign key(emp_no) references employees(emp_no),
	primary key(emp_no)

);

select * from salarys 


create table title(
	emp_no int not null,
	title varchar(50) not null,
	from_date date not null,
	to_date date not null

);

select * from title

create table dept_emp(
	emp_no int not null,
	dept_no varchar(4) not null,
	from_date date not null,
	to_date date not null,
	foreign key (emp_no) references employees(emp_no),
	foreign key (dept_no) references departments(dept_no),
	primary key(emp_no, dept_no)
);

copy departments from '/Users/jguo/public/departments.csv'
with delimiter ','
csv header;

copy employees from '/Users/jguo/public/employees.csv'
with delimiter ','
csv header;

copy dept_manager from '/Users/jguo/public/dept_manager.csv'
with delimiter ','
csv header;


copy title from '/Users/jguo/public/titles.csv'
with delimiter ','
csv header;

copy salarys from '/Users/jguo/public/salaries.csv'
with delimiter ','
csv header;

copy dept_emp from '/Users/jguo/public/dept_emp.csv'
with delimiter ','
csv header;


SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';


-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


-- Retirement eligibility count
SELECT count (first_name)
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Query
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the Table
SELECT * FROM retirement_info;


-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;


-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
    dept_emp.to_date	
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;


SELECT ri.emp_no,
    ri.first_name,
ri.last_name,
    de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;



-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;


SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;


SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');



-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;



SELECT * FROM salarys;

SELECT * FROM salarys
ORDER BY to_date DESC;

SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);


SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

select * from dept_info;


select e.emp_no,
e.first_name,
e.last_name,
ti.title,
e.birth_date,
e.hire_date,
ti.to_date
into mentorship
from employees as e
left join title as ti
on (e.emp_no = ti.emp_no)
where (e.birth_date between '1965-01-01' and '1965-12-31')
and ti.to_date = '9999-01-01';

select * from mentorship