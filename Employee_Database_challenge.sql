--Retirement eligibility creating new table to hold info
select emp_no, first_name, last_name
into retirement_info
from employees
where (birth_date between '1925-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31')

-- number of employees retiring count table
select count (first_name)
FROM employees
WHERE (birth_date between '1925-01-01' and '1955-12-31')
and (hire_date between'1985-01-01' and '1988-12-31');

-- This query joins dept_managers and departments into a table
select d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
from departments as d
inner join dept_manager as dm
on d.dept_no = dm.dept_no
where dm.to_date = ('9999-01-01')

-- selecting current employees
select ri.emp_no,
ri.first_name,
ri.last_name,
de.to_date
into current_emp
from retirement_info as ri
left join dept_emp as de 
on ri.emp_no = de.emp_no
where de.to_date = ('9999-01-01');

-- employee count by department number
select count (ce.emp_no),de.dept_no
from current_emp as ce
left join dept_emp as de
on ce.emp_no = de.emp_no
group by de.dept_no
order by de.dept_no;

-- Table, Employee list with gender and salary
select 
e.emp_no,
e.first_name,
e.last_name,
e.gender,
s.salary,
de.to_date
into emp_info
from employees as e
inner join salarys as s
	on(e.emp_no = s.emp_no)
inner join dept_emp as de
	on(e.emp_no = de.emp_no)
where (e.birth_date between '1952-01-01' and '1955-12-31')
and (e.hire_date between '1985-01-01' and '1988-12-31')
and (de.to_date='9999-01-01');

-- Create a list of managers per departments

select dm.dept_no,
	d.dept_name,
	dm.emp_no,
	ce.last_name,
	ce.first_name,
	dm.from_date,
	dm.to_date
into manager_info
from dept_manager as dm
inner join departments as d
		on (dm.dept_no = d.dept_no)
inner join current_emp as ce
		on(dm.emp_no = ce.emp_no);
		
select * from manager_info

-- Create list of employees in their departments. Table
select ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
into dept_info
from current_emp as ce
inner join dept_emp as de
		on (ce.emp_no = de.emp_no)
inner join departments as d
		on (de.dept_no = d.dept_no);
		
-- list of sales employees 

select 
ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
into sales_info
from current_emp as ce
inner join dept_emp as de
	on (ce.emp_no = de.emp_no)
inner join departments as d
	on (d.dept_no = de.dept_no)
where d.dept_name = 'Sales';

select * from sales_info

-- list of sales and development


select 
ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
into sales_dev
from current_emp as ce
inner join dept_emp as de
	on (ce.emp_no = de.emp_no)
inner join departments as d
	on (d.dept_no = de.dept_no)
where d.dept_name in ('Sales','Development')
order by ce.emp_no;

select * from sales_dev


-- challenge number of titles retiring

select ce.emp_no,
ce.first_name,
ce.last_name,
ti.title,
ti.from_date,
ti.to_date
into ret_titles
from current_emp as ce
	inner join title as ti
		on(ce.emp_no = ti.emp_no)
order by ce.emp_no 

-- export table as ret_titles.csv
select * from ret_titles
order by ret_titles.emp_no;

-- partition the data to show only recent title per employee
select emp_no,
	first_name,
	last_name,
	to_date,
	title
into unique_titles
from(
	select emp_no,
	first_name,
	last_name,
	to_date,
	title, row_number() over 
	(partition by (emp_no)
	order by to_date desc) rn
	from ret_titles)
	tmp where rn = 1
order by emp_no;
	
select * from unique_titles;

-- counting the number of employees per title


select count (title),title
into retiring_titles
from unique_titles
group by title
order by count desc;

select * from retiring_titles;


-- creating a list of employees eligible for potential mentorship program

select e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
into mentorship
from employees as e
inner join dept_emp as de
	on(e.emp_no = de.emp_no)
inner join title as ti
	on (e.emp_no = ti.emp_no)
where (de.to_date = '9999-01-01')
and (e.birth_date between '1965-01-01' and '1965-12-31')
order by e.emp_no;

select * from mentorship