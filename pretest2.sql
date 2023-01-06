create database Pretest2DB
on primary 
(name='pretest2', filename='C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\pretest2.mdf', size=5, maxsize=50, filegrowth=10%),
filegroup GroupData 
(name='pretest2b', filename='C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\\pretest2b.ndf', size=10, maxsize=unlimited, filegrowth=5)
log on
(name='pretest2_log', filename='C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\pretest2_log.ldf', size=10, maxsize=unlimited, filegrowth=10%)
go

use Pretest2DB
go

create table tbFlight (
	AircraftCode nvarchar(10),
	FType nvarchar(10) check (FType in ('Boeing', 'Airbus')),
	[Source] nvarchar(20) ,
	Destination nvarchar(20),
	DepTime datetime,
	JourneyHrs int,
	primary key nonclustered (AircraftCode)
)
go

insert tbFlight values
('UA01','Boeing','Los Angeles','London','15:30',6),
('UA02','Boeing','California','New York','09:30',8),
('SA01','Boeing','Istanbul','Ankara','10:45',8),
('SA02','Airbus','London','Moscow','11:15',9),
('SQ01','Airbus','Sydney','Ankara','01:45',15),
('SQ02','Boeing','Perth','Aden','13:30',10),
('SQ03','Airbus','San Francisco','Nairobi','15:45',15)
go

create clustered index IX_Source on tbFlight([Source])
go

create index IX_Destination on tbFlight(Destination)
go

create proc uspChangeHour
@hour int output
as
begin

end
go

create trigger tgFlightInsert on tbFlight
for insert as
begin
	if (select * from inserted)
	begin
		rollback
		print 'Khong the them khach hang voi trang thai'
	end
end
go

create trigger tgFlightUpdate on tbFlight
after update as
begin
	if update(AircraftCode)
	begin
		rollback
		print 'Ko the thay doi ma chuyen bay hang khong'
	end
end
go

-- test case 1: doi ma chuyen bay hang khong tu UA02 sang SA03 : LOI !
select * from tbFlight
update tbFlight set AircraftCode='SA03' where AircraftCode='UA02'
select * from tbFlight
go