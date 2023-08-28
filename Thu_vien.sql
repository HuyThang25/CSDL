--DDL 
CREATE DATABASE Thu_vien
USE Thu_vien

CREATE TABLE BANDOC(
	MaBD varchar(20) not null,
	HoTenBD nvarchar(40) not null,
	NgaySinh date check (ngaysinh < getdate()),
	Lop varchar(5) not null,
	QueQuan nvarchar(20) not null,
	Sdt varchar(15) not null
)

CREATE TABLE SACH(
	MaS varchar(20) not null,
	TenS nvarchar(40) not null,
	TheLoai nvarchar(20) not null,
	TacGia nvarchar(40) not null,
	NamXB int,
	NhaXB nvarchar(40),
)

CREATE TABLE PHIEUMUON(
	MaBD varchar(20) not null,
	MaS varchar(20) not null,
	NgayMuon date,
	NgayHenTra date,
	TraSach int default 0
)



ALTER TABLE PHIEUMUON 
	ADD CONSTRAINT CHECK_SO_NGAY_MUON
	CHECK (datediff(day,NgayHenTra,NgayMuon)<=5)

ALTER TABLE BANDOC
	ADD CONSTRAINT PK_BANDOC
	PRIMARY KEY (MaBD)

ALTER TABLE SACH
	ADD CONSTRAINT PK_SACH
	PRIMARY KEY (MaS)	

ALTER TABLE PHIEUMUON
	ADD CONSTRAINT PK_PHIEUMUON
	PRIMARY KEY (MaBD,MaS)

ALTER TABLE PHIEUMUON
	ADD CONSTRAINT FK_PHIEUMUON_ref_BANDOC
	FOREIGN KEY (MaBD)
	REFERENCES BANDOC(MaBD)

ALTER TABLE PHIEUMUON
	ADD CONSTRAINT FK_PHIEUMUON_ref_SACH
	FOREIGN KEY (MaS)
	REFERENCES SACH(MaS)

--DML
INSERT INTO BANDOC(MaBD,HoTenBD,NgaySinh,Lop,QueQuan,Sdt) VALUES
	('AT180401',N'Nguyễn Văn A', '2003-1-12','AT18D',N'Hà Nội','0999999991'),
	('AT180402',N'Nguyễn Thị B', '2003-2-12','AT18D',N'Hà Nội','0999999991'),
	('AT180403',N'Nguyễn Văn C', '2003-3-12','AT18D',N'Hà Nội','0999999991'),
	('AT180404',N'Nguyễn Văn D', '2003-4-12','AT18D',N'Hà Nội','0999999991'),
	('AT180405',N'Nguyễn Thành A', '2003-5-12','AT18D',N'Hà Nội','0999999991'),
	('AT180406',N'Nguyễn Ngọc A', '2003-6-12','AT18D',N'Hà Nội','0999999991'),
	('AT180407',N'Nguyễn Hoàng A', '2003-7-12','AT18D',N'Hà Nội','0999999991'),
	('AT180408',N'Nguyễn Thái A', '2003-8-12','AT18D',N'Hà Nội','0999999991'),
	('AT180409',N'Nguyễn Huy A', '2003-9-12','AT18D',N'Hà Nội','0999999991'),
	('AT1804010',N'Nguyễn Tạ A', '2003-10-12','AT18D',N'Hà Nội','0999999991'),
	('AT1804011',N'Nguyễn Thi A', '2003-11-12','AT18D',N'Hà Nội','0999999991'),
	('AT1804012',N'Nguyễn Trang A', '2003-12-12','AT18D',N'Hà Nội','0999999991'),
	('AT1804013',N'Nguyễn Minh A', '2003-1-13','AT18D',N'Hà Nội','0999999991')

INSERT INTO SACH (MaS, TenS, TheLoai, TacGia, NamXB, NhaXB) VALUES
	('S1', 'To Kill ', 'Novel', 'Harper Lee', 1960, ' & Co.'),
	('S2', '1984', 'Science Fiction', 'George Orwell', 1949, 'Secker & Warburg'),
	('S3', 'Pride and Prejudice', 'Romance', 'Jane Austen', 1813, 'Whitehall'),
	('S4', 'Great Gatsby', 'Novel', 'Scott Fitzgerald', 1925, 'Sons'),
	('S5', 'Lighthouse', 'Fiction', 'Virginia Woolf', 1927, 'Hogarth Press'),
	('S6', 'The Catcher', ' Fiction', 'J. D. Salinger', 1951, 'Little, Brown'),
	('S7', 'New World', 'Dystopian Fiction', 'Aldous Huxley', 1932, 'Chatto & Windus'),
	('S8', 'Moby-Dick', 'Adventure', 'Herman Melville', 1851, 'Harper & Brothers'),
	('S9', 'Frankenstein', 'Gothic Fiction', 'Mary Shelley', 1818, 'Lackington'),
	('S10', 'Solitude', 'Magic Realism', ' Márquez', 1967, 'Sudamericana'),
	('S11', 'Peace', 'Historical Fiction', 'Leo Tolstoy', 1869, 'Messenger'),
	('S12', 'Rings', 'Fantasy', 'J. R. R. Tolkien', 1954, 'Allen & Unwin')



INSERT INTO PHIEUMUON (MaS, NgayMuon, NgayHenTra, MaBD) VALUES
	('S1', '2023-08-01', '2023-08-02', 'AT180401'),
	('S2', '2023-08-02', '2023-08-03', 'AT180402'),
	('S3', '2023-08-03', '2023-08-04', 'AT180403'),
	('S4', '2023-08-04', '2023-08-05', 'AT180404'),
	('S5', '2023-08-05', '2023-08-06', 'AT180405'),
	('S6', '2023-08-06', '2023-08-07', 'AT180406'),
	('S7', '2023-08-07', '2023-08-08', 'AT180407'),
	('S8', '2023-08-08', '2023-08-09', 'AT180408'),
	('S9', '2023-08-09', '2023-08-10', 'AT180409'),
	('S10', '2023-08-10', '2023-08-12', 'AT1804010'),
	('S11', '2023-08-11', '2023-08-13', 'AT1804011'),
	('S12', '2023-08-12', '2023-08-14', 'AT1804012'),
	('S1', '2023-08-13', '2023-08-15', 'AT1804013')

