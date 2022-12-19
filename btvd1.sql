/* tao CSDL dbNhanvien : CREATE DATABASE */
create database dbNhanvien
go

use dbNhanvien
go

/* tao nhan vien */
create table tbNhanVien(
	nhanvien_id int,
	firstname varchar(100),
	lastname varchar(100),
	age int,
	country varchar(100)
)
go

/* nhap du lieu vo bang quyen sach */
insert tbNhanVien VALUES
(1,'John','Doe',31,'USA'),
(2,'Robert','Luna',22,'USA'),
(3,'David','Robinson',22,'UK'),
(4,'John','Reinhardt',25,'UK'),
(5,'Betty','Doe',28,'UAE')
go

/* xem lai ds nhan vien */
select * from tbNhanVien

/* Xoa bang nhan vien */
drop table tbNhanVien