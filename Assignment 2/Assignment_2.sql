create database OnlineService

create table salesman
(salesman_id int primary key,
name varchar(20) not null,
city varchar(20) not null,
commission int not null);

select * from salesman

insert into salesman values(11,'Pranav','Karwar',200);
insert into salesman values(24,'Prasanna','Bengalore',300);
insert into salesman values(39,'Prajwal','Kodagu',100);
insert into salesman values(44,'Pooja','Hubli',500.5);
insert into salesman values(15,'Prokta','Mysore',200.2);


create table customer
(customer_id int primary key,
cust_name varchar(20) not null,
city varchar(20) not null,
grade int not null,
salesman_id int references salesman(salesman_id) on delete set null);

select * from customer

insert into customer values(101,'Bhargav','Mysore',1,15);
insert into customer values(206,'Ramya','Bengalore',3,24);
insert into customer values(225,'Rajesh','Hubli',2,39);
insert into customer values(324,'Ravi','Mangalore',5,44);
insert into customer values(456,'Rajdeep','Belagavi',3,15);
insert into customer values(501,'Raghu','Dharavad',4,39);
insert into customer values(300,'Bhavya','Bengalore',1,15);


create table orders
(ord_no int primary key,
purch_amt int not null,
ord_date date not null,
customer_id int references customer(customer_id) on delete set null,
salesman_id int  references salesman(salesman_id) on delete set null);

select * from orders


insert into orders values(5,10000,'2020-03-25',101,11);
insert into orders values(10,5000,'2020-03-25',456,15);
insert into orders values(7,9500,'2020-04-30',225,44);
insert into orders values(11,8700,'2020-07-01',324,24);
insert into orders values(17,1500,'2020-07-07',206,39);




select salesman.name , customer.cust_name, customer.city from salesman, customer
where customer.city = salesman.city


select orders.ord_no, orders.purch_amt, customer.cust_name, customer.city from customer,orders
where purch_amt between 500 and 2000 and customer.customer_id = orders.customer_id


select customer.cust_name, customer.city,salesman.name, salesman.commission from salesman,customer
where salesman.salesman_id = customer.salesman_id


select customer.cust_name ,customer.city, salesman.name, salesman.commission from salesman, customer
where salesman.commission > 12 and  salesman.salesman_id =  customer.salesman_id


select customer.cust_name, customer.city, salesman.name , salesman.city from customer, salesman 
where customer.city != salesman.city and  salesman.commission > 12 and customer.salesman_id = salesman.salesman_id


select orders.ord_no, orders.ord_date, orders.purch_amt, customer.cust_name,customer.grade, salesman.name,salesman.commission 
from ((orders 
left join customer on orders.customer_id = customer.customer_id) 
left join salesman on orders.salesman_id = salesman.salesman_id
) 

select distinct * from ((orders 
inner join customer on orders.customer_id = customer.customer_id)
inner join salesman on orders.salesman_id =  salesman.salesman_id)

Select * from orders O 
inner join customer C on O.customer_id = C.customer_id 
inner join Salesman S on O.salesman_id = S.salesman_id 
where S.salesman_id = O.salesman_id and O.salesman_id = C.salesman_id

select customer.cust_name, customer.city, customer.customer_id, salesman.name, salesman.city 
from customer
left join salesman
on customer.salesman_id = salesman.salesman_id
order by customer.customer_id 


select customer.cust_name, customer.city, customer.grade,salesman.name as salesnamName,salesman.city as SalesmanCity
from customer 
left join salesman on customer.salesman_id =  salesman.salesman_id
where  customer.grade < 300
order by customer.customer_id


select customer.cust_name, customer.city, orders.ord_no,orders.ord_date,orders.purch_amt 
from customer
left join orders on customer.customer_id = orders.customer_id
order by orders.ord_date


select customer.cust_name, customer.city, orders.ord_no, orders.ord_no, orders.ord_date,orders.purch_amt,salesman.name, salesman.commission
from ((customer
left join orders on orders.customer_id = customer.customer_id
)
left join salesman on orders.salesman_id = salesman.salesman_id) 



select c.salesman_id,c.cust_name,c.grade,c.cust_name ,c.city
from customer c
right join salesman s on s.salesman_id = c.salesman_id
order by s.salesman_id


select s.name as NameOfSelesman ,c.cust_name,c.city,o.ord_no,o.ord_date,o.purch_amt
from ((salesman s
left  join orders o on s.salesman_id =  o.salesman_id )
left join customer c on c.salesman_id = s.salesman_id)



select  s.name as salesman , c.grade, o.purch_amt,c.cust_name as CustomerName
from ((customer c
right join salesman s on s.salesman_id =  c.salesman_id)
left join orders o on o.customer_id = c.customer_id)
where o.purch_amt >2000 and c.grade is not null


select  s.name as salesman , c.grade, o.purch_amt,c.cust_name as CustomerName
from ((customer c
right join salesman s on s.salesman_id =  c.salesman_id)
left join orders o on o.customer_id = c.customer_id)
where o.purch_amt >2000 and c.grade is not null



select  c.cust_name as CustomerName,c.city,o.ord_no,o.customer_id,o.purch_amt
from customer c
left join orders o on c.customer_id = o.customer_id
where c.grade is not null

select * from salesman
cross join customer

select * from salesman
cross join customer
where salesman.city = customer.city


select s.name as salesPerson , c.cust_name as customerName , c.grade
from salesman s
cross join customer c

select * from salesman s 
cross join customer c
where s.city<>c.city and s.city is not null and c.grade is not null 


select * from salesman
select* from customer
select * from orders
