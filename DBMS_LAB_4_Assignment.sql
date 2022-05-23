drop database if Exists Ecommerce;
create database Ecommerce;
use Ecommerce;

create table supplier (SUPP_ID int primary key,SUPP_NAME varchar(50) NOT NULL,SUPP_CITY varchar(50) NOT NULL,
SUPP_PHONE varchar(50) NOT NULL);

create table customer (CUS_ID int primary key,CUS_NAME varchar(20) NOT NULL,CUS_PHONE varchar(10) NOT NULL,
CUS_CITY varchar(30) NOT NULL, CUS_GENDER char);

create table category (CAT_ID int primary key,CAT_NAME varchar(20) NOT NULL);

create table product (PRO_ID int primary key,PRO_NAME varchar(20) NOT NULL DEFAULT "Dummy",PRO_DESC varchar(60),
CAT_ID int,
FOREIGN KEY(CAT_ID) REFERENCES category(CAT_ID));

create table supplier_pricing (PRICING_ID int primary key,PRO_ID int,
Foreign key(PRO_ID) REFERENCES product(PRO_ID),
SUPP_ID int,
FOREIGN KEY(SUPP_ID) REFERENCES supplier(SUPP_ID),
SUPP_PRICE int Default 0);

create table order_one (ORD_ID int primary key,ORD_AMOUNT int,ORD_DATE DATE Not null,CUS_ID int,
FOREIGN KEY(CUS_ID) REFERENCES customer(CUS_ID),
PRICING_ID int,
FOREIGN KEY(PRICING_ID) REFERENCES supplier_pricing(PRICING_ID));

create table rating (RAT_ID int primary key,ORD_ID int,
FOREIGN KEY(ORD_ID) REFERENCES order_one(ORD_ID),
RAT_RATSTARS int Not null);

insert into supplier values(1,'Rajesh Retails','Delhi','1234567890');
insert into supplier values(2,'Appario Ltd.','Mumbai','2589631470');
insert into supplier values(3,'Knome products','Banglore','9785462315');
insert into supplier values(4,'Bansal Reatils','Kochi','8975463285');
insert into supplier values(5,'Appario Ltd.','Mittal Ltd.','7898456532');

insert into customer values(1,'AAKASH','9999999999','DELHI','M');
insert into customer values(2,'AMAN','9785463215','Noida','M');
insert into customer values(3,'NEHA','9999999999','MUMBAI','F');
insert into customer values(4,'MEGHA','9994562399','KOLKATA','F'); 
insert into customer values(5,'PULKIT','7895999999','LUCKNOW','M');

insert into category values(1,'BOOKS');
insert into category values(2,'GAMES');
insert into category values(3,'GROCERIES');
insert into category values(4,'ELECTRONICS');
insert into category values(5,'CLOTHES');

insert into product values(1,'GTA V','Windows 7 and above with i5 processor and 8GB RAM',2);
insert into product values(2,'TSHIRT','SIZE-L with Black, Blue and White variations',5);
insert into product values(3,'ROG LAPTOP','Windows 10 with 15inch screen, i7 processor, 1TB SSD',4);
insert into product values(4,'OATS','Highly Nutritious from Nestle',3);
insert into product values(5,'HARRY POTTER','Best Collection of all time by J.K Rowling',1);
insert into product values(6,'MILK','1L Toned MIlk',3);
insert into product values(7,'Boat Earphones','1.5Meter long Dolby Atmos',4);
insert into product values(8,'Jeans','Stretchable Denim Jeans with various sizes and color',5);
insert into product values(9,'Project IGI','compatible with windows 7 and above',2);
insert into product values(10,'Hoodie','Black GUCCI for 13 yrs and above',5);
insert into product values(11,'Rich Dad Poor Dad','Written by RObert Kiyosaki',1);
insert into product values(12,'Train Your Brain','By Shireen Stephen',1);

insert into supplier_pricing values(1,1,2,1500);
insert into supplier_pricing values(2,3,5,30000);
insert into supplier_pricing values(3,5,1,3000);
insert into supplier_pricing values(4,2,3,2500);
insert into supplier_pricing values(5,4,1,1000);

insert into order_one values(101,1500,'2021-10-06',2,1);
insert into order_one values(102,1000,'2021-10-12',3,5);
insert into order_one values(103,30000,'2021-09-16',5,2);
insert into order_one values(104,1500,'2021-10-05',1,1);
insert into order_one values(105,3000,'2021-08-16',4,3);
insert into order_one values(106,1450,'2021-08-18',1,9); -- It will give error as no record of pricing id as 9
insert into order_one values(107,789,'2021-09-01',3,7);  -- It will give error as no record of pricing id as 7
insert into order_one values(108,780,'2021-09-07',5,6);  -- It will give error as no record of pricing id as 6
insert into order_one values(109,3000,'2021-00-10',5,3); -- Incorrect date value
insert into order_one values(110,2500,'2021-09-10',2,4);
insert into order_one values(111,1000,'2021-09-15',4,5);
insert into order_one values(112,789,'2021-09-16',4,7);  -- It will give error as no record of pricing id as 7
insert into order_one values(113,31000,'2021-09-16',1,8);-- It will give error as no record of pricing id as 8
insert into order_one values(114,1000,'2021-09-16',3,5);
insert into order_one values(115,3000,'2021-09-16',5,3);
insert into order_one values(116,99,'2021-09-17',2,14); -- It will give error as no record of pricing id as 14

insert into rating values(1,101,4);
insert into rating values(2,102,3);
insert into rating values(3,103,1);
insert into rating values(4,104,2);
insert into rating values(5,105,4);
insert into rating values(6,106,3); -- It will give error no Customer id with 106
insert into rating values(7,107,4); -- It will give error no Customer id with 107
insert into rating values(8,108,4); -- It will give error no Customer id with 108
insert into rating values(9,109,3); -- It will give error no Customer id with 109
insert into rating values(10,110,5);
insert into rating values(11,111,3);
insert into rating values(12,112,4); -- It will give error no Customer id with 112
insert into rating values(13,113,2); -- It will give error no Customer id with 113
insert into rating values(14,114,1);
insert into rating values(15,115,1);
insert into rating values(16,116,0); -- It will give error no Customer id with 116

--Display the total number of customers based on gender who have placed orders of worth at least Rs.3000

select cus_gender,count(cus_id) as COUNT from customer where CUS_ID in 
(select CUS_ID from order_one where ORD_AMOUNT >= 3000) GROUP BY cus_gender;

--Display all the orders along with product name ordered by a customer having Customer_Id=2

select p.*,o.* from order_one o,product p where p.PRO_ID in (select PRO_ID from supplier_pricing where PRICING_ID in 
(select PRICING_ID from order_one where CUS_ID =2)) and o.CUS_ID=2;

--Display the Supplier details who can supply more than one product.

select * from supplier where SUPP_ID in ( select SUPP_ID 
from supplier_pricing GROUP BY SUPP_ID HAVING count(SUPP_ID) >1 ) ;

--Find the least expensive product from each category and print the table with category id, name, 
product name and price of the product


select p.CAT_ID,p.PRO_NAME,p.PRO_DESC,s.supp_price from product p ,supplier_pricing s 
where 
p.PRO_ID = (select min(PRO_ID)from supplier_pricing where PRO_ID in (Select PRO_ID from Product where CAT_ID=1))
and p.PRO_ID=s.PRO_ID;

select p.CAT_ID,p.PRO_NAME,p.PRO_DESC,s.supp_price from product p ,supplier_pricing s 
where 
p.PRO_ID = (select min(PRO_ID)from supplier_pricing where PRO_ID in (Select PRO_ID from Product where CAT_ID=2))
and p.PRO_ID=s.PRO_ID;

select p.CAT_ID,p.PRO_NAME,p.PRO_DESC,s.supp_price from product p ,supplier_pricing s 
where 
p.PRO_ID = (select min(PRO_ID)from supplier_pricing where PRO_ID in (Select PRO_ID from Product where CAT_ID=3))
and p.PRO_ID=s.PRO_ID;

select p.CAT_ID,p.PRO_NAME,p.PRO_DESC,s.supp_price from product p ,supplier_pricing s 
where 
p.PRO_ID = (select min(PRO_ID)from supplier_pricing where PRO_ID in (Select PRO_ID from Product where CAT_ID=4))
and p.PRO_ID=s.PRO_ID;

select p.CAT_ID,p.PRO_NAME,p.PRO_DESC,s.supp_price from product p ,supplier_pricing s 
where 
p.PRO_ID = (select min(PRO_ID)from supplier_pricing where PRO_ID in (Select PRO_ID from Product where CAT_ID=5))
and p.PRO_ID=s.PRO_ID;

--Display the Id and Name of the Product ordered after “2021-10-05”.

select * from product where PRO_ID in (select PRO_ID from supplier_pricing where pricing_id in 
(select PRICING_ID from order_one o where o.ORD_DATE > '2021-10-05'));

--Display customer name and gender whose names start or end with character 'A'.
select  cus_name,cus_gender from customer where cus_name like 'A%' or cus_name like '%A';

--Create a stored procedure to display supplier id, name, rating and Type_of_Service. 
For Type_of_Service, If rating =5, print “Excellent
Service”,If rating >4 print “Good Service”, If rating >2 print “Average Service” else print “Poor Service”.	

CREATE PROCEDURE DisplaySupplier
AS
Select s.supp_id,s.supp_name,r.RAT_RATSTARS,
CASE
when r.RAT_RATSTARS > 5 then 'Excellent'
when r.RAT_RATSTARS > 4 then 'Good Service' 
when r.RAT_RATSTARS > 2 then 'Average Service'
else 'Poor Service'
end as TypeOfService 
from rating r,supplier s,supplier_pricing p where s.supp_id in(select supp_id from supplier_pricing where pricing_id in
(select pricing_id from order_one
where ord_id in(select ord_id from rating))) 
END;

EXEC DisplaySupplier;




