use GroS_Fruits_2
go

create schema Groc_Store
go

create table Groc_Store.FruitStaging(
Fruit varchar(200),
Form varchar(200), 
RetailPrice decimal(20,8), 
RetailPriceUnit varchar(200), 
Yield decimal(20,8), 
CupEquivalentSize decimal(20,8), 
CupEquivalentUnit varchar(200), 
CupEquivalentPrice decimal(20,8),
Fruit_ID int,
Form_ID int,
RPU_ID int,
CEU_ID int
)

--drop table Groc_Store.FruitStaging;

select top 10 * from Groc_Store.FruitStaging;

create table Groc_Store.GSStaging(
Company varchar(200), 
Address_gs varchar(200), 
City varchar(200), 
State_gs varchar(200), 
ZipCode int, 
Better_Lat decimal(20,8), 
Better_Long decimal(20,8), 
SquareFeet decimal(20,8), 
Common_Name varchar(200), 
Notes varchar(200), 
PHONE varchar(200), 
FAX varchar(200), 
EMAIL varchar(200), 
WEBSITE varchar(200), 
DIG_MEMBER varchar(200), 
Data_Source_gs varchar(200), 
Centroid_X decimal(20,8), 
Centroid_Y decimal(20,8),
Company_ID int,
Zip_ID int,
City_ID int,
State_ID int,
DS_ID int,
DM_ID int
)

--drop table Groc_Store.GSStaging;
select * from Groc_Store.GSStaging --where Company_ID=123;
--select distinct top 10 ZipCode from Groc_Store.GSStaging;
--select distinct top 500 SquareFeet from Groc_Store.GSStaging;


create table Groc_Store.Form_F(
Form_ID int primary key identity(1,1) not null,
Form varchar(200)
)

create table Groc_Store.RPU_F(
RPU_ID int primary key identity(1,1) not null,
RetailPriceUnit varchar(200)
)

--UPDATE Groc_Store.FruitStaging
--SET Groc_Store.FruitStaging.RetailPriceUnit = Groc_Store.RPU_F.RetailPriceUnit
--FROM Groc_Store.FruitStaging
--INNER JOIN Groc_Store.RPU_F ON 
--Groc_Store.FruitStaging.[RetailPriceUnit] = Groc_Store.RPU_F.[RetailPriceUnit]

create table Groc_Store.CEU_F(
CEU_ID int primary key identity(1,1) not null,
CupEquivalentUnit varchar(200)
)

create table Groc_Store.Fruit_F(
Fruit_ID int primary key identity(1,1) not null,
Fruit varchar(200),
Form_ID int,
RPU_ID int,
CEU_ID int,
foreign key (RPU_ID) references Groc_Store.RPU_F(RPU_ID),
foreign key (CEU_ID) references Groc_Store.CEU_F(CEU_ID),
foreign key (Form_ID) references Groc_Store.Form_F(Form_ID)
)

create table Groc_Store.Fruit_Fact(
F_ID int primary key identity(1,1) not null,
RetailPrice decimal(20,8),
Yield decimal(20,8),
CupEquivalentSize decimal(20,8),
CupEquivalentPrice decimal(20,8),
Fruit_ID int,
foreign key(Fruit_ID) references Groc_Store.Fruit_F(Fruit_ID)
)



---------Grocery Store Tables---------

create table Groc_Store.State_GS(
State_ID int primary key identity(1,1) not null,
State_gs varchar(200)
)

create table Groc_Store.City_GS(
City_ID int primary key identity(1,1) not null,
City varchar(200),
State_ID int,
foreign key(State_ID) references Groc_Store.State_GS(State_ID)
)

create table Groc_Store.Zip_GS(
Zip_ID int primary key identity(1,1) not null,
ZipCode int,
City_ID int,
foreign key(City_ID) references Groc_Store.City_GS(City_ID)
)

create table Groc_Store.DataSource_GS(
DS_ID int primary key identity(1,1) not null,
Data_Source_gs varchar(200)
)

create table Groc_Store.DigMember_GS(
DM_ID int primary key identity(1,1) not null,
DIG_MEMBER varchar(200)
)

create table Groc_Store.Company_GS(
Company_ID int primary key identity(1,1) not null,
Company varchar(200),
Address_gs varchar(200),
Better_Lat decimal(20,8),
Better_Long decimal(20,8),
Common_Name varchar(200),
Notes varchar(200),
PHONE varchar(200),
FAX varchar(200),
EMAIL varchar(200),
WEBSITE varchar(200),
Centroid_X decimal(20,8),
Centroid_Y decimal(20,8),
Zip_ID int,
DS_ID int,
DM_ID int,
foreign key (Zip_ID) references Groc_Store.Zip_GS(Zip_ID),
--foreign key (City_ID) references grocery_store.State_GS(State_ID),
foreign key (DS_ID) references Groc_Store.DataSource_GS(DS_ID),
foreign key (DM_ID) references Groc_Store.DigMember_GS(DM_ID)
)

create table Groc_Store.GS_Fact(
GS_ID int primary key identity(1,1) not null,
SquareFeet decimal(20,8),
Company_ID int,
foreign key (Company_ID) references Groc_Store.Company_GS(Company_ID)
)

---------Inventory Fact---------

create table Groc_Store.Inventory_Fact(
Inv_ID int primary key identity(1,1) not null,
Company_ID int not null,
Fruit_ID int not null,
Units_Sold int,
Foreign key (Company_ID) references Groc_Store.Company_GS(Company_ID),
Foreign key (Fruit_ID) references Groc_Store.Fruit_F(Fruit_ID)
)
   
--drop table grocery_store.Inventory_Fact

select * from Groc_Store.Inventory_Fact;

select * from Groc_Store.Company_GS

select
C.Company,cy.City,C.PHONE,f.Fruit,fm.Form,ff.RetailPrice,I.Units_Sold,(ff.RetailPrice*I.Units_Sold) as Profit
from Groc_Store.Inventory_Fact as I inner join Groc_Store.Company_GS as C on I.Company_ID = C.Company_ID inner join Groc_Store.Zip_GS as Z on C.Zip_ID = Z.Zip_ID
inner join Groc_Store.City_GS as cy on z.City_ID = cy.City_ID inner join Groc_Store.Fruit_F as f on I.Fruit_ID=f.Fruit_ID inner join
Groc_Store.Form_F as fm on f.Form_ID = fm.Form_ID inner join Groc_Store.Fruit_Fact as ff on ff.Fruit_ID = I.Fruit_ID order by Profit desc;

select 
C.Company,GSF.SquareFeet
from Groc_Store.Company_GS as C inner join Groc_Store.GS_Fact as GSF on C.Company_ID = GSF.Company_ID where GSF.SquareFeet > 5000 and C.Company like 'S%' order by GSF.SquareFeet desc;

--where I.Units_Sold > 5 order by I.Units_Sold desc

create table SQFT(
SquareFeet decimal(20,8)
)
select * from SQFT
--drop table SQFT