-- 1 
create function get_month(@date date)
returns varchar(15)
	begin 
		declare @month varchar(15)
		select @month = format(@date , 'MMMM')
		return @month 
	end

	select dbo.get_month('2024-12-21') 

-- 2 
	create function get_inbetween(@num1 int, @num2 int)
	returns @table table 
			(result int)
		as 
		begin 
		declare @counter int 
		select @counter = @num1+1
		while @counter < @num2
			begin 
				insert into @table (result)
				values (@counter)
				select @counter = @counter + 1 
			end

			return
			end
			

	select * from get_inbetween(1,10)

-- 3 
create function get_dept_name(@st_no int)
returns table 
		as 
			return 
				(
				select concat(s.St_Fname , ' ' , s.St_Lname) as [Name] ,
				d.Dept_Name as [Department Name]
				from Student s
				inner join Department d on s.Dept_Id = d.Dept_Id
				where s.St_Id = @st_no
				)

select Name , [Department Name]  from get_dept_name (1)

-- 4 
create function user_msg(@std_id int)
returns varchar(300)
		
		begin 
			declare @f_name varchar(50)
			declare @l_name varchar(50)
			declare @msg varchar(300)
			
			select @f_name = s.St_Fname , @l_name = s.St_Lname 
			from Student s
			where s.St_Id = @std_id
			
			if @f_name is null and @l_name is null	
			select @msg = 'First name & last name are null'
			
			else if @f_name is null 
			select @msg = 'first name is null'

			else if @l_name is null
			select @msg = 'last name is null'

			else 
			select @msg = 'First name & last name are not null'

			return @msg
			
			end 

	select dbo.user_msg(5)
	select dbo.user_msg(13)
	select dbo.user_msg(14)
	select dbo.user_msg(15)


-- 5 >>> Revise with the TA << 
create function get_mgr(@mgr_id int)
returns table as 
		return 
			(
				select d.Dept_Name as [Department Name],
					   i.Ins_Name as [Manager Name],
					   d.Manager_hiredate as [Hiring Date]
				from Department d
				inner join Instructor i on i.Dept_Id = d.Dept_Id 
				where @mgr_id = i.Ins_Id
			
			)

-- 6 

create function stud_inf(@format varchar(30))
returns @table table 
			(
			name varchar(50)
			)
		as 
			begin 
		-- ask the TA if is it a good practice to use begin end after each if statement 
		if @format = 'first name'
		-------------------------------
		insert into @table
		select isnull(s.St_Fname , '------') -- >  is it within the scope of the if statement? and when is not ?
		from Student s
		---------------------------------
		else if @format = 'last name'
		insert into @table
		select isnull(s.St_Lname , '------')
		from Student s
			
		else if @format = 'full name'
		insert into @table
		select concat(isnull(s.St_Fname , '------'), ' ', isnull(s.St_Lname , '------'))
		from Student s
		
		else
		insert into @table
		select 'that name does not exist'

		return
			end
			 
select * from stud_inf('full name')

-- 7 
select s.St_Id , substring(s.St_Fname, 1, len(s.St_Fname)-1) as [fname without last char]
from Student s 

--8 
delete g
from Department d 
inner join Student s on s.dept_id = d.dept_id 
inner join grades g on s.st_id = g.sid
where d.Dept_Name = 'SD' 

delete sc
from Stud_Course sc
inner join Student s on s.st_id = sc.st_id 
inner join department d on s.dept_id = d.dept_id 
where d.dept_name ='sd'


-- 9


-- Bonus Excercise 
create table organization 
(
	org_node hierarchyid not null,
	employee_name varchar(50),
	position varchar(50),
	salary bigint
)

-- Inserting data to the organization (CEO >> bunch of managers under the ceo >> employees under managers
-- CEO 
insert into organization (org_node, employee_name, position, salary)
values (HIERARCHYID::GetRoot(), 'medhat', 'ceo', 999999999999999999)

-- Managers (Childs to CEO)
declare @parent hierarchyid
select @parent = organization.org_node from organization where employee_name = 'medhat'

insert into organization (org_node, employee_name, position, salary)
values (@parent.GetDescendant(null, null), 'Bill gates', 'Manager', 500000000)


insert into organization (org_node, employee_name, position, salary)
values (@parent.GetDescendant(null, null), 'Jeff Bezos', 'Manager', 600000000)

-- employees under managers 
select @parent = organization.org_node from organization where employee_name = 'bill gates'

insert into organization (org_node, employee_name, position, salary)
values (@parent.GetDescendant(null, null), 'Sam Altman', 'AI Engineer', 6700000)

insert into organization (org_node, employee_name, position, salary)
values (@parent.GetDescendant(null, null), 'Sam Altman', 'AI Engineer', 6700000)

insert into organization (org_node, employee_name, position, salary)
values (@parent.GetDescendant(null, null), 'Lex Fridman', 'Computer Scientist', 950000)
 -- >>>> why are getroot and getdescendant case sensitive ??? ask the TA

 -- Querying >> showing the hierarchy using toString()
select org_node.ToString() AS Hierarchy, employee_name, position, salary
from organization
order by org_node;
