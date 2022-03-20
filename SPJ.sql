--     DDL
CREATE DATABASE SPJ
USE SPJ
-- Tao bang
CREATE TABLE NCC 
(
	MaNCC char(5) not null,
	Ten varchar(40) not null,
	Heso int check (Heso>=0 and Heso<=100) default  0,
	ThPho varchar(20) not null
)
CREATE TABLE VATTU
(
	MaVT char(5) not null,
	Ten varchar(40) not null,
	Mau varchar(15) not null,
	TrLuong float check (TrLuong>2.0)
)
CREATE TABLE DUAN
(
	MaDA char(5) not null,
	Ten varchar(40) not null,
	ThPho varchar(20) not null
)
CREATE TABLE CC
(
	MaNCC char(5) not null,
	MaVT char(5) not null,
	MaDA char(5) not null,
	SoLuong int default 0
)
DROP TABLE NCC
DROP TABLE VATTU
DROP TABLE DUAN
DROP TABLE CC
-- Rang buoc khoa chinh
ALTER TABLE NCC
	ADD CONSTRAINT PK_NCC
	PRIMARY KEY (MaNCC)
ALTER TABLE VATTU
	ADD CONSTRAINT PK_VATTU
	PRIMARY KEY (MaVT)
ALTER TABLE DUAN
	ADD CONSTRAINT PK_DUAN
	PRIMARY KEY (MaDA)
ALTER TABLE CC
	ADD CONSTRAINT PK_CC
	PRIMARY KEY (MaNCC, MaVT, MaDA)
-- Rang buoc khoa ngoai
ALTER TABLE CC
	ADD CONSTRAINT FK_CC_ref_NCC
	FOREIGN KEY (MaNCC)
	REFERENCES NCC(MaNCC)
ALTER TABLE CC
	ADD CONSTRAINT FK_CC_ref_VATTU
	FOREIGN KEY (MaVT)
	REFERENCES VATTU(MaVT)
ALTER TABLE CC
	ADD CONSTRAINT FK_CC_ref_DUAN
	FOREIGN KEY (MaDA)
	REFERENCES DUAN(MaDA)
-- Tao index
CREATE INDEX ID_NCC ON NCC(MaNCC)
CREATE INDEX ID_VATTU ON VATTU(MaVT)
CREATE INDEX ID_DUAN ON DUAN(MaDA)
CREATE INDEX ID_CC ON CC(MaNCC, MaVT, MaDA)

ALTER TABLE VATTU
	ADD ThPho varchar(20) not null

--DML
INSERT INTO NCC VALUES
	('S1','Son',20,'TpHCM'),
	('S2','Tran',10,'Ha Noi'),
	('S3','Bach',30,'Ha Noi'),
	('S4','Lap',20,'TpHCM'),
	('S5','Anh',30,'Da Nang')
SELECT * FROM NCC

INSERT INTO DUAN VALUES
	('J1','May phan loai','Ha Noi'),
	('J2','Man hinh','Viet Tri'),
	('J3','OCR','Da Nang'),
	('J4','Bang dieu khien','Da Nang'),
	('J5','RAID','TpHCM'),
	('J6','EDS','Hai Phong'),
	('J7','Bang tu','TpHCM')
INSERT INTO VATTU VALUES
	('P1','Dai oc','Do',12.0,'TpHCM'),
	('P2','Bu long','Xanh la',17.0,'Ha Noi'),
	('P3','Dinh vit','Xanh Duong',17.0,'Hai Phong'),
	('P4','Dinh vit','Do',14.0,'TpHCM'),
	('P5','Cam','Xanh duong',12.0,'Ha Noi'),
	('P6','Bang rang','do',19.0,'TpHCM')
INSERT INTO CC VALUES 
	('S1','P1','J1',200),
	('S1','P1','J4',700),
	('S2','P3','J1',400),
	('S2','P3','J2',200),
	('S2','P3','J3',200),
	('S2','P3','J4',500),
	('S2','P3','J5',600),
	('S2','P3','J6',400),
	('S2','P3','J7',800),
	('S2','P5','J2',100),
	('S2','P3','J1',200),
	('S3','P4','J2',500),
	('S3','P6','J3',300),
	('S4','P6','J7',300),
	('S4','P2','J2',200),
	('S5','P2','J4',100),
	('S5','P5','J5',500),
	('S5','P5','J7',100),
	('S5','P6','J2',200),
	('S5','P1','J4',100),
	('S5','P3','J4',200),
	('S5','P4','J4',800),
	('S5','P5','J4',400),
	('S5','P6','J4',500)