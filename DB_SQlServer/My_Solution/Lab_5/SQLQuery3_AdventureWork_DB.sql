-- 1 
select soh.SalesOrderID , soh.ShipDate
from Sales.SalesOrderHeader soh
where soh.ShipDate between '7/28/2002' and '7/29/2014'

-- 2
select pp.ProductID , pp.Name
from Production.Product pp
where pp.StandardCost < 110

-- 3 
select pp.ProductID , pp.Name
from Production.Product pp 
where pp.Weight is null

-- 4
select pp.Name , pp.Color
from Production.Product pp 
where pp.Color in ('Silver' , 'Black' , 'Red')

-- 5 
select pp.Name
from Production.Product pp 
where pp.Name like 'B%'

-- 6 
UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3

select pp.Description
from Production.ProductDescription pp
where pp.Description like '%[_]%'

-- 7
select sum(soh.TotalDue) as [Total_Due/Date]
from Sales.SalesOrderHeader soh
where soh.OrderDate between '7/1/2001' and '7/31/2014'
group by soh.OrderDate 

-- 8 
select distinct hre.HireDate as [Hire Date]
from HumanResources.Employee hre

-- 9 
select avg(distinct pp.ListPrice) as [Average list price]
from Production.Product pp 

-- 10 
select concat('The ', pp.Name,' is ', 'only ',pp.ListPrice) 
from Production.Product pp 
where pp.ListPrice between 100 and 120 
order by pp.ListPrice desc

-- 11 (a)
--- transferring the data 

-- creating the table and transferring the data
select ss.rowguid, ss.Name, ss.SalesPersonID, ss.Demographics
into store_Archive
from Sales.Store ss;

-- showing the number of rows transferred
select count(store_Archive.Name) as [Number Of Rows]
from store_Archive

drop table store_Archive

-- 11(b)

SELECT rowguid, Name, SalesPersonID, Demographics
INTO store_Archive
FROM Sales.Store
WHERE 1 = 0;

select count(store_Archive.Name) as [Number Of Rows]
from store_Archive


-- 12 

select convert(varchar, getdate(), 1) 
union
select convert(varchar, getdate(), 3) 
union
select convert(varchar, getdate(), 10) 
union
select convert(varchar, getdate(), 11) 
union
select format(getdate(), 'yyyy-MM-dd') 
union
select format(getdate(), 'dddd, MMMM dd, yyyy') 

