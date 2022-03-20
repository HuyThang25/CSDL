--		DDL
CREATE DATABASE QLSV
USE QLSV

CREATE TABLE SINHVIEN
(
	MaSV int identity(1,1) not null,
	TenSV Nvarchar(30) not null,
	GioiTinh Nvarchar(4) default N'Nam' check (GioiTinh=N'Nam' or GioiTinh=N'NỮ'),
	NgaySinh Date check (NgaySinh<GETDATE()),
	Que Nvarchar(15) not null,
	Lop Nvarchar(5)
)
CREATE TABLE MONHOC
(
	MaMH int identity(1,1) not null,
	TenMH Nvarchar(20) unique,
	DVHT int check(DVHT<=9 and DVHT>=2)
)
CREATE TABLE KETQUA
(
	MaSV int not null,
	MaMH int not null,
	Diem float check (Diem<=10 and Diem>=0)
)
DROP TABLE SINHVIEN
DROP TABLE MONHOC
DROP TABLE KETQUA

ALTER TABLE SINHVIEN
	ADD CONSTRAINT PK_SINHVIEN
	PRIMARY KEY (MaSV)
ALTER TABLE MONHOC
	ADD CONSTRAINT PK_MONHOC
	PRIMARY KEY (MaMH)
ALTER TABLE KETQUA
	ADD CONSTRAINT PK_KETQUA
	PRIMARY KEY (MaSV, MaMH) 

ALTER TABLE KETQUA
	ADD CONSTRAINT FK_KETQUA_ref_SINHVIEN
	FOREIGN KEY (MaSV)
	REFERENCES SINHVIEN(MaSV)
ALTER TABLE KETQUA
	ADD CONSTRAINT FK_KETQUA_ref_MONHOC
	FOREIGN KEY (MaMH)
	REFERENCES MONHOC(MaMH)

--DML
INSERT INTO SINHVIEN VALUES
	(N'Trần Bảo Trọng',N'Nam','1995-12-14',N'Hà Giang','L02'),
	(N'Lê Thuỳ Dương',N'Nữ','1997-05-12',N'Hà Nội','L03'),
	(N'Trân Phương Thảo',N'Nam','1996-03-30',N'Quản Ninh','L01'),
	(N'Lê Trường An',N'Nam','1995-11-20',N'Ninh Bình','L04'),
	(N'Phạm Thị Hương Giang',N'Nữ','1990-02-20',N'Hòa Bình','L02'),
	(N'Tần Anh Bảo',N'Nam','1995-12-14',N'Hà Giang','L02'),
	(N'Lê Thùy Dung',N'Nữ','1997-05-12',N'Hà Nội','L03'),
	(N'Phạm Trung Tính',N'Nam','1996-03-30',N'Quảng Ninh','L01'),
	(N'Lê Hải An',N'Nam','1995-11-20',N'Ninh Bình','L04'),
	(N'Phạm Thị Giang Hương',N'Nữ','1999-02-21',N'Hòa Bình','L02'),
	(N'Đoàn Duy Thức',N'Nam','1994-04-12',N'Hà Nội','L01'),
	(N'Dương Tuấn Thông',N'Nam','1991-04-12',N'Nam Định','L03'),
	(N'Lê Thành Đạt',N'Nam','1993-04-15',N'Phú Thọ','L04'),
	(N'Nguyễn Hằng Nga',N'Nữ','1993-05-25',N'Hà Nội','L01'),
	(N'Trần Thanh Nga',N'Nữ','1994-06-20',N'Phú Thọ','L03'),
	(N'Trần Trọng Hoàng',N'Nam','1995-12-14',N'Hà Giang','L02'),
	(N'Nguyễn Mai Hoa',N'Nữ','1997-05-12',N'Hà Nội','L03'),
	(N'Lê Thúy An',N'Nam','1998-03-23',N'Hà Nội','L01')

SELECT * FROM SINHVIEN
DELETE FROM SINHVIEN
