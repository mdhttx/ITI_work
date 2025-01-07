-- 1 
select count(*) as [number of students]
from Student
where Student.St_Age is not null 

-- 2 
select distinct Instructor.Ins_Name 
from Instructor

-- 3 
select isNull(s.St_Id, '-----') as [Student ID],
	   CONCAT(isNull(s.St_Fname,'-----'),' ',isNull(s.St_Lname,'-----')) as [Student Full Name],
	   isNull(d.Dept_Name,'-----') as [Department name]
from Student s 
inner join Department d on s.Dept_Id = d.Dept_Id

--- 4 
select i.Ins_Name as [Instructor Name], d.Dept_Name as [Department Name]
from Instructor i 
left join Department d on i.Dept_Id = d.Dept_Id 

-- 5 
select CONCAT(isNull(s.St_Fname,'-----'),' ',isNull(s.St_Lname,'-----')) as [Student Full Name],
	   c.Crs_Name as Course
from Student s 
inner join Stud_Course sc on sc.St_Id = s.St_Id
inner join Course c on sc.Crs_Id = c.Crs_Id
where sc.Grade is not null 

-- 6
select t.Top_Name as [Topic Name] , count(c.Crs_Id) as [Number of Courses]
from Course c
inner join Topic t on c.Top_Id = t.Top_Id 
group by t.Top_Name

-- 7 
select max(i.Salary) as [Max Salary] ,
	   min(i.Salary) as [Min Salary]
from Instructor i 
 
-- 8
select i.Ins_Name [Instructor]
from Instructor i 
where i.Salary < (select avg(Salary) from Instructor)

-- 9 
select d.Dept_Name as [Department Name]
from Department d
inner join Instructor i on d.Dept_Id = i.Dept_Id
where i.Salary = (select min(salary)  from Instructor )

-- 10 
select top 2 Instructor.Salary
from Instructor 
order by Instructor.Salary desc

-- using ranking functions 
select salary
from ( select  Instructor.Salary as salary,
	   DENSE_RANK() over (order by Instructor.Salary desc) as DR
	   from Instructor) as ranked_table
where DR <=2 

-- 11 
select i.Ins_Name as [Instructor Name], coalesce(convert(varchar(30),i.Salary), 'bonus') 
from Instructor i

-- 12
select avg(i.Salary) as [Average Salary]
from Instructor i

-- 13 
select s1.St_Fname [Student], s2.* 
from Student s1
inner join Student s2 on s1.St_super = s2.St_Id

-- 14 
select salary , department
from ( select i.salary as salary , i.dept_id as [department],
	   DENSE_RANK() over (partition by i.dept_id order by i.salary desc) as group_rank
	   from Instructor i
	   where i.Salary is not null) as ranked_table
where group_rank <= 2


-- 15
select Student_Name
from (select CONCAT(isNull(s.St_Fname,'-----'),' ',isNull(s.St_Lname,'-----')) as Student_Name ,
	  ROW_NUMBER() over (partition by s.dept_id order by newid()) as rn 
	  from Student s ) as ranked_table
where rn = 1



