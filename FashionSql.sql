use Bhavnacorp

--You have to create project for fashion brands. 
--One person can endorse more than one brands you have to create 3 tables one for brand, 2nd for celebrity and 3rd for brand endorsement.
--You have to fill atleast 10 records in each table and you have to find output brands not endorced by celebrity,
--common brands endorced by celebrity, brands not endorced by celebritywith stored procedures

create table brand(brandid int identity(1,1),brandname nvarchar(30) primary key,brandqty int,price int);
create table celebrity(cid int ,cname nvarchar(30) primary key,phonenum int,gender nvarchar(10));
create table brandEndorsement(bid int primary key,celebrityname nvarchar(30) Foreign Key REFERENCES celebrity(cname))
alter table brandEndorsement add bname nvarchar(30) foreign key references brand(brandname)

-----------------------------
--grouping by brand
alter procedure sp_groupbybname
as
begin
  select bname,count(celebrityname) from brandEndorsement group by bname
end

exec sp_groupbybname

--------------------------------
alter procedure sp_getbranddetails
as
begin
  select c.cname,b.brandname,b.brandqty,b.price from brand as b full join celebrity as c on b.brandid = c.cid
    select count(e.celebrityname),b.brandname from brand as b inner join brandEndorsement as e on b.brandid = e.bid group by b.brandname
end

exec sp_getbranddetails
------------------------------
create procedure sp_usingjoin
as
begin
  select c.*,b.* from brand as b full join celebrity as c on b.brandid = c.cid
end

exec sp_usingjoin

------------------------------
--insertion sp for all tables
--brandendorsement
create procedure sp_InsertbrandEndorsement
(
 @bid int,
 @celebrityname nvarchar(30),
 @bname nvarchar(30)
)
as 
begin
   insert into brandEndorsement(bid,celebrityname,bname) values (@bid,@celebrityname,@bname)
end

exec sp_InsertbrandEndorsement @bid=6,@celebrityname='Mahesh',@bname='Bata'
exec sp_InsertbrandEndorsement @bid=7,@celebrityname='Arjun',@bname='Asian paints'
exec sp_InsertbrandEndorsement @bid=8,@celebrityname='Nani',@bname='Axe'
exec sp_InsertbrandEndorsement @bid=9,@celebrityname='Rajnikanth',@bname='Furniture'
exec sp_InsertbrandEndorsement @bid=10,@celebrityname='Ranveer',@bname='Bata'
----------------
--celebrity table insertion
-------------------
create procedure sp_Insertcelebrity
(
 @cid int,
 @cname nvarchar(30),
@phonenum int,
@gender nvarchar(10)
)
as 
begin
   insert into celebrity(cid,cname,phonenum,gender) values (@cid,@cname,@phonenum,@gender)
end

exec sp_Insertcelebrity @cid=1,@cname='Sharukh',@phonenum=5465775,@gender='male'
exec sp_Insertcelebrity @cid=2,@cname='Deepika',@phonenum=56757686,@gender='female'
exec sp_Insertcelebrity @cid=3,@cname='Taehyung',@phonenum=928764,@gender='male'
exec sp_Insertcelebrity @cid=4,@cname='Raana',@phonenum=1232435,@gender='male'
exec sp_Insertcelebrity @cid=5,@cname='Ishwarya Rai',@phonenum=6575847,@gender='female'
exec sp_Insertcelebrity @cid=1,@cname='Mahesh',@phonenum=5465775,@gender='male'
exec sp_Insertcelebrity @cid=2,@cname='Arjun',@phonenum=56757686,@gender='male'
exec sp_Insertcelebrity @cid=3,@cname='Nani',@phonenum=928764,@gender='male'
exec sp_Insertcelebrity @cid=4,@cname='Rajnikanth',@phonenum=1232435,@gender='male'
exec sp_Insertcelebrity @cid=5,@cname='Ranveer',@phonenum=6575847,@gender='male'

-------------------
--brand insertion
------------------

create procedure sp_Insertbrand
(
@brandname nvarchar(30),
@brandqty int,
@price int
)
as 
begin
   insert into brand(brandname,brandqty,price) values (@brandname,@brandqty,@price)
end

exec sp_Insertbrand @brandname='Bata',@brandqty=200,@price=1000
exec sp_Insertbrand @brandname='Fiama',@brandqty=100,@price=120
exec sp_Insertbrand @brandname='Axe',@brandqty=300,@price=350
exec sp_Insertbrand @brandname='Furniture',@brandqty=300,@price=20000
exec sp_Insertbrand @brandname='Asian Paints',@brandqty=400,@price=500
exec sp_Insertbrand @brandname='Lux',@brandqty=400,@price=500
exec sp_Insertbrand @brandname='Denver',@brandqty=400,@price=500
exec sp_Insertbrand @brandname='Fogg',@brandqty=400,@price=500
exec sp_Insertbrand @brandname='Facewash',@brandqty=400,@price=500
exec sp_Insertbrand @brandname='Lipstick',@brandqty=400,@price=500


----------------------------------------
--get all tables sp
--------------------------
alter procedure sp_getbrands
as
begin
  select * from brand order by brandid
    select * from celebrity order by cid
	    select * from brandEndorsement
end

exec sp_getbrands

