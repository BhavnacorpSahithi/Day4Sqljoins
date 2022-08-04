use Bhavnacorp

     create table celebrity(cid int ,cname nvarchar(30) primary key,phonenum int,gender nvarchar(10));
     create table brands(ID int primary key identity(1,1),brandname nvarchar(30),brandqty int,price int);
	 create table brandsendorsement(bid int primary key,celebrityname nvarchar(30) Foreign Key REFERENCES celebrity(cname),brandsname nvarchar(30))
	 drop table brands

    select * from brands order by ID
    select * from celebrity order by cid
	select * from brandsendorsement
	select * from employee_logger


   insert into brandsendorsement(bid,celebrityname,brandsname) values (6,'Mahesh','Bata')
   insert into celebrity(cid,cname,phonenum,gender) values (14,'Abishe',65575858,'male') 
   insert into brands(brandname,brandqty,price) values ('Denver',3000,10000) 

   truncate table brandsendorsement

   update brands set price=14000 where ID=1
   update celebrity set cname='Mahesh sir' where cid=4 
   update brandsendorsement set brandsname='Denver' where bid=5 

   delete from brands where ID=1
   delete from celebrity where cid=2
   delete from brandsendorsement where bid=5

   create table employee_logger(id int primary key ,message nvarchar(30),updatedtime DateTime)

  -- Trigger for insertion of table
  create trigger BrandInsertTrigger
  on brands
  for insert
  as
  begin
  insert into employee_logger select ID,'Record inserted',GETDATE() from inserted
  end
  ----------------------
   create trigger CelebrityInsertTrigger
  on celebrity
  for insert
  as
  begin
  insert into employee_logger select cid,'Record inserted',GETDATE() from inserted
  end
  --------------------
   create trigger EndorsementInsertTrigger
  on brandsendorsement
  for insert
  as
  begin
  insert into employee_logger select bid,'Record inserted',GETDATE() from inserted
  end

  --Trigger from updation

  create trigger BrandUpdateTrigger
  on brands
  after update
  as
  begin
  insert into employee_logger select ID,'Record Updated',GETDATE() from deleted
  end

  create trigger CelebrityUpdateTrigger
  on celebrity
  after update
  as
  begin
  insert into employee_logger select cid,'Record Updated',GETDATE() from deleted
  end

  create trigger EndorsementUpdateTrigger
  on brandsendorsement
  after update
  as
  begin
  insert into employee_logger select bid,'Record Updated',GETDATE() from deleted
  end

  -------------------------------------
  --deletion for Triggers
  -----------------------------------
  create trigger BrandsDeleteTrigger
  on brands
  instead of delete
  as
  begin
  insert into employee_logger select ID,'Record deleted',GETDATE() from deleted
  end

  create trigger CelebrityUpdateTrigger
  on celebrity
  instead of delete
  as
  begin
  insert into employee_logger select cid,'Record deleted',GETDATE() from deleted
  end

drop trigger CelebrityUpdateTrigger

  create trigger EndorsementDeleteTrigger
  on brandsendorsement
  instead of delete
  as
  begin
  insert into employee_logger select bid,'Record deleted',GETDATE() from deleted
  end


  



