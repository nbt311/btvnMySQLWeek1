create database QLBH;
use QLBH;
create table Customer(cID INT auto_increment primary key, Name varchar(25), cAge tinyint );
insert into Customer(Name,CAge) values("Minh Quan",10),("Ngoc Oanh",20),("Hong Ha",50);
select * from Customer;
create table Orders(oID INT auto_increment primary key,  cID INT,
FOREIGN KEY (cID) REFERENCES Customer(cID), 
oDate DATE, 
oTotalPrice int);
insert into Orders (cID,oDate) values(1,"2006-03-21"),(2,"2006-03-23"),(1,"2006-03-16");
create table Product(pID int primary key auto_increment,pName varchar(25),pPrice int);
insert into Product(pName,pPrice) values("May Giat",3),("Tu Lanh",5),("Dieu Hoa",7),("Quat",1),("Bep Dien",2);
create table OrderDetail(oID int,
foreign key (oID) references Orders(oID),
pID int,
foreign key (pID) references Product(pID),
odQTY int );
insert into OrderDetail(oID,pID,odQTY) values
(1,1,3),
(1,3,7),
(1,4,2),
(2,1,1),
(3,1,8),
(2,5,4),
(2,3,3);
-- 2.sắp xếp theo thứ tự ngày tháng, hóa đơn mới hơn
select oID,cID,oDate,oTotalPrice from Orders 
order by oDate desc;
-- 3.Hiển thị tên và giá của các sản phẩm có giá cao nhất
select pName,pPrice from Product 
where pPrice = (select max(pPrice) from Product);
-- 4.Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách đó
select Name,pName from OrderDetail
join Orders on OrderDetail.oID = Orders.oID
join Customer on Orders.cID = Customer.cID
join Product on OrderDetail.pID = Product.pID;
-- 5.Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
select Name from Customer
left join Orders on Orders.cID = Customer.cID
where Orders.cID is null;
-- 6.Hiển thị chi tiết của từng hóa đơn
select OrderDetail.oID,Orders.oDate,OrderDetail.odQTY,Product.pName,Product.pPrice from OrderDetail
join Orders on OrderDetail.oID = Orders.oID
join Product on OrderDetail.pID = Product.pID;
-- 7.Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn 
-- (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn.
--  Giá bán của từng loại được tính = odQTY*pPrice)
select Orders.oID,Orders.oDate,sum(OrderDetail.odQTY*Product.pPrice) AS TotalPrice from OrderDetail
join Orders on OrderDetail.oID = Orders.oID
join Product on OrderDetail.pID = Product.pID
group by OrderDetail.oID;