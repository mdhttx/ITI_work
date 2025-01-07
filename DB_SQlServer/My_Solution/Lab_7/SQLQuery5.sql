use ITI ;
-- 1 
create view student_grade 
as
	select concat(s.St_Fname, ' ', s.St_Lname) as [Full name], c.Crs_Name as [course name]
	from student s 
	inner join Stud_Course sc on sc.St_Id = s.St_Id
	inner join Course c on c.Crs_Id = sc.Crs_Id
	where sc.Grade > 50

select * from student_grade

-- 2
create view topic_teached 
with encryption
as 
		select d.Dept_Manager as [manager name] , t.Top_Name as [topic]
		from Department d
		inner join instructor i on i.Dept_Id = d.Dept_Id
		inner join Ins_Course ic on ic.Ins_Id = i.Ins_Id
		inner join course c on c.Crs_Id = ic.Crs_Id
		inner join topic t on t.Top_Id = c.Top_Id
		where d.Dept_Manager is not null

		
		select * from topic_teached 
		drop view topic_teached
-- 3
create view inst_dept
as 
	select i.Ins_Name as [Instructor], d.Dept_Name as [Department]
	from Instructor i 
	inner join Department d on i.Dept_Id = d.Dept_Id
	where d.Dept_Name in ('SD', 'JAVA')

	select * from inst_dept

-- 4 
create view V1 
as 
	select *
	from Student s
	where s.St_Address in ('alex', 'cairo')
	with check option

	select * from V1

	update V1
	set v1.St_Address = 'Zagazig'
	where v1.St_Address = 'alex'

-- 5 
USE Company_SD

create view emp_proj
as 
	select p.Pname as [project], count(wf.ESSn) as [Number of Employees]
	from Project p 
	inner join Works_for wf on wf.Pno = p.Pnumber 
	group by p.Pname

	
	select * from emp_proj

-- 6

-- (a) --
create schema company



alter schema company transfer dbo.departments


select * from company.departments

-- (b) -- 
create schema human_resource

alter schema human_resource transfer dbo.employee

select * from human_resource.employee

-- 7 
use ITI

create clustered index index_mgr_hiredate
on department(manager_hiredate) --> couldn't create a clustered index since there's an existing pk that's clustered by default >> 
								--> clustered index needs to be dropped

-- drop index index_mgr_hiredate on department

-- 8
create unique index age_index
on student(st_age) --> couldn't create the index because a duplicate key was found (there's two rows carrying the same age) 
				   --> 

-- 9 
use Company_SD

declare c1 cursor 
for select Salary from Employee
for update
declare @salary int
open c1
fetch c1 into @salary 
while @@FETCH_STATUS = 0
	begin

	if @salary < 3000 

			begin

			update Employee
			set Salary = salary * 1.1 
			where current of c1 

			end
	else
			begin

			update Employee
			set Salary = Salary *1.2
			where current of c1

			end
		fetch c1 into @salary 

	end
close c1
deallocate c1

	select  Employee.Fname , Employee.Salary
	from Employee

-- 10
use ITI

declare c1 cursor 
for select d.Dept_Name [department name], d.Dept_Manager [Manager] from Department d
for read only 
declare @dept_name varchar(30) , @dept_manager varchar(50)
open c1 
fetch c1 into @dept_name , @dept_manager 

while @@FETCH_STATUS = 0 
		begin

		select @dept_name as [Department] , @dept_manager as [Department_Manager]
		fetch c1 into @dept_name , @dept_manager 

		end
		close c1
		deallocate c1

--- 11 

------------------------------------------------------------------------------
declare c1 cursor 
for select i.Ins_Name [Instructor Name] from Instructor i
for read only
declare @Ins_name varchar(40) , @Ins_names varchar(800)
open c1 
fetch c1 into @Ins_name

while @@FETCH_STATUS = 0
	begin 
	
	select @Ins_names = concat(@Ins_names, ', ', @Ins_name)
	if left(@Ins_names, 1) =','
		begin
			select @ins_names = substring(@ins_names, 2, len(@ins_names)-1)
		end
	fetch c1 into @ins_name

	end

	select @Ins_names as [Available Instructors]
close c1
deallocate c1

-- 12 
USE [ITI]
GO
/****** Object:  Table [dbo].[Course]    Script Date: 12/22/2024 3:47:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[Crs_Id] [int] NOT NULL,
	[Crs_Name] [nvarchar](50) NULL,
	[Crs_Duration] [int] NULL,
	[Top_Id] [int] NULL,
 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[Crs_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Stud_Course]    Script Date: 12/22/2024 3:47:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stud_Course](
	[Crs_Id] [int] NOT NULL,
	[St_Id] [int] NOT NULL,
	[Grade] [int] NULL,
 CONSTRAINT [PK_Stud_Course] PRIMARY KEY CLUSTERED 
(
	[Crs_Id] ASC,
	[St_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 12/22/2024 3:47:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[St_Id] [int] NOT NULL,
	[St_Fname] [nvarchar](50) NULL,
	[St_Lname] [nchar](10) NULL,
	[St_Address] [nvarchar](100) NULL,
	[St_Age] [int] NULL,
	[Dept_Id] [int] NULL,
	[St_super] [int] NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[St_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[student_grade]    Script Date: 12/22/2024 3:47:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[student_grade] 
as
	select concat(s.St_Fname, ' ', s.St_Lname) as [Full name], c.Crs_Name as [course name]
	from student s 
	inner join Stud_Course sc on sc.St_Id = s.St_Id
	inner join Course c on c.Crs_Id = sc.Crs_Id
	where sc.Grade > 50
GO
/****** Object:  Table [dbo].[Instructor]    Script Date: 12/22/2024 3:47:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instructor](
	[Ins_Id] [int] NOT NULL,
	[Ins_Name] [nvarchar](50) NULL,
	[Ins_Degree] [nvarchar](50) NULL,
	[Salary] [money] NULL,
	[Dept_Id] [int] NULL,
 CONSTRAINT [PK_Instructor] PRIMARY KEY CLUSTERED 
(
	[Ins_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 12/22/2024 3:47:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[Dept_Id] [int] NOT NULL,
	[Dept_Name] [nvarchar](50) NULL,
	[Dept_Desc] [nvarchar](100) NULL,
	[Dept_Location] [nvarchar](50) NULL,
	[Dept_Manager] [int] NULL,
	[Manager_hiredate] [date] NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[Dept_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[inst_dept]    Script Date: 12/22/2024 3:47:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[inst_dept]
as 
	select i.Ins_Name as [Instructor], d.Dept_Name as [Department]
	from Instructor i 
	inner join Department d on i.Dept_Id = d.Dept_Id
	where d.Dept_Name in ('SD', 'JAVA')

GO
/****** Object:  View [dbo].[V1]    Script Date: 12/22/2024 3:47:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V1] 
as 
	select *
	from Student s
	where s.St_Address in ('alex', 'cairo')
	with check option
GO
/****** Object:  Table [dbo].[grades]    Script Date: 12/22/2024 3:47:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[grades](
	[sid] [int] NOT NULL,
	[sname] [nvarchar](50) NULL,
	[grade] [int] NULL,
	[Cname] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ins_Course]    Script Date: 12/22/2024 3:47:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ins_Course](
	[Ins_Id] [int] NOT NULL,
	[Crs_Id] [int] NOT NULL,
	[Evaluation] [nvarchar](50) NULL,
 CONSTRAINT [PK_Ins_Course] PRIMARY KEY CLUSTERED 
(
	[Ins_Id] ASC,
	[Crs_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[organization]    Script Date: 12/22/2024 3:47:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[organization](
	[org_node] [hierarchyid] NOT NULL,
	[employee_name] [varchar](50) NULL,
	[position] [varchar](50) NULL,
	[salary] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Topic]    Script Date: 12/22/2024 3:47:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Topic](
	[Top_Id] [int] NOT NULL,
	[Top_Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Topic] PRIMARY KEY CLUSTERED 
(
	[Top_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_Topic] FOREIGN KEY([Top_Id])
REFERENCES [dbo].[Topic] ([Top_Id])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course_Topic]
GO
ALTER TABLE [dbo].[Department]  WITH CHECK ADD  CONSTRAINT [FK_Department_Instructor] FOREIGN KEY([Dept_Manager])
REFERENCES [dbo].[Instructor] ([Ins_Id])
GO
ALTER TABLE [dbo].[Department] CHECK CONSTRAINT [FK_Department_Instructor]
GO
ALTER TABLE [dbo].[Ins_Course]  WITH CHECK ADD  CONSTRAINT [FK_Ins_Course_Course] FOREIGN KEY([Crs_Id])
REFERENCES [dbo].[Course] ([Crs_Id])
GO
ALTER TABLE [dbo].[Ins_Course] CHECK CONSTRAINT [FK_Ins_Course_Course]
GO
ALTER TABLE [dbo].[Ins_Course]  WITH CHECK ADD  CONSTRAINT [FK_Ins_Course_Instructor] FOREIGN KEY([Ins_Id])
REFERENCES [dbo].[Instructor] ([Ins_Id])
GO
ALTER TABLE [dbo].[Ins_Course] CHECK CONSTRAINT [FK_Ins_Course_Instructor]
GO
ALTER TABLE [dbo].[Instructor]  WITH CHECK ADD  CONSTRAINT [FK_Instructor_Department] FOREIGN KEY([Dept_Id])
REFERENCES [dbo].[Department] ([Dept_Id])
GO
ALTER TABLE [dbo].[Instructor] CHECK CONSTRAINT [FK_Instructor_Department]
GO
ALTER TABLE [dbo].[Stud_Course]  WITH CHECK ADD  CONSTRAINT [FK_Stud_Course_Course] FOREIGN KEY([Crs_Id])
REFERENCES [dbo].[Course] ([Crs_Id])
GO
ALTER TABLE [dbo].[Stud_Course] CHECK CONSTRAINT [FK_Stud_Course_Course]
GO
ALTER TABLE [dbo].[Stud_Course]  WITH CHECK ADD  CONSTRAINT [FK_Stud_Course_Student] FOREIGN KEY([St_Id])
REFERENCES [dbo].[Student] ([St_Id])
GO
ALTER TABLE [dbo].[Stud_Course] CHECK CONSTRAINT [FK_Stud_Course_Student]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_Department] FOREIGN KEY([Dept_Id])
REFERENCES [dbo].[Department] ([Dept_Id])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_Department]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_Student] FOREIGN KEY([St_super])
REFERENCES [dbo].[Student] ([St_Id])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_Student]
GO
----------------------------------------------------------------------------------------------------------------
-- 13 

-- creating the two tables 
create table daily_transaction 
(
	user_id int, 
	transaction_amount int
)

create table last_transaction 
(
user_id int, 
transaction_amount int
)

-- inserting the data into the tables
insert into daily_transaction (user_id, transaction_amount)
values (1,2000),
	   (2,2000),
	   (3,1000)
		
insert into last_transaction(user_id, transaction_amount)
values (1,4000),
	   (4,2000),
	   (2,10000)
		
select * from daily_transaction
select * from last_transaction

-- merging the two tables 

merge into last_transaction as t
using daily_transaction as s
on t.[user_id] = s.[user_id]

when matched then
    update set t.[transaction_amount] = s.[transaction_amount]

when not matched by target then
    insert ([user_id], [transaction_amount])
    values (s.[user_id], s.[transaction_amount])

when not matched by source then
    delete

select * from daily_transaction
select * from last_transaction