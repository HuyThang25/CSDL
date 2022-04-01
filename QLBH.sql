CREATE DATABASE QLBH
USE QLBH

CREATE TABLE KHACHHANG
(
	MaKH char(4) not null,
	HoTen varchar(40),
	DChi varchar(50),
	SoDT varchar(20),
	NgSinh smalldatetime,
	DoanhSo money,
	NgDK smalldatetime
)
CREATE TABLE NHANVIEN
(
	MaNV char(4)not null,
	HoTen varchar(40) not null,
	SoDT varchar(20) not null,
	NgVL smalldatetime not null
)
CREATE TABLE SANPHAM
(
	MaSP char(4) not null,
	TenSP varchar(40),
	DVT varchar(20),
	NuocSX varchar(40),
	Gia money
)
CREATE TABLE HOADON
(
	SoHD int not null,
	NgHD smalldatetime,
	MaKH char(4) not null,
	MaNV char(4) not null,
	TriGia money
)
CREATE TABLE CTHD 
(
	SoHD int not null,
	MaSP char(4) not null,
	SL int
)

/*----------------------------*/
--1. Tạo các quan hệ và khai báo các khóa chính, khóa ngoại của quan hệ.
ALTER TABLE KHACHHANG
	ADD CONSTRAINT PK_KHACHHANG
	PRIMARY KEY(MaKH)
ALTER TABLE NHANVIEN
	ADD CONSTRAINT PK_NHANVIEN
	PRIMARY KEY(MaNV)
ALTER TABLE SANPHAM
	ADD CONSTRAINT PK_SANPHAM
	PRIMARY KEY(MaSP)
ALTER TABLE HOADON
	ADD CONSTRAINT PK_HOADON
	PRIMARY KEY(SoHD, MaKH, MaNV)
ALTER TABLE CTHD
	ADD CONSTRAINT PK_CTHD
	PRIMARY KEY(SoHD, MaSP)

ALTER TABLE HOADON
	ADD CONSTRAINT FK_HOADON_ref_KHACHHANG
	FOREIGN KEY (MaKH)
	REFERENCES KHACHHANG(MaKH)
ALTER TABLE HOADON
	ADD CONSTRAINT FK_HOADON_ref_NHANVIEN
	FOREIGN KEY (MaNV)
	REFERENCES NHANVIEN(MaNV)
ALTER TABLE HOADON
	ADD CONSTRAINT FK_HOADON_ref_CTHD
	FOREIGN KEY (SoHD)
	REFERENCES CTHD(SoHD)
ALTER TABLE CTHD
	ADD CONSTRAINT FK_CTHD_ref_SANPHAM
	FOREIGN KEY (MaSP)
	REFERENCES SANPHAM(MaSP)
--2. Thêm vào thuộc tính GHICHU có kiểu dữ liệu varchar(20) cho quan hệ SANPHAM.
ALTER TABLE SANPHAM
	ADD GhiChu varchar(20)
--3. Thêm vào thuộc tính LOAIKH có kiểu dữ liệu là tinyint cho quan hệ KHACHHANG.
ALTER TABLE KHACHHANG
	ADD LoaiKH tinyint
--4. Sửa kiểu dữ liệu của thuộc tính GHICHU trong quan hệ SANPHAM thành varchar(100).
ALTER TABLe SANPHAM
	ALTER COLUMN GhiChu varchar(100)
--5. Xóa thuộc tính GHICHU trong quan hệ SANPHAM.
ALTER TABLE SANPHAM
	DROP COLUMN GhiChu
--6. Làm thế nào để thuộc tính LOAIKH trong quan hệ KHACHHANG có thể lưu các giá trị là: “Vang lai”, “Thuong xuyen”, “Vip”, …
ALTER TABLE KHACHHANG
	ALTER COLUMN LoaiKH varchar(20)
--7. Đơn vị tính của sản phẩm chỉ có thể là (“cay”,”hop”,”cai”,”quyen”,”chuc”)
ALTER TABLE SANPHAM
	ADD CONSTRAINT CHECK_DVT
	CHECK (DVT like 'cay' or DVT like 'hop' or DVT like 'quyen' or DVT like 'cai' or DVT like 'chuc')
--8. Giá bán của sản phẩm từ 500 đồng trở lên.
ALTER TABLE SANPHAM
	ADD CONSTRAINT CHECK_Gia
	CHECK (Gia>=500)
--9. Mỗi lần mua hàng, khách hàng phải mua ít nhất 1 sản phẩm.
ALTER TABLE CTHD
	ADD CONSTRAINT CHECK_SL
	CHECK (SL>=1)
--10. Ngày khách hàng đăng ký là khách hàng thành viên phải lớn hơn ngày sinh của người đó. Nếu không điền thì để mặc định là ngày lúc nhập.
ALTER TABLE KHACHHANG
	ADD CONSTRAINT CHECK_NgDK
	CHECK (NgDK>NgSinh)
--11. Ngày mua hàng (NGHD) của một khách hàng thành viên sẽ lớn hơn hoặc bằng ngày khách hàng đó đăng ký thành viên (NGDK).

--12. Ngày bán hàng (NGHD) của một nhân viên phải lớn hơn hoặc bằng ngày nhân viên đó vào làm.

/*-----------------------*/ 
INSERT INTO NHANVIEN VALUES
	('NV01','Nguyen Nhu Nhut', 0927345678, '2006-04-13'),
	('NV02','Le Thi Phi yen', 0987567290, '2006-04-21'),
	('NV03','Nguyen Van B', 0997047382, '2006-04-27'),
	('NV04','Ngo Thanh Tuan', 0913758498, '2006-06-24'),
	('NV05','Nguyen Thi Thanh Truc', 0918590387, '2006-07-20')
INSERT INTO KHACHHANG VALUES 
	('KH01', 'Nguyen Van A', '731 Tran Hung Dao, Q5, TpHCM', 08823451,'1960-10-22',1306000,'2006-07-20'),
	('KH02', 'Tran Ngoc Han', '23/5 Nguyen Trai, Q5, TpHCM', 0908256478, '1974-04-03', 280000, '2006-07-30'),
	('KH03', 'Tran Ngoc Linh', '45 Nguyen Canh Chan, Q1, TpHCM', 0938776266, '1980-06-12', 3860000, '2006-08-05'),
	('KH04', 'Tran Minh Long', '50/34 Le Dai Hanh, Q10, TpHCM', 0917325476, '1965-03-09', 250000, '2006-10-02'),