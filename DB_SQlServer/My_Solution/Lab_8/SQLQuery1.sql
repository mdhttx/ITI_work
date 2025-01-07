use ITI

-- 1 
create procedure show_std_no 
as 
	begin 

	select d.Dept_Name as [Department Name] , count(s.St_Id) as [Number of Students]  
	from Department d
	left join Student s on d.Dept_Id = s.Dept_Id
	group by d.Dept_Name

	end 

	execute show_std_no

-- 2 
use Company_SD

alter schema dbo transfer company.project
alter schema dbo transfer company.departments

create procedure check_employees_no 
as 
		begin
		declare @employee_number int 

		select @employee_number = count(distinct e.SSN)
		from 	Employee e
		inner join Works_for wf on wf.ESSn = e.SSN
		inner join Project p on p.Pnumber = wf.Pno 
		where p.Pname = 'p1'

		if @employee_number >= 3 
		begin
		select 'the number of employees in the project p1 is 3 or more'
		end
		
		else
		begin
		select 'The following employees work for the project p1' , e.Fname , e.Lname
		from 	Employee e
		inner join Works_for wf on wf.ESSn = e.SSN
		inner join Project p on p.Pnumber = wf.Pno 
		where p.Pname = 'p1'
		end
		end

		execute check_employees_no

-- 3 
create procedure update_employee @old_emp_no int , @new_emp_no int, @project_no int
as
		begin
		update Works_for 
		set works_for.ESSn = @new_emp_no
		where Works_for.ESSn = @old_emp_no and Works_for.Pno = @project_no
		end
		
execute update_employee 223344, 112233 , 200

-- 4 
alter table project 
add budget int 

-- creating the audit table
create table project_audit
(
project_no	int,
user_name varchar(50),
modified_date date,
budget_old int,
budget_new int
)

create trigger audit_trg
on project 
after update
as 
	begin
		if update(budget)
		begin
		insert into project_audit (project_no, user_name, modified_date, budget_old, budget_new)
		select i.Pnumber as [Project], SUSER_NAME() as Username, GETDATE() as [Modified Date],
		d.budget as [old budget], i.budget as [new budget]
		from inserted i
		inner join deleted d on i.Pnumber = d.Pnumber
		end

	end
	
UPDATE Project
SET Budget = 545000
WHERE Pnumber = 100;

select * from project_audit

-- 5 
use ITI

create trigger prevent_insert_trg
on department
instead of insert 
as 
	begin
		select 'you can not insert a new record in this table'
	end

insert into Department (Dept_Id, Dept_Name, Dept_Desc, Dept_Location, Dept_Manager, Manager_hiredate)
values (777, 'Anime_Studio', 'animation', 'Tokyo', 1, GETDATE());


-- 6 
use Company_SD

create trigger prevent_in_march_trg
on Employee
instead of insert 
as 
	begin 
	if  format(GETDATE(),'MMMM') = 'December'
		begin 
			select 'you can not insert new record in march'
		end
	else 
		begin
			insert into Employee
			SELECT Fname, Lname, SSN, Bdate, address , Sex, Salary, Superssn, Dno
			from inserted
		end
	end

insert into Employee (Fname)
values ('Fyodor')

-- 7 
use ITI

create table student_audit 
(
server_username varchar(300),
date date,
note varchar(300)
)

create trigger student_insert_trg
on Student 
after insert 
as	
	begin
		declare @note varchar(300)
		declare @newstd_id int
		select @newstd_id = st_id from inserted

		select @note = concat(SUSER_NAME(),' inserted a new row with key = ', @newstd_id, ' in table student')

		insert into student_audit
		values (SUSER_NAME(), GETDATE(),@note)
	end

insert into Student (St_Id, St_Fname, St_Lname, St_Address, St_Age)
values (1001, 'Franz', 'Kafka', 'Prague', 22);

select * from student_audit

-- 8 
create trigger std_delete_trg
on student
instead of delete
as
		begin
		declare @note varchar(300)
		declare @std_id int

		select @std_id = St_Id from deleted

		select @note = concat('tried to delete row with key = ',@std_id)
		
		insert into student_audit
		values (SUSER_NAME(), GETDATE(), @note)
		end

		delete from student where st_id = 1

		select * from student
		select * from student