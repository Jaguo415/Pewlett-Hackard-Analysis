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


