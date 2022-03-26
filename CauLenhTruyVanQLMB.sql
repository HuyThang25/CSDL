﻿USE QLMB

--1. Cho biết thông tin về các chuyến bat đi Đà Lạt (DAD)
select * from CHUYENBAY 
where GaDen like 'DAD'
--2. Cho biết thông tin về các loại máy bay có tầm bay lớn hơn 10.000 km.
select * from MAYBAY
where TamBay > 10000
--3. Cho biết thông tin về các nhân viên có lương nhỏ hơn 10000
select * from NHANVIEN
where Luong < 10000
--4. Cho biết thông tin về các chuyến bay có độ dài đường bay nhỏ hơn 10000km và lớn hơn 8000km
select * from CHUYENBAY
where DoDai between 8000 and 10000
--5. Cho biết thông tin về các chuyến bay xuất phát từ Sài Gòn (SGN) đi Ban Mê Thuột (BMV)
select * from CHUYENBAY
where (GaDi like 'SGN') and (GaDen like 'BMV')
--6. Có bao nhiêu chuyến bay xuất phát từ Sài Gòn (SGN)
select COUNT(*) as N'Số chuyến bay xuất phát từ Sài Gòn' from CHUYENBAY
where GaDi like 'SGN'
--7. Có bao nhiêu loại máy bay Boeing
select COUNT(*) as N'Số máy bay Boeing' from MAYBAY
where Hieu like 'Boeing%'
--8. Cho biết tổng số lương phải trả cho các nhân viên
select SUM(Luong) as N'Tổng số lương phải trả' from NHANVIEN
--9. Cho biết mã số và tên của các phi công lái máy bay Boeing
select distinct NHANVIEN.MaNV, Ten 
from NHANVIEN	join CHUNGNHAN on NHANVIEN.MaNV = CHUNGNHAN.MaNV
				join MAYBAY on CHUNGNHAN.MaMB = MAYBAY.MaMB
where Hieu like 'Boeing%'
--10. Cho biết mã số và tên của các phi công có thể lái được máy bay có mã số là 747
select NHANVIEN.MaNV, Ten 
from NHANVIEN	join CHUNGNHAN on NHANVIEN.MaNV = CHUNGNHAN.MaNV
where MaMB = 747
--11. Cho biết mã số của các loại máy bay mà nhân viên có họ Nguyễn có thể lái
select MaMB
from NHANVIEN	join CHUNGNHAN on NHANVIEN.MaNV = CHUNGNHAN.MaNV
where Ten like N'Nguyen%'
--12. Cho biết mã số của các phi công vừa lái được Boeing vừa lại được Airbus A320
select NHANVIEN.MaNV, Ten 
from NHANVIEN	join CHUNGNHAN on NHANVIEN.MaNV = CHUNGNHAN.MaNV
				join MAYBAY on CHUNGNHAN.MaMB = MAYBAY.MaMB
where		(Hieu like 'Boeing%')
		and 
			(NHANVIEN.MaNV in	(	
							select MaNV
							from CHUNGNHAN join MAYBAY on CHUNGNHAN.MaMB = MAYBAY.MaMB
							where Hieu like 'Airbus A320'
						)
			)
--13. Cho biết các loại máy bay có thể thực hiện được chuyến bat VN280
select * from MAYBAY
where TamBay >=	(
					select DoDai from CHUYENBAY
					where MaCB like 'VN280'
				)
--14. Cho biết các chuyến bay có thể thực hiện bởi máy bay Airbus A320
select * from CHUYENBAY 
where DoDai <=	(
					select TamBay from MAYBAY
					where Hieu like 'Airbus A320'
				)
-- 15. Cho biết tên của các phi công lái máy bay Boeing
select distinct Ten 
from NHANVIEN	join CHUNGNHAN on NHANVIEN.MaNV = CHUNGNHAN.MaNV
				join MAYBAY on CHUNGNHAN.MaMB = MAYBAY.MaMB
where Hieu like 'Boeing%'
--16. Với mỗi loại máy bay có phi công lái, cho biết mã số, loại máy bay và tổng số phi công có thể lái loại máy bay đó
select MAYBAY.MaMB, Hieu, COUNT(MAYBAY.MaMB) as N'Số phi công'
from CHUNGNHAN join MAYBAY on CHUNGNHAN.MaMB = MAYBAY. MaMB
group by MAYBAY.MaMB, Hieu
--17. Giả sử một hành khách muốn đi thẳng từ ga A đến ga B rồi quay trở về ga A. Cho biết các đường bay nào có thể đáp ứng yêu cầu này.
select * 
from CHUYENBAY as CHUYENBAYDI join CHUYENBAY as CHUYENBAYVE on CHUYENBAYDI.GaDen = CHUYENBAYVE.GaDi 
where CHUYENBAYDI.GaDi = CHUYENBAYVE.GaDen 
--18. Với mỗi ga có chuyến bay xuất phát từ đó, cho biết có bao nhiêu chuyến bay khởi hành từ ga đó
select GaDi, COUNT(GaDi) as N'Số chuyến bay' from CHUYENBAY
group by GaDi
--19. Với mỗi ga có chuyến bay xuất phát từ đó, cho biết tổng chi phí phải trả chi phi công lái các chuyến bay khởi hành từ ga đó.
select GaDi, SUM(ChiPhi) as N'Tổng chi phí các chuyến bay' from CHUYENBAY
group by GaDi
--20. Với mỗi ga xuất phát, cho biết có bao nhiêu chuyến bay có thể khởi hành trước 12:00 
select GaDi, COUNT(GaDi) as N'Số chuyến bay khởi hành trước 12h' from CHUYENBAY
where GioDi < '12:00'
group by GaDi
--21. Cho biết mã số của phi công chỉ lái được 3 loại máy bay
select MaNV from CHUNGNHAN
group by MaNV
having COUNT(MaNV)=3
--22. Với mỗi phi công có thể lái nhiều hơn 3 loại máy bay, cho biết mã số phi công và tầm bay lớn nhất của các loại máy bay mà phi công đó có thể lái

select NHANVIEN.MaNV, MAX(TamBay) as N'Tầm bay lón nhất trong các máy bay' 
from NHANVIEN	join CHUNGNHAN on NHANVIEN.MaNV = CHUNGNHAN.MaNV
				join MAYBAY on CHUNGNHAN.MaMB = MAYBAY.MaMB
where NHANVIEN.MaNV in	(
							select MaNV from CHUNGNHAN
							group by MaNV
							having COUNT(MaNV)>3
						)
group by NHANVIEN.MaNV
--23. Cho biết mã số của các phi công có thể lái được nhiều loại máy bay nhất
select MaNV from CHUNGNHAN
group by MaNV
having COUNT(MaMB) =	(
							select MAX(SoMB)
							from
								(
									select MaNV,COUNT(MaNV) as SoMB from CHUNGNHAN
									group by MaNV
								) as  BangSoLuongMB
						)
--24. Cho biết mã số của các phi công có thể lái được ít loại máy bay nhất.
select MaNV from CHUNGNHAN
group by MaNV
having COUNT(MaMB) =	(
							select MIN(SoMB)
							from
								(
									select MaNV,COUNT(MaNV) as SoMB from CHUNGNHAN
									group by MaNV
								) as  BangSoLuongMB
						)
--25. Tìm các nhân viên không phải là phi công
select NHANVIEN.*
from NHANVIEN full join CHUNGNHAN on NHANVIEN.MaNV = CHUNGNHAN.MaNV
where CHUNGNHAN.MaMB is null
--26. Cho biết mã số của các nhân viên có lương cao nhất
select * from NHANVIEN
where Luong =	(
					select MAX(Luong) from NHANVIEN
				)
--27. Cho biết tổng số lương phải trả cho các phi công
select SUM(Luong) as N'Tổng số lương phải trả cho phi công'
from NHANVIEN join CHUNGNHAN on NHANVIEN.MaNV = CHUNGNHAN.MaNV