USE SPJ
--1. Cho biết màu và thành phố của các vật tư không được lưu trữ tại Hà nội và có trọng lượng lớn hơn 10
select Mau, ThPho from VATTU 
where (ThPho not like 'Ha Noi') and (TrLuong>10)
--2. Cho biết thông tin chi tiết về các dự án ở Tp HCM
select * from DUAN
where ThPho like 'TpHCM'
--3. Cho biết tên nhà cung cấp vật tư cho dự án J1.
select  NCC.Ten 
from DUAN	join CC on DUAN.MaDA = CC.MaDA
			 join NCC on CC.MaNCC = NCC.MaNCC
where DUAN.MaDA like 'J1'
--4. Cho biết tên nhà cung cấp, tên vật tư, tên dự án mà số  lượng vật tư được cung cấp cho dự án bởi nhà cung cấp lớn hơn 300 và nhỏ hơn 750.
select  NCC.Ten, VATTU.Ten, DUAN.Ten 
from DUAN	join CC on DUAN.MaDA = CC.MaDA
			join NCC on CC.MaNCC = NCC.MaNCC
			join VATTU on CC.MaVT = VATTU.MaVT
where (SoLuong>300) and (SoLuong<750)
--5. Cho biết mã số các vật tư được cung cấp cho các dự án tại Tp HCm bởi các nhà cung cấp ở TpHCM
select  VATTU.MaVT, VATTU.Ten, DUAN.MaDA, DUAN.Ten
from DUAN	join CC on DUAN.MaDA = CC.MaDA
			join VATTU on CC.MaVT = VATTU.MaVT
where DUAN.ThPho like 'TpHCM'
--6. Liệt kê các cặp tên thành phố mà nhà cung cấp ở thành phố thứ nhất cung cấp vật tư được lưu trữ tại thành phố thứ hai.
select distinct NCC.ThPho, VATTU.ThPho
from NCC	join CC on NCC.MaNCC = CC.MaNCC
			join VATTU on CC.MaVT = VATTU.MaVT
where VATTU.ThPho not like NCC.ThPho
--7. Liệt kê các cặp mã số nhà cung cấp ở cùng một thành phố
select NCC1.MaNCC, NCC2.MaNCC 
from NCC as NCC1 join NCC as NCC2
on (NCC1.ThPho = NCC2.ThPho) and (NCC1.MaNCC != NCC2.MaNCC)
--8. Cho biết mã số và tên các vật tư được cung cấp cho dự án cùng thành phố với nhà cung cấp.
select distinct VATTU.MaVT, VATTU.Ten
from NCC	join CC on NCC.MaNCC = CC.MaNCC
			join VATTU on CC.MaVT = VATTU.MaVT
where VATTU.ThPho like NCC.ThPho
--9. Cho biết mã số và tên các vật tư được cung cấp vật tư bởi ít nhất một nhà cung cấp không cùng thành phố.
select distinct VATTU.MaVT, VATTU.Ten 
from VATTU	join CC on VATTU.MaVT = CC.MaVT
			join NCC on CC.MaNCC = NCC.MaNCC
where VATTU.ThPho != NCC.ThPho
--10. Cho biết mã số nhà cung cấp và cặp mã số vật tư được cung cấp bởi nhà cung cấp này.

--11. Cho biết mã số các vật tư được cung cấp bởi nhiều hơn một nhà cung cấp
select VATTU.MaVT
from VATTU	join CC on VATTU.MaVT = CC.MaVT
group by VATTU.MaVT
having COUNT(MaNCC)>1
--12. Với mỗi vật tư, cho biết mã số và tổng số lượng được cung cấp cho các dự án.
select VATTU.MaVT, SUM(SoLuong)
from VATTU	join CC on VATTU.MaVT = CC.MaVT
group by VATTU.MaVT
--13. Cho biết tổng số các dự án được cung cấp vật tư bởi nhà cung cấp S1
select COUNT(*)
from DUAN	join CC on DUAN.MaDA = CC.MaDa
where MaNCC like 'S1'
--14. Cho biết tổng số lượng vật tư P1 được cung cấp bởi nhà cung cấp S1
select SUM(SoLuong) from CC
where (MaVT like 'P1') and (MaNCC like 'S1')
--15. Với mỗi vật tư được cung cấp cho một dự án, cho biết mã số, tên vật tư, tên dự án và tổng số lượng vật tư tương ứng.
select VATTU.MaVT, VATTU.Ten, DUAN.Ten, SUM(SoLuong) 
from VATTU	join CC on VATTU.MaVT = CC.MaVT
			join DUAN on CC.MaDA = DUAN.MaDA
group by VATTU.MaVT, VATTU.Ten, DUAN.Ten,DUAN.MaDA
--17. Cho biết mã số, tên các vật tư và tên dự án có số lượng vật tư trung bình cung cấp cho dự án lớn hơn 350
select VATTU.MaVT, VATTU.Ten, DUAN.Ten, AVG(SoLuong) 
from VATTU	join CC on VATTU.MaVT = CC.MaVT
			join DUAN on CC.MaDA = DUAN.MaDA
group by VATTU.MaVT, VATTU.Ten, DUAN.Ten,DUAN.MaDA
having AVG(SoLuong) >350
--18. Cho biết tên các dự án được cung cấp vật tư bởi nhà cung cấp S1
select Ten 
from DUAN	join CC on DUAN.MaDA = CC.MaDA
where MaNCC like 'S1'
--19. Cho biết màu của các vật tư được cung cấp bởi nhà cung cấp S1.
select distinct VATTU.MaVT, Ten, Mau 
from VATTU join CC on VATTU.MaVT = CC.MaVT 
where MaNCC like 'S1'
--20. Cho biết mã số và tên các vật tư được cung cấp cho một dự án bất kỳ ở TpHCM
select VATTU.MaVT, Ten 
from VATTU join CC on VATTU.MaVT = CC.MaVT
where MaDA =(
				select top(1) MaDA from DUAN
				where ThPho like 'TpHCM'
				order by NEWID()
			)
--21. Cho biết mã số và tên các dự án sử dụng vật tư có thể được cung cấp bởi nhà cung cấp S1.
select distinct MaDA from CC
where MaVT in	(
					select MaVT from CC
					where MaNCC like 'S1'
				)
--22. Cho biết mã số và tên các nhà cung cấp có cung cấp vật tư có quy cách màu đỏ
select  distinct NCC.MaNCC, NCC.Ten
from NCC	join CC on NCC.MaNCC = CC.MaNCC
			join VATTU on VATTU.MaVT = CC.MaVT
where Mau like 'do'
--23. Cho biết tên các nhà cung cấp có chỉ số xếp hạng nhỏ hơn chỉ số lớn nhất.

--24. Cho biết tên các nhà cung cấp không cung cấp vật tư P2
select distinct NCC.MaNCC, NCC.Ten
from VATTU  full join CC on VATTU.MaVT = CC.MaVT
			full join NCC on CC.MaNCC = NCC.MaNCC
where VATTU.MaVT not like 'P2'
--25. Cho biết mã số và tên các nhà cung cấp đang cung cấp vật tư P2
select distinct NCC.MaNCC, NCC.Ten
from VATTU  join CC on VATTU.MaVT = CC.MaVT
			join NCC on CC.MaNCC = NCC.MaNCC
where VATTU.MaVT like 'P2'
--26. Cho biết mã số và tên các nhà cung cấp đang cung cấp vật tư được cung cấp bởi nhà cung cấp có cung cấp vật tư với quy cách màu đỏ
select distinct NCC.MaNCC, NCC.Ten
from NCC join CC on NCC.MaNCC = CC.MaNCC
where MaVT in	(
					select distinct MaVT
					from
					(
						select distinct MaNCC 
						from VATTU join CC on VATTU.MaVT = CC.MaVT
						where Mau like 'do'
					) as NCC
					join  CC on NCC.MaNCC = CC.MaNCC 
				)
--27. Cho biết mã số và tên các nhà cung cấp có chỉ số xếp hạng cang hơn nhà cung cấp S1
--28. Cho biết mã số và tên các dự án được cung cấp vật tư P1 với số lượng vật tư trung bình lớn hơn tất cả các số lượng vật tư được cung cấp cho dự án J1
--29. Cho biết mã số và tên các nhà cung cấp cung cấp vật tư P1 cho một dự án nào đó với số lượng lớn hơn số lượng trung bình của vật tư P1 được cung cấp cho dự án đó.
--30. Cho biết mã số và tên các dự án không được cung cấp vật tư nào có quy cách màu đỏ bởi một nhà cung cấp bất kỳ ở TpHCM
--31. Cho biết mã số và tên các dự án được cung cấp toàn bộ vật tư bởi nhà cung cấp S1
--32. Cho biết tên các nhà cung cấp cung cấp tất cả các vật tư.
--33. Cho biết mã số và tên các vật tư được cung cấp cho tất cả các dự án tại TpHCM
--34. Cho biết mã số và tên các vật tư được cung cấp cho tất cả các dự án tại Tp HCM
--35. Cho biết mã số và tên cacs nhà cung cấp cung cấp cùng một vật tư cho tất cả các dự án
--36. Cho biết mã số và tên các dự án được cung cấp tất cả các vật tư có thể được cung cấp bởi nhà cung cấp S1
--37. Chi biết tất cả các thành phố mà nơi đó có ít nhất một nhà cung cấp, lưu trữ ít nhất một vật tư hoặc có ít nhất một dự án
--38. Cho biết mã số các vật tư hoặc được cung cấp bởi một nhà cung cấp ở Tp HCM hoặc cung cấp cho một dự án tại Tp HCM
--39. Liệt kê casc cặp (mã số nhà cung cấp, mã số vật tư) mà nhà cung cấp không cung cấp vật tư
--40. Liệt kê các cặp mã số nhà cung cấp có thể cung cấp cùng tất cả các loại vật tư
--41. Cho biết tên các thành phố lưu trữ nhiều hơn 5 vật tư có quy cách màu đỏ.
