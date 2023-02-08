

use Northwind 
go

select * from CustomerCustomerDemo
select * from CustomerDemographics
select * from Customers
select * from Employees
select * from EmployeeTerritories
select * from [Order Details]

select * from Products
select * from Region
select * from Shippers
select * from Suppliers
select * from Territories
select * from Categories
select * from Orders
go






 




--Query 1
alter procedure Avrage_Freight
@CustomerID char(5),
@AVG_Freight float output
as 
begin 
	select @AVG_Freight = AVG(Freight)  from Orders ID where CustomerID = @CustomerID
	
end


declare @AVG_Freight float
exec Avrage_Freight 'HUNGO',@AVG_Freight out
print @AVG_Freight




create trigger tr_Order_insert
on Orders
instead of insert
as 
begin
	declare @AVG_Freight money
	declare @Freight money
	declare @CustomerID char(5)
	select @Freight = Freight from inserted
	select @CustomerID = CustomerID from inserted

	exec Avrage_Freight @CustomerID, @AVG_Freight out

	if (@AVG_Freight < @Freight)
	begin
		print 'Freight Must not higher than Avrage Freight '
	end
end


create trigger tr_Order_Update
on Orders
instead of update
as
begin
	declare @AVG_Freight money
	declare @Freight money
	declare @CustomerID char(5)
	select @Freight = Freight from inserted
	select @CustomerID = CustomerID from inserted


	exec Avrage_Freight @CustomerID, @AVG_Freight out

	if (@AVG_Freight < @Freight)
	begin
		print 'Freight Must not higher than Avrage Freight '
	end
end

declare @AVG_Freight float
exec Avrage_Freight 'HUNGO',@AVG_Freight out
print @AVG_Freight

INSERT INTO Orders VALUES (N'RATTC',1,'5/6/1998','6/3/1998',NULL,2,8.53,
	N'Rattlesnake Canyon Grocery',N'2817 Milton Dr.',N'Albuquerque',
	N'NM',N'87110',N'USA')

	INSERT INTO Orders VALUES (N'RATTC',1,'5/6/1998','6/3/1998',NULL,2,228.53,
	N'Rattlesnake Canyon Grocery',N'2817 Milton Dr.',N'Albuquerque',
	N'NM',N'87110',N'USA')


select *from Orders
order by CustomerID

go 








--query 2

create procedure SaleByCountry
as 
begin
select e.Country, sum(TotalSale) as [Total Sale]
from Employees e
left join( select o.OrderID,o.EmployeeID,od.TotalSale from Orders o left join (Select OrderId, (SUM( UnitPrice * Quantity * (1-Discount)/100)*100) as TotalSale FROM [Order Details] GROUP BY OrderID) od
		on o.OrderID = od.OrderID) p
on p.EmployeeID = e.EmployeeID
Group by e.Country
end


exec SaleByCountry
go










--query 3

create procedure SaleByYear
as
begin
select YearOfSale,sum(TotalSale) as [Total Sale]
from Employees e
Right join( select o.OrderID,o.EmployeeID,od.TotalSale,datename(yyyy,o.ShippedDate) as YearOfSale from Orders o left join (Select OrderId, (SUM( UnitPrice * Quantity * (1-Discount)/100)*100) as TotalSale FROM [Order Details] GROUP BY OrderID) od
		on o.OrderID = od.OrderID) p
on p.EmployeeID = e.EmployeeID
Group by YearOfSale
order by [Total Sale] desc
end


exec SaleByYear

go










--query 4 
create procedure SaleBycategory
as
BEGIN 
	SELECT c.CategoryID, c.CategoryName, ct.[Total sales]  FROM Categories c
	inner join (select  p.CategoryID,SUM(s.TotalSale) as [Total sales] from Products p
	left join (Select  ProductID, (SUM( UnitPrice * Quantity * (1-Discount)/100)*100) as TotalSale FROM [Order Details] GROUP BY  ProductID) s
	on p.ProductID = s.ProductID
	Group by p.CategoryID) ct
	on c.CategoryID = ct.CategoryID
END

exec SaleBycategory
go
















--query 5
create procedure MostExpensive
as
select top 10 ProductID,ProductName,UnitPrice from Products
order by UnitPrice desc


exec MostExpensive

go











--query 6
create procedure InsertCustomerOrderDetail
@OrderID int,
@ProductID int,
@UnitPrice money,
@Quantity int,
@Discount float
as
BEGIN
insert into [Order Details]
values(
@OrderID ,
@ProductID,
@UnitPrice,
@Quantity,
@Discount
)
END

exec InsertCustomerOrderDetail 10248,16,21,19,0.13
select * from [Order Details]

go 








--query 7

create procedure spUpdateCustomerOrderDetail
@OrderID int,
@ProductID int,
@UnitPrice money,
@Quantity int,
@Discount float
as 
begin 
	update [Order Details]
	set		UnitPrice =	@UnitPrice,
			Quantity = @Quantity,
			Discount = @Discount
	where ProductID = @ProductID and OrderID = @OrderID
end


select * from [Order Details]
exec spUpdateCustomerOrderDetail 10248,11,01,19,0.88880 




--create procedure SaleByYear
--as 
--select coalesce(datename(yy,o.ShippedDate) ,'Year Not Given') as [Year],sum(o.Freight) 
--from Employees e
--inner join Orders o on o.EmployeeID = e.EmployeeID
--Group by  DATENAME(YYYY,o.ShippedDate)
--Go

--exec SaleByYear

--select o.ShippedDate,o.Freight,concat(e.FirstName,' ',e.LastName) as [Full Name],o.OrderID,e.Country
-- from Employees e
--inner join Orders o on o.EmployeeID = e.EmployeeID
--order by o.ShippedDate desc
-- Catagory_id ->FK in Products and catagory



--create procedure SaleByCountry
--as 
--select e.Country,e.FirstName,e.LastName,concat(e.FirstName,' ',e.LastName) as [Full Name],o.Freight,o.ShippedDate,o.OrderID,o.OrderDate 
--from Employees e
--inner join Orders o on o.EmployeeID = e.EmployeeID
--order by e.Country;
--Go

--select sum(o.Freight),e.Country 
--from Employees e
--inner join Orders o on o.EmployeeID = e.EmployeeID
--Group by e.Country

--exec SaleByCountry
--select c.CategoryName,sum(p.UnitsOnOrder * p.UnitPrice) as CategorySale from Products p
--left join Categories c on c.CategoryID = p.CategoryID 
--group by c.CategoryName
--order by CategorySale desc
--go 
--as
--begin
--select sum(TotalSale) as [Total Sale]
--from Categories c
--left  join( select p.CategoryID,p.ProductID from Products p
--left join (Select ProductID,orderID, (SUM( UnitPrice * Quantity * (1-Discount)/100)*100) as TotalSale FROM [Order Details] GROUP BY OrderID) od
--		on p.ProductID = od.ProductID) o
--on o = c.CategoryID
--Group by YearOfSale
--order by [Total Sale] desc
--end
--select e.Country, sum(TotalSale) as [Total Sale]
--from Employees e
--left join( select o.OrderID,o.EmployeeID,od.TotalSale from Orders o left join (Select OrderId, (SUM( UnitPrice * Quantity * (1-Discount)/100)*100) as TotalSale FROM [Order Details] GROUP BY OrderID) od
--		on o.OrderID = od.OrderID) p
--on p.EmployeeID = e.EmployeeID
--Group by e.Country