-- ALL previous Tables created from CSV's used throught the module
-- Create a new table with current employees born between 1/1/1952 - 12/31/1955.
-- extract first name, last name, title, from date, and salary
-- This includes everyone, even if they changed roles, which means we will have duplications. 
select e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
into retirement_titles
from employees as e
	inner join title as ti
	on(e.emp_no = ti.emp_no)
where (e.birth_date between '1952-01-01' and '1955-12-31');

select * from retirement_titles

-- partition the data to only show the most recent titles from each employee. (Deduping basically)
-- Due to role switching, we have duplications in our data. We only want the most recent title. 
-- We are using r_num to track the number of times an employee may have switched. 
-- r_num = 1 means their current position
select *, 
row_number() over (partition BY first_name, last_name order BY from_date DESC) as r_num
into titles_order
from retirement_titles
order by emp_no asc;

select * from titles_order;


-- Create a Unique table of the soon to be retirees with their most recent job titles
select emp_no, 
	first_name, 
	last_name, 
	title
into unique_titles
from titles_order
where r_num=1;

--Refer to unique_titles.csv in Data folder.
select * from unique_titles;


-- Created a new column t_count, to track the count of titles in our retirement data
-- The column still needs to be grouped
select emp_no, 
	first_name, 
	last_name, title, 
	from_date, 
	salary,
	count(emp_no) over (Partition by title) as t_count
into count_titles
from unique_titles
order by emp_no asc;

select * From count_titles;

--Created a grouping for the frequency count of employee titles. 
Select distinct title,t_count
into titles_count
From count_titles;
order by t_count asc;

select * from titles_count

select * from current_emp
-- Challenge: Employees that qualify for mentorship?
-- Inner Join for employee birth/hire dates, right join to get title.
select 
	current_emp.emp_no,
	current_emp.first_name,
	current_emp.last_name,
	title.title,
	title.to_date,
	title.from_date,
	employees.birth_date,
	employees.hire_date

into mentors

from current_emp
inner join employees
on(current_emp.emp_no = employees.emp_no)
right join title
on (title.emp_no = current_emp.emp_no);

-- Now that we have a mentors table, we can filter birth_date for employees 1/1/1955 - 12/31/1955 
select
	first_name,
	last_name,
	emp_no,
	title,
	from_date,
	to_date,
	birth_date
into mentor_challenge
from mentors
where birth_date between '1955-01-01' and '1955-12-31'
-- Heres are the employees that qualify to be in our mentor challenge. 
select * from mentor_challenge