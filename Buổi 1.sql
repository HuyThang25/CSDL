--DDL
CREATE DATABASE HANGKHONG
USE HANGKHONG
DROP DATABASE HANGKHONG

CREATE TABLE CHUYENBAY
(
	MaCB char(5) not null,
	GaDi varchar(50),
	DoDai int,
	GioDi time,
	GioDen time,
	ChiPhi int
)

CREATE TABLE MAYBAY
(
	MaMB int not null,
	Hieu varchar(50),
	TamBay int
)

CREATE TABLE  NHANVIEN 
(
	MaNV char(9) not null,
	Ten varchar(50),
	Luong int
)

CREATE TABLE CHUNGNHAN 
(
	MaNV char(9) not null,
	MaMB int not null
)

ALTER TABLE CHUYENBAY
	ADD CONSTRAINT PK_CHUYENBAY
	PRIMARY KEY (MaCB)
ALTER TABLE MAYBAY
	ADD CONSTRAINT PK_MAYBAY
	PRIMARY KEY (MaMB)
ALTER TABLE NHANVIEN
	ADD CONSTRAINT PK_NHANVIEN
	PRIMARY KEY (MaNV)
ALTER TABLE CHUNGNHAN
	ADD CONSTRAINT PK_CHUNGNHAN
	PRIMARY KEY (MaNV, MaMB)

ALTER TABLE CHUNGNHAN
	ADD CONSTRAINT FK_CHUNGNHAN_ref_MAYBAY
	FOREIGN KEY (MaMB)
	REFERENCES MAYBAY(MaMB)
ALTER TABLE CHUNGNHAN
	ADD CONSTRAINT FK_CHUNGNHAN_ref_NHANVIEN
	FOREIGN KEY (MaNV)
	REFERENCES NHANVIEN(MaNV)

--DML
SELECT * FROM NHANVIEN
