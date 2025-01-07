-- 1 
	select Departments.Dnum , departments.Dname , MGRSSN , concat(Employee.Fname ,' ', Employee.Lname ) as name
	from Employee 
	inner join Departments on Employee.SSN = Departments.MGRSSN
	
-- 2 

select Departments.Dname , Project.Pname 
from Departments 
inner join Project on Departments.Dnum = Project.Dnum

-- 3 
select Dependent.* , concat(Fname, ' ' , Lname) as name 
from Employee 
inner join Dependent on Dependent.ESSN = Employee.SSN

--4 
select Project.Pnumber , Project.Pname , Project.Plocation 
from project 
where city in('cairo' , 'alex')


--5 
select Project.* 
from Project
where Project.Pname like 'a%'

--6 
select concat(Employee.Fname, ' ' , Employee.Lname) as name , Employee.Salary , Departments.Dnum as Department_Number 
from Employee 
inner join Departments on Employee.Dno = Departments.Dnum
where employee.Dno=30 and Salary between 1000 and 2000 

--7 
select concat(Employee.Fname, ' ' , Employee.Lname) as name , Departments.Dnum as Department_Number, Works_for.Hours
from Employee
inner join Departments on Employee.Dno = Departments.Dnum
inner join Works_for on Works_for.ESSn = Employee.SSN
inner join Project on Works_for.Pno = Project.Pnumber
where Works_for.hours >= 10  and Departments.Dnum = 10 and Project.Pname = 'AL Rabwah'

--8 
select concat(e.Fname, ' ' , e.Lname) as name , concat(s.Fname, ' ' , s.Lname) as supervisor
FROM Employee e 
join Employee s on e.Superssn = s.ssn 
where s.Fname='Kamel' and s.Lname = 'Mohamed'

--9 
select concat(e.Fname, ' ' , e.Lname) as name , p.Pname as project
from Employee e
inner join Works_for w on w.ESSn = e.SSN
inner join Project p on w.Pno = p.Pnumber
order by p.Pname

-- 10 
select Project.Pname , Departments.Dname , Employee.Lname as manager , Employee.Address , Employee.Bdate
from Project 
inner join Departments on Project.Dnum = Departments.Dnum 
inner join Employee on Employee.SSN = Departments.MGRSSN 
where Project.City = 'Cairo'

-- 11 
select distinct s.*
FROM Employee e 
join Employee s on e.Superssn = s.ssn 

-- 12
select e.* , d.* 
from Employee e 
left join Dependent d on d.ESSN = e.SSN

-- 13
insert into Employee (Fname , Lname , SSN , Bdate , Address , Sex , Salary , Superssn , Dno)
	values ('Medhat' , 'Sobhy' , 102672 , '2001-1-27' , 'Zagazig' , 'M' , 3000 , 112233 , 30)

-- 14 
insert into Employee (Fname , Lname , SSN , Bdate , Address , Sex ,Dno)
	values ('Niccolo' , 'Machiavelli' , 102660 , '2001-1-27' , 'Zagazig' , 'M' , 30)


-- 15 
update Employee
set salary = salary * 1.2 
where SSN = 102672










