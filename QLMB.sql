--DDL
CREATE DATABASE HANGKHONG
USE HANGKHONG

CREATE TABLE CHUYENBAY
(
	MaCB char(5) not null,
	GaDi varchar(50),
	GeDen varchar(50),
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
SELECT * FROM CHUYENBAY
INSERT INTO CHUYENBAY VALUES
	('VN431','SGN','CAH',3693,'05:55','06:55',236),
	('VN320','SGN','DAD',2798,'06:00','07:10',221),
	('VN464','SGN','DLI',2002,'07:20','08:05',225),
	('VN216','SGN','DIN',4170,'10:30','14:20',262),
	('VN280','SGN','HPH',11979,'06:00','08:00',1279),
	('VN254','SGN','HUI',8765,'18:40','20:00',781),
	('VN338','SGN','BVM',4081,'15:25','16:25',375),
	('VN440','SGN','BMV',2798,'18:30','19:30',426),
	('VN651','DAD','SGN',2798,'19:30','08:00',221),
	('VN276','DAD','CXR',1283,'09:00','12:00',203),
	('VN374','HAN','VII',510,'11:40','13:25',120),
	('VN375','VII','CXR',752,'14:15','16:00',181),
	('VN269','HAN','CXR',1262,'14:10','15:50',202),
	('VN315','HAN','DAD',134,'11:45','13:00',112),
	('VN317','HAN','UIH',827,'15:00','16:15',190),
	('VN741','HAN','PXU',395,'06:30','08:30',120),
	('VN474','PXU','PQC',1586,'08:40','11:20',102),
	('VN476','UIH','PQC',485,'09:15','11:50',117)
INSERT INTO MAYBAY VALUES
	(747,'Boeing 747 - 400',13488),
	(737,'Boeing 737 - 800',5413),
	(340,'Airbus A340 - 300',11392),
	(757,'Boeing 757 - 300',6416),
	(777,'Boeing 777 - 300',10306),
	(767,'Boeing 767 - 400ER',10360),
	(320,'Airbus A320',4168),
	(319,'Airbus A319',2888),
	(727,'Boeing 727',2406),
	(154,'Tupolev 154',6565)
INSERT INTO NHANVIEN VALUES 
	('242518965','Tran Van Son',120443),
	('141582651','Doan Thi Mai',178345),
	('011564812','Ton Van Quy',153972),
	('567354612','Quan Cam Ly',256481),
	('552455318','La Que',101745),
	('550156548','Nguyen Thi Cam',205187),
	('390487451','Le Van Luat',212156),
	('274878974','Mai Quoc Minh',99890),
	('254099823','Nguyen Thi Quynh',2445),
	('356187925','Nguyen Vinh Bao',44740),
	('355548984','Tran Thi Hoai An',212156),
	('310454876','Ta Van Do',212156),
	('489456522','Nguyen Thi Quy Linh',127984),
	('489221823','Bui Quoc Chinh',23980),
	('548977562','Le Van Quy',84476),
	('310454877','Tran Van Hao',33546),
	('142519864','Nguyen Thi Xuan Dao',227489),
	('269734834','Truong Tuan Anh',289950),
	('287321212','Duong Van Minh',48090),
	('552455348','Bui Thi Dung',92013),
	('248965255','TranThi Ba',43723),
	('159542516','Le Van Ky',48250),
	('348121549','Nguyen Van Thanh',32899),
	('574489457','Bui Van Lap',20)
INSERT INTO CHUNGNHAN VALUES
	('567354612',747),
	('567354612',737),
	('567354612',757),
	('567354612',777),
	('567354612',767),
	('567354612',727),
	('567354612',340),
	('552455318',737),
	('552455318',319),
	('552455318',747),
	('552455318',767),
	('390487451',340),
	('390487451',320),
	('390487451',319),
	('274878974',757),
	('274878974',767),
	('355548984',154),
	('310454876',154),
	('142519864',747),
	('142519864',757),
	('142519864',777),
	('142519864',767),
	('142519864',737)

