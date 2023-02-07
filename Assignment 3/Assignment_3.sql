create database company



create table Department (
dept_id int  primary key,
dept_name varchar(50) not null
);

insert into Department values(1001,'finance'),
(2001,'audit'),
(3001,'marketing'),
(4001,'production')

select * from Department


create table Employee (
emp_id int  primary key,
dept_id int foreign key references Department(dept_id),
mngr_id int  null,
emp_name varchar(50) not null,
salary int  null
)

alter table Employee 
alter column mngr_id int 

insert into Employee values 
(68319,1001,null, 'kayling',60000),
(66928,3001,68319, 'blaze',50000),
(67832,1001,68319, 'clare',48000),
(65646,2001,68319, 'zonas',80000),
(67858,2001,65464, 'scarlet',450000),
(69062,2001,65464, 'frank',40000),
(63679,2001,69062, 'sandrine',62000),
(64989,3001,66928, 'adelyn',22000),
(65271,3001,66928, 'wade',42000),
(66564,3001,66928, 'madden',100000),
(68454,3001,67858, 'tucker',55000),
(68736,2001,66928, 'andres',59000),
(69000,3001,67832, 'julies',70000),
(69324,1001,67832, 'marker',80000)


select * from Employee



select top 10 percent * from Employee
order by salary desc

select MAX(salary) from Employee



select COUNT(Employee.dept_id), Department.dept_id from Department
left join Employee on Employee.dept_id = Department.dept_id
group by Department.dept_id
having  COUNT(Employee.dept_id) < 3



select  COUNT(e.dept_id) as [Number of people],d.dept_name from Employee e
right join Department d on d.dept_id = e.dept_id 
group by d.dept_name
order by COUNT(e.dept_id) desc



select d.dept_name,e.salary from Employee e
left join Department d on e.dept_id = d.dept_id
order by d.dept_name


select d.dept_name,e.salary from Employee e
left join Department d on e.dept_id = d.dept_id
order by e.salary desc


select * from Department
select * from Employee