-- 1 
select Dependent.Dependent_name , Dependent.Sex 
from Dependent 
inner join Employee on Dependent.ESSN = Employee.SSN
where Dependent.Sex = 'F' and Employee.Sex = 'F'
UNION
select Dependent.Dependent_name , Dependent.Sex 
from Dependent 
inner join Employee on Dependent.ESSN = Employee.SSN
where Dependent.Sex = 'M' and Employee.Sex = 'M'

--2 
select Project.Pname , SUM(works_for.hours) as [total hours]
from Project 
inner join Works_for on Works_for.Pno = Project.Pnumber
group by Project.Pname

--3 
select Departments.* 
from Departments 
inner join Employee on Employee.Dno = Departments.Dnum 
where Employee.SSN = ( select min(Employee.SSN) from Employee  )

--4
select Departments.Dname, max(Employee.Salary) as max_salary ,
min(Employee.Salary) as min_salary, avg(Employee.Salary) as avg_salary

from Departments 
inner join Employee on Employee.Dno = Departments.Dnum
group by Departments.Dname

--5
select CONCAT(Employee.Fname, ' ' , Employee.Lname) as name
from Employee
left join Dependent on Dependent.ESSN = Employee.SSN
where Dependent.ESSN is null and Employee.SSN in (select Departments.MGRSSN from Departments)

--6 
select Departments.Dname , Departments.Dnum , Employee.SSN 
from Departments 
join Employee on Employee.Dno = Departments.Dnum 
where (select avg(Employee.Salary) from Employee where Employee.Dno = Departments.Dnum) < 
	  (select avg(salary) from Employee)

--7
select CONCAT(Employee.Fname, ' ' , Employee.Lname) as name , Project.Pname
from Employee 
inner join Works_for on Works_for.ESSn = Employee.SSN
inner join Project on Works_for.Pno = Project.Pnumber
order by Employee.Dno,
		 Employee.Fname,
		 Employee.Lname


--8
select salary
from Employee 
where salary in (select top 2 salary from Employee order by salary desc)	
---------
select top 2 salary from Employee order by salary desc

-- 9 
select CONCAT(Employee.Fname, ' ' , Employee.Lname) as name
from Employee
join Dependent on Dependent.ESSN = Employee.SSN
-- where CONCAT(Employee.Fname, ' ' , Employee.Lname) in (select Dependent.Dependent_name from Dependent)
where CONCAT(Employee.Fname, ' ' , Employee.Lname) = Dependent.Dependent_name

--10
select Employee.SSN , CONCAT(Employee.Fname, ' ' , Employee.Lname) as name
from Employee
where exists ( select 1 from Dependent where Dependent.ESSN = Employee.SSN)
--where Employee.SSN IN (select Dependent.ESSN from Dependent)


--11	
insert into Departments (Dname, Dnum, MGRSSN, [MGRStart Date])
values ('DEPT IT', 100, 112233, '1-11-2006')

--12 
update Departments
set MGRSSN = 968574 
where  Dnum = 100

update Departments
set MGRSSN = 102672 
where Dnum = 20

update Employee 
set Superssn = 102672
where SSN = 102660

--13
-- checking if he's a department manager and handling the data if needed
select * 
from Departments
where MGRSSN = 223344

update Departments
set MGRSSN = 102672 
where MGRSSN = 223344
---------------------------
-- checking if he has dependents and removing their data if true
select * 
from Dependent
where ESSN = 223344 

delete from Dependent
where ESSN = 223344 

--------------------------
-- checking if he's a supervisor and handling the data if needed
select * 
from Employee
where Superssn = 223344

update Employee
set Superssn = 102672
where Superssn = 223344

-------------------------------
-- removing him from any projects he's working in
select * 
from Works_for
where Works_for.ESSn = 223344

delete from Works_for
where ESSn = 223344

----------------------------------
-- deleting him from the employee table
delete from Employee
where SSN = 223344

select * from 
Employee 
where ssn = 223344

-- 14 
update Employee
set Salary = Salary * 1.3 
from Employee inner join Works_for on Works_for.ESSn = Employee.SSN
			  inner join Project on Works_for.Pno = Project.Pnumber 
where Project.Pname = 'Al Rabwah'

