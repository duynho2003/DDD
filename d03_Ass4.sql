--1 tao csdl StudentDB
CREATE DATABASE StudentDB
ON PRIMARY 
	(name='Student_dat', filename='C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Student_dat.mdf', size=5, filegrowth=10%, maxsize=unlimited)
	LOG ON
	(name='Student_log', filename='C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Student_log.ldf', size=2, filegrowth=1, maxsize=15)
GO

use StudentDB
GO
--2 Create a table named “tbStudents” with the following specifications:
CREATE TABLE tbStudents (
	Roll_no int identity(1,1) PRIMARY KEY,
	Fullname varchar(40) not null,
	Grade varchar(1) not null,
	Sex bit not null default 0, --0: true, 1: false
	[Address] varchar(60),
	DOB date
)
go

SET IDENTITY_INSERT tbStudents ON
go

/* nhap du lieu vo bang sinh vien: INSERT tbStudents VALUES(...) */
set dateformat DMY
insert tbStudents (Roll_no, Fullname, Grade, Sex, [Address], DOB) VALUES
('1', 'Rita', 'B',0, 'New York', '12-04-1985'),
('2', 'Beck', 'B',0, 'New York', '23-12-1985'),
('3', 'Wilson', 'B',0, 'New York', '09-04-1985'),
('4', 'Leonard', 'B',0, 'New York', '12-04-1985'),
('5', 'Julia', 'B',0, 'New York', '12-04-1985'),
('6', 'Ringo', 'B',0, 'New York', '12-04-1985'),
('7', 'Annie', 'B',0, 'New York', '12-04-1985'),
('8', 'Sandra', 'B',0, 'New York', '12-04-1985'),
('9', 'Tom', 'B',0, 'New York', '12-04-1985'),
('10', 'Susie', 'B',0, 'New York', '12-04-1985'),
('11', 'Bob', 'B',0, 'New York', '12-04-1985'),
('12', 'Rosy', 'B',0, 'New York', '12-04-1985')
select * from tbStudents
GO

--3 Create a table named “tbBatch” with the following collumns
CREATE TABLE tbBatch (
	Batch_no varchar(10) PRIMARY KEY,
	Course_name varchar(40) not null,
	[Start_date] date 
)
go
-- nhap du lieu
set dateformat DMY
insert tbBatch(Batch_no, Course_name, [Start_date]) VALUES
('F2_1401', 'ACCP 2011', '02-01-2014'),
('F2_1402', 'ACCP 2011', '01-02-2014'),
('F2_1403', 'ACCP 2013 new', '05-03-2014'),
('F3_1402', 'ACCP 2011', '02-02-2014'),
('F3_1404', 'ACCP 2013 new', '03-04-2014')
go
-- xem lai danh sanh tbBatch
Select * from tbBatch
Go

--4 Create a table named “tbRegister” with the following specification:
CREATE TABLE tbRegister (
	Batch_no varchar(10), FOREIGN KEY,
	Roll_no int not null,
	[Start_date] date 
)
go