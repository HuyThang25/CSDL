CREATE DATABASE CustomerProductLab
USE CustomerProductLab

CREATE TABLE Customer
(
	CustomerID int not null,
	Name varchar(30),
	Birth datetime,
	Gender bit
)
CREATE TABLE Product
(
	ProductID int not null,
	Name varchar(30),
	Pdesc text,
	Pimage varchar(200),
	PStatus bit
)
CREATE TABLE Comment
(
	ComID int identity(1,1) not null,
	ProductID int,
	CustomerID int,
	Date datetime,
	Title varchar(20),
	Content text,
	Status bit
)

ALTER TABLE Customer
	ADD CONSTRAINT PK_Customer
	PRIMARY KEY (CustomerID)
ALTER TABLE Product
	ADD CONSTRAINT PK_Product
	PRIMARY KEY (ProductID)
ALTER TABLE Comment
	ADD CONSTRAINT PK_Comment
	PRIMARY KEY (ComID)

ALTER TABLE Comment
	ADD CONSTRAINT Default_Comment
	DEFAULT GETDATE() FOR Date
ALTER TABLE Comment
	ADD CONSTRAINT FK_Comment_ref_Product
	FOREIGN KEY (ProductID)
	REFERENCES Product(ProductID)
ALTER TABLE Comment
	ADD CONSTRAINT FK_Comment_ref_Customer
	FOREIGN KEY (CustomerID)
	REFERENCES Customer(CustomerID)
ALTER TABLE Product
	ADD CONSTRAINT Unique_Pimage
	UNIQUE (Pimage)

INSERT INTO Customer VALUES
	(1, 'Jonny Owen', '1980-10-10', 1),
	(2, 'Christine Tiny', '1989-03-10', 0),
	(3, 'Garry Kelley', '1990-03-16', Null),
	(4, 'Tammy Beckham', '1980-05-17', 0),
	(5, 'David Phantom', '1987-12-30', 1)
INSERT INTO Product VALUES
	(1, 'Nokia N90', 'Mobile Nokia', 'image1.jpg', 1),
	(2, 'HP DV6000', 'Laptop', 'image2.jpg', NULL),
	(3, 'HP DV2000', 'Laptop', 'image3.jgp', 1),
	(4, 'Samsung G488', 'Mobile Samsung', 'image4.jpg', 0),
	(5, 'LCD Plasma', 'TV LCD', 'image5.jpg', 0)
INSERT INTO Comment VALUES 
	( 1, 1, '2009-03-15', 'Hot product', null, 1),
	( 2, 2, '2009-03-14', 'Hot price', 'Very much', 0),
	( 3, 2, '2009-03-20', 'Cheapest', 'Unlimited', 0),
	( 4, 2, '2009-04-13', 'Sale off', '50%', 1)

--2. Hiện thi những sản phẩm có PStatus là null hoặc 0
select * from Product
where (PStatus is null) or (PStatus=0)
--3. Hiển thị những sản phẩm không có bình luận nào
select Product.* 
from Product  left join Comment on Product.ProductID = Comment.ProductID
where Comment.ProductID is null
--4. Hiện thị những Khách có nhiều bình luận nhất
select Name as 'Customer Name', COUNT(Customer.CustomerID)
from Customer join  Comment on Customer.CustomerID = Comment.CustomerID
group by Customer.CustomerID, Name
having COUNT(Customer.CustomerID) =	(
										select top(1) COUNT(Customer.CustomerID)
										from Customer join  Comment on Customer.CustomerID = Comment.CustomerID
										group by Customer.CustomerID 
										order by COUNT(Customer.CustomerID) desc
									)

CREATE VIEW vwFull_Information
as
	select ComID, Customer.Name as 'Customer Name', Product.Name as 'Product Name', Date, Title, Content, Status 
	from Comment	join Customer on Comment.CustomerID = Customer.CustomerID
					join Product on  Comment.ProductID = Product.ProductID
with check option
--6. Tạo view có tên 'vwCustomerList' để liệt kê thông tin của tất cả các Khách hàng (Cột Status điền 'Young' nếu tuổi của Khách nhỏ hơn 20, ngược lại điền 'Old')
CREATE VIEW vwCustomerList
as
	select	CustomerID, Name as 'Costumer Name', YEAR(GETDATE())-YEAR(Birth) as 'Customer Age',
			case
				when YEAR(GETDATE())-YEAR(Birth) < 20 then 'Young'
				else 'Old'
			end as 'Status'
	from Customer
with check option
--7. Sửa view 'vwCustomerList' để nó chỉ chứa các cột CustomerID, Customer Name, Birthm Gender của bảng Customer và tạo chỉ mục (index) có tên ixCustomerName tên cột [Customer Name] của view này
ALTER VIEW vwCustomerList 
as
	select CustomerID,Name as 'Customer Name', Birth, Gender
	from Customer
CREATE INDEX ixCustomerName
ON Customer(Name)


