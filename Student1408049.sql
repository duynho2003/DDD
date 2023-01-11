create database HomeCare
on primary
(name='homecare', filename='C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\homecare.mdf', size=5, maxsize=unlimited, filegrowth=1),
filegroup Regions 
(name='regions1', filename='C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\\regions1.mdf', size=10, maxsize=unlimited, filegrowth=1)
go

use HomeCare
go

create table Doctor(
	DoctorNo varchar(15) not null primary key nonclustered,
	DoctorName varchar(50),
	[Address] varchar(50),
	Email varchar(50),
	Phone varchar(15)
)
go

create table Patient
(
	PatientNo varchar(15) primary key nonclustered,
	PatientName varchar(50),
	Email varchar(50),
	Phone varchar(15),
	Gender varchar(2) check (Gender in ('F', 'M' )),
)
go

create table Schedule
(
	ScheduleID int identity primary key nonclustered,
	Doctor varchar(15) foreign key (Doctor) references Doctor (DoctorNo),
	Patient varchar(15) foreign key (Patient) references Patient (PatientNo),
	Appointment datetime,
	Status bit default 1
)
go

insert Doctor values
('D01', 'Nguyen Anh Duy', 'Hai Ba Trung', 'duynguyen03@yahoo.com', '112'),
('D02', 'Le Thi Hoa Dang', 'Tan Binh', 'hoale03@yahoo.com', '113'),
('D03', 'Le Tan Kha', 'Tan Phu', 'khale04@yahoo.com', '114'),
('D04', 'Tran Hong Duy Tu', 'Binh Tan', 'tutran03@gmail.com', '116'),
('D05', 'Nguyen Thuy', 'Hai Ba Trung', 'thuy20@yahoo.com', '118')
go

insert Patient values
('P01', 'Le Anh Duy', 'duyle@yahoo.com', '846556', 'M'),
('P02', 'Dang Tuan Kiet', 'kietdang@yahoo.com', '0903', 'M'),
('P03', 'Dang Huu Khang', 'khangdang@yahoo.com', '65665', 'M'),
('P04', 'Nguyen Quynh Huong', 'huongnguyen@gmail.com', '5454456', 'F'),
('P05', 'Le Hoang Da Ly', 'lyle@yahoo.com', '86746885', 'F')
go

set dateformat dmy
insert Schedule values
('D01', 'P01', '12-12-2022', '1'),
('D02', 'P02', '11-02-2023', '0'),
('D03', 'P03', '14-01-2023', '1'),
('D04', 'P04', '01-01-2023', '0'),
('D05', 'P05', '11-01-2023', '1')
go

create clustered index IX_Schedule on Schedule(ScheduleID)
go

create view vw_Schedule as
select p.*
	from Patient [p] join Schedule [s] on p.PatientNo = s.Patient
	where s.Status=1 and p.Gender like 'M'
go

select * from vw_Schedule
go

create proc sp_Schedule @PatientName varchar(50) as
begin
	select p.*,s.Status
	from Patient [p] join Schedule [s] on p.PatientNo=s.Patient
	where s.Status=1 and p.PatientName like '%'+@PatientName+'%'
end
go

exec sp_Schedule 'da'
go

create trigger t_Schedule on Schedule for update as
begin
	declare @status bit, @schedule int
	select @status=Status, @schedule = ScheduleID from inserted
	if @status=0
	begin
		delete from Schedule where ScheduleID like @schedule
		print'Item has been deleted'	
	end
end

--test case1
update Schedule set Status=0 where Patient like 'P05'
go

update Schedule set Status=1 where Patient like 'P03'
go

select * from Schedule
go