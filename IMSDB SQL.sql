create database IMS_DB
use IMS_DB

create table Login(
	UserId int not null,
	UserName varchar(50) null,
	Password varchar(50) null
	);

create table Product(
	ProductId int Identity(1,1) Primary Key not null,
	ProductName varchar(50) null,
	ProductDescription varchar(100) null
	);

create table Supplier(
	SupplierId int Identity(1,1) Primary Key not null,
	CompanyName varchar(50) null,
	TradeNo int null,
	MobileNo int null,
	Address varchar(100) null
	);

create table Purchase(
	PurchaseId int Identity(1,1) Primary Key not null,
	Quantity int null,
	Others varchar(100) null,
	ProductId int null,
	SupplierId int null,
	foreign key (ProductId) references Product (ProductId) on delete cascade on update cascade,
	foreign key (SupplierId) references Supplier (SupplierId) on delete cascade on update cascade
	);
	
create table Sales(
	SalesId int Identity(1,1) Primary Key not null,
	SalesProductName varchar(50) null,
	SalesCompanyName varchar(50) null,
	SalesQuantity int null,
	);
	SET IDENTITY_INSERT Sales OFF
	SET IDENTITY_INSERT Supplier OFF
	SET IDENTITY_INSERT Product OFF


insert into login (UserId,UserName, Password) 
values 
(1, 'usman', 2012358),
(2, 'alishan', 2012331),
(3, 'alisher', 2012367)

select * from login

CREATE Procedure GroupByTotalStock
as
begin
select Product.ProductName,Supplier.CompanyName, Sum(Purchase.Quantity) as total
from Product 
inner join Purchase on Product.ProductId = Purchase.ProductId
inner join Supplier on Purchase.SupplierId = Supplier.SupplierId
group by product.ProductName, Supplier.CompanyName
end

CREATE PROC [ProductCreateOrUpdate]
@ProductId int,
@ProductName varchar(50),
@ProductDescription varchar(100)
AS
BEGIN
IF(@ProductId=0)
	BEGIN
	INSERT INTO Product(ProductName,ProductDescription)
	VALUES(@ProductName,@ProductDescription)
	END
ELSE
	BEGIN
	UPDATE Product
	SET
		ProductName=@ProductName,
		ProductDescription=@ProductDescription
	WHERE ProductId=@ProductId
	END
END
GO

CREATE PROC [ProductDeleteById]
@ProductId int
AS
	BEGIN
	DELETE FROM Product
	WHERE ProductId=@ProductId
	END
GO


CREATE PROC [ProductViewAll]
AS
	BEGIN
	SELECT *
	FROM Product
	END
GO

CREATE PROC [dbo].[ProductViewById]
@ProductId int
AS
	BEGIN
	SELECT *
	FROM Product
	WHERE ProductId=@ProductId
	END
GO

CREATE PROC [dbo].[PurchaseCreateOrUpdate]
@PurchaseId int,
@ProductId int,
@SupplierId int,
@Quantity varchar(50),
@Others varchar(100)
AS
BEGIN
IF(@PurchaseId=0)
	BEGIN
	INSERT INTO Purchase(ProductId,SupplierId,Quantity,Others)
	VALUES(@ProductId,@SupplierId,@Quantity,@Others)
	END
ELSE
	BEGIN
	UPDATE Purchase
	SET
		ProductId=@ProductId,
		SupplierId=@SupplierId,
		Quantity= @Quantity,
		Others=@Others
	WHERE PurchaseId=@PurchaseId
	END
END
GO

Create Proc [dbo].[PurchaseDeleteById]
@PurchaseID int
As
Begin
delete from Purchase
where PurchaseId=@PurchaseID

End
GO

CREATE PROC [dbo].[PurchaseViewById]
@PurchaseId int
AS
	BEGIN
	
	Select Purchase.PurchaseID,Product.ProductName,Supplier.CompanyName,Purchase.Quantity,Purchase.Others 
from Purchase 
LEFT JOIN Product on Product.ProductId = Purchase.ProductId
LEFT JOIN Supplier on Supplier.SupplierId = Purchase.SupplierId
Where PurchaseId = @PurchaseId

	END
GO


CREATE proc [dbo].[RetriveSearch]
@ProductName varchar
AS
	BEGIN
	
select Product.ProductName,Supplier.CompanyName, Sum(Purchase.Quantity) as total
from Product 
inner join Purchase on Product.ProductId = Purchase.ProductId
inner join Supplier on Purchase.SupplierId = Supplier.SupplierId

group by product.ProductName, Supplier.CompanyName
having ProductName=@ProductName
	END
GO

Create PROC [dbo].[SupplierCreateOrUpdate]
@SupplierId int,
@CompanyName varchar(50),
@TradeNo int,
@MobileNo int,
@Address varchar(100)
AS
BEGIN
IF(@SupplierId=0)
	BEGIN
	INSERT INTO Supplier(CompanyName,TradeNo,MobileNo,Address)
	VALUES(@CompanyName,@TradeNo,@MobileNo,@Address)
	END
ELSE
	BEGIN
	UPDATE Supplier
	SET
		CompanyName=@CompanyName,
		TradeNo=@TradeNo,
		MobileNo=@MobileNo,
		Address=@Address
	WHERE SupplierId=@SupplierId
	END
END
GO


Create PROC [dbo].[SupplierDeleteById]
@SupplierId int
AS
	BEGIN
	DELETE FROM Supplier
	WHERE SupplierId=@SupplierId
	END
GO



Create PROC [SupplierViewAll]
AS
	BEGIN
	SELECT *
	FROM Supplier
	END
GO


create PROC [dbo].[SupplierViewById]
@SupplierId int
AS
	BEGIN
	SELECT *
	FROM Supplier
	WHERE SupplierId=@SupplierId
	END
GO

Create PROC [dbo].[ViewProductName]

AS
	BEGIN
	SELECT product.ProductName
	FROM Purchase 
	inner join Product 
	on Product.ProductId=Purchase.ProductId
	
	END
GO

CREATE Proc [dbo].[ViewPurchaseGrid]

As
Begin
Select Purchase.PurchaseID,Product.ProductName,Supplier.CompanyName,Purchase.Quantity,Purchase.Others 
from Supplier, Purchase 
LEFT JOIN Product on Product.ProductId = Purchase.ProductId
Where Supplier.SupplierId = Purchase.SupplierId

End
GO

Create PROC [dbo].[ViewSupplierName]

AS
	BEGIN
	SELECT Supplier.CompanyName
	FROM Purchase inner join Supplier 
	on Supplier.SupplierId=Purchase.SupplierId
	
	END
GO



select * from login


select * from Product
select * from Purchase
select * from Sales	
select * from Supplier
insert into Product values 
('Handfree', 'Wired'),
('Charger', 'Laptop'),
('Mouse', 'Razer'),
('Toys', 'For Kids'),
('Mobiles', 'VEVO'),
('Keys', 'Random'),
('Documents', 'Financial Reports'),
('Batteries', 'Dry'),
('E-Cards', 'Vouchers')
insert into Sales(SalesProductName, SalesCompanyName, SalesQuantity) 
values
('toys', 'PlayKids', 80),
('jackets', 'Boss', 12),
('wokkiedokkie', 'Navy', 32)

select * from Supplier
insert Supplier(CompanyName, TradeNo, MobileNo, Address)
values
('Boss', '12224', 03123, 'XYZ'),
('Navy', '13224', 03124, 'lnm'),
('Boss', '14224', 03121, 'pqr'),
('Boss', '15224', 03120, 'rst')

exec ViewPurchaseGrid
delete Supplier
select * from Supplier
insert into Supplier values ('XYZ',123, 0312, 'ABC')
