--Question 1
--Answer
create table if not exists `supplier`(
`SUPP_ID` int primary key,
`SUPP_NAME` varchar(50) ,
`SUPP_CITY` varchar(50),
`SUPP_PHONE` varchar(10)
);

CREATE TABLE IF NOT EXISTS `customer` (
  `CUS_ID` INT NOT NULL,
  `CUS_NAME` VARCHAR(20) NULL DEFAULT NULL,
  `CUS_PHONE` VARCHAR(10),
  `CUS_CITY` varchar(30) ,
  `CUS_GENDER` CHAR,
  PRIMARY KEY (`CUS_ID`));
  
  
CREATE TABLE IF NOT EXISTS `category` (
  `CAT_ID` INT NOT NULL,
  `CAT_NAME` VARCHAR(20) NULL DEFAULT NULL,
 
  PRIMARY KEY (`CAT_ID`)
  );

CREATE TABLE IF NOT EXISTS `product` (
  `PRO_ID` INT NOT NULL,
  `PRO_NAME` VARCHAR(20) NULL DEFAULT NULL,
  `PRO_DESC` VARCHAR(60) NULL DEFAULT NULL,
  `CAT_ID` INT NOT NULL,
  PRIMARY KEY (`PRO_ID`),
  FOREIGN KEY (`CAT_ID`) REFERENCES category (`CAT_ID`)
  
  );

CREATE TABLE IF NOT EXISTS `product_details` (
  `PROD_ID` INT NOT NULL,
  `PRO_ID` INT NOT NULL,
  `SUPP_ID` INT NOT NULL,
  `PROD_PRICE` INT NOT NULL,
  PRIMARY KEY (`PROD_ID`),
  FOREIGN KEY (`PRO_ID`) REFERENCES product (`PRO_ID`),
  FOREIGN KEY (`SUPP_ID`) REFERENCES supplier(`SUPP_ID`)
  
  );

CREATE TABLE IF NOT EXISTS `order` (
  `ORD_ID` INT NOT NULL,
  `ORD_AMOUNT` INT NOT NULL,
  `ORD_DATE` DATE,
  `CUS_ID` INT NOT NULL,
  `PROD_ID` INT NOT NULL,
  PRIMARY KEY (`ORD_ID`),
  FOREIGN KEY (`CUS_ID`) REFERENCES customer(`CUS_ID`),
  FOREIGN KEY (`PROD_ID`) REFERENCES product_details(`PROD_ID`)
  );

CREATE TABLE IF NOT EXISTS `rating` (
  `RAT_ID` INT NOT NULL,
  `CUS_ID` INT NOT NULL,
  `SUPP_ID` INT NOT NULL,
  `RAT_RATSTARS` INT NOT NULL,
  PRIMARY KEY (`RAT_ID`),
  FOREIGN KEY (`SUPP_ID`) REFERENCES supplier (`SUPP_ID`),
  FOREIGN KEY (`CUS_ID`) REFERENCES customer(`CUS_ID`)
  );


--Question 2

--Answer : 

insert into `supplier` values(1,"Rajesh Retails","Delhi",'1234567890');
insert into `supplier` values(2,"Appario Ltd.","Mumbai",'2589631470');
insert into `supplier` values(3,"Knome products","Banglore",'9785462315');
insert into `supplier` values(4,"Bansal Retails","Kochi",'8975463285');
insert into `supplier` values(5,"Mittal Ltd.","Lucknow",'7898456532');


INSERT INTO `CUSTOMER` VALUES(1,"AAKASH",'9999999999',"DELHI",'M');
INSERT INTO `CUSTOMER` VALUES(2,"AMAN",'9785463215',"NOIDA",'M');
INSERT INTO `CUSTOMER` VALUES(3,"NEHA",'9999999999',"MUMBAI",'F');
INSERT INTO `CUSTOMER` VALUES(4,"MEGHA",'9994562399',"KOLKATA",'F');
INSERT INTO `CUSTOMER` VALUES(5,"PULKIT",'7895999999',"LUCKNOW",'M');


insert into 'category' values
(1,'BOOKS'),
(2,'GAMES'),
(3,'GROCERIES'),
(4,'ELECTRONICS'),
(5,'CLOTHES');


insert into 'product_details' values
(1,1 ,2, 1500),
(2, 3 ,5, 30000),
(3 ,5 ,1 ,3000),
(4 ,2 ,3 ,2500),
(5 ,4, 1, 1000);


insert into 'order' values
(20, 1500, 2021-10-12, 3, 5),
(25 ,30500, 2021-09-16, 5, 2),
(26 ,2000, 2021-10-05, 1, 1),
(30 ,3500, 2021-08-16, 4, 3),
(50 ,2000, 2021-10-06, 2, 1);

insert into 'rating' values
(1, 2, 2, 4),
(2, 3 ,4, 3),
(3 ,5 ,1, 5),
(4 ,1 ,3 ,2),
(5 ,4, 5, 4);

insert into 'product' values
(1,'GTA V','DFJDJFDJFDJFDJFJF', 2),
(2,'TSHIRT','DFDFJDFJDKFD', 5),
(3,'ROG LAPTOP','DFNTTNTNTERND', 4),
(4,'OATS','REURENTBTOTH', 3),
(5,'HARRY POTTER','NBEMCTHTJTH', 1);


--Question 3
--Answer
select c.cus_gender,count(*) from customer as c inner join  'order' as o
on c.cus_id=o.cus_id where o.ord_amount >=3000 group by c.cus_gender; 

--Question 4
--Answer:
select m.pro_name as ProductName from product m inner join (select p.PRO_ID from product_details p inner join 'order' o on
p.prod_id=o.prod_id where o.cus_id=2) q on m.pro_id=q.pro_id;


--Question 5
--Answer :
select * from supplier where supp_id in (select supp_id from product_details group by supp_id having count(supp_id)>1);

--Question 6
--Answer
select cat_name as CategoryName from category where cat_id in
 (select cat_id from product where pro_id in (select pro_id from product_details where prod_id in( 
select prod_id from 'order' where ord_amount in (select min(ord_amount) from 'order'))));

--Question 7
--Answer
select b.pro_id,b.pro_name from product b innner join (
select a.pro_id from product_details as a inner join
'order' as o on a.prod_id=o.prod_id where o.ord_date>'2021-10-05') q
on b.pro_id=q.pro_id;


--Question 8
--Answer
select s.supp_name as supplierName,q.supp_id as SupplierId,q.cus_id as customerId,q.rat_ratstars as Rating
from supplier s inner join (select a.cus_id,a.supp_id,a.rat_ratstars from rating as a where 3>(select count(distinct(b.rat_ratstars)) 
from rating as b where b.rat_ratstars>a.rat_ratstars)) 
as q  on s.supp_id=q.supp_id order by q.rat_ratstars desc;

--Question 9
--Answer
select * from customer where cus_name like 'A%' or cus_name like '%A';


--Question 10
--Answer
select sum(ord_amount) from 'order' inner join  customer on 'order'.cus_id=customer.cus_id and customer.cus_gender='M';

--Question 11
--Answer
select * from customer left join 'order' on
customer.cus_id='order'.cus_id;

--Question 12
--Answer
create PROCEDURE 'supplierRatings' ()
BEGIN
select supplier.supp_id,supplier.supp_name,rating.rat_ratstars,
case
when rating.rat_ratstars >4 then 'Genuine'
when rating.rat_ratstars >2 then 'Average'
else 'Not Ok'
end as verdict from rating inner join supplier on supplier.supp_id=rating.supp_id;
END
