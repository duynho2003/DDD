/* tao CSDL db2208_A0 : CREATE DATABASE */
create database db2208_A0
go

use db2208_A0
go

/* tao bang quyen sach */
create table tbQuyenSach
(
	book_code varchar(5) not null primary key,
	book_title varchar(30),
	book_author varchar(30),
	book_publisher varchar(30),
	book_version varchar(30),
	book_year int,
	book_price int
)
go

/* nhap du lieu vo bang quyen sach */
insert tbQuyenSach VALUES
('B01', 'Tieng Viet 1', 'Nguyen Du', 'Bo GD&DT', 'thu ba', 2020, 15000)

/* xem lai bang quyen sach */
select * from tbQuyenSach
go