-- open database db2208_A0
use db2208_a0
go

-- xem/lietke/truy van danh sach tat ca sinh vien
select * from tbStudent

/* truy van du lieu voi cac vi tu LIKE, IN, BETWEEN */
-- tim cac sinh vien co ho 'vo' : ap dung vi tu (predicate) LIKE
select * from tbStudent where st_name LIKE 'vo%'

-- tim cac sinh vien co tem dem la 'van'
select * from tbStudent where st_name LIKE '% van %'

-- tim cac sinh vien co ten chu la 'T'
select * from tbStudent where st_name LIKE '% t%'

-- tim cac sv sinh nam 2000-2003: ao dung vi tu BETWEEN ... AND ...
select * from tbStudent where YEAR(dob) BETWEEN 2000 AND 2003

-- tim cac sv thuoc nhom cua leader co ma so 'S01' va 'S07'
select * from tbStudent where leader_id IN ('S01','S07') OR st_id IN ('S01','S07')
GO

SELECT * FROM tbstudent
-- in ra ds sv 18 tuoi: ap dung cach khai bao bien
declare @year18 INT
set @year18 = YEAR( GETDATE()) - 18

select * from tbstudent where YEAR(dob) = @year18
go

-- in ds sv 18 tuoi, voi cot gioi tinh mang gia tri hoac 'nam' hoac 'nu'
select * from tbStudent 
	where DATEDIFF(yy, dob, GETDATE()) = 18

select st_id [ma so], st_name [ho ten],
        CASE
            WHEN gender = 1 THEN 'nam'
            else 'nu'
        end [gioi tinh],
        dob [sinh nhat]
    from tbstudent
    where DATEDIFF(yy, dob, GETDATE()) = 18

-- in ra ds sinh vien co ngay sinh nhat trong thang hien tai
select * from tbstudent 
	where MONTH(dob) = MONTH(GETDATE())