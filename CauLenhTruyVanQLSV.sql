USE QLSV
--1. Cho biết mã môn học, tên môn học,  điểm thi  tất cả các môn của sinh viên tên Thức
select MONHOC.MaMH, TenMH, Diem 
from SINHVIEN	join KETQUA on SINHVIEN.MaSV = KETQUA.MaSV
				join MONHOC ON KETQUA.MaMH = MONHOC.MaMH
where TenSV like N'%Thức'
--2. Cho biết mã môn học, tên môn và điểm thi ở những môn mà sinh viên tên Dung phải thi lại (điểm<5)
select MONHOC.MaMH, TenMH, Diem 
from SINHVIEN	join KETQUA on SINHVIEN.MaSV = KETQUA.MaSV
				join MONHOC ON KETQUA.MaMH = MONHOC.MaMH
where (TenSV like N'%Dung') and (Diem < 5)
--3. Cho biết mã sinh viên, tên những sinh viên đã thi ít nhất là 1 trong 3 môn Lý thuyết Cơ sở dữ liệu, Tin học đại cương, mạng máy tính.
select SINHVIEN.MaSV, tenSV
from SINHVIEN	join KETQUA on SINHVIEN.MaSV = KETQUA.MaSV
group by SINHVIEN.MaSV,TenSV
having COUNT(SINHVIEN.MaSV)>=1
	--cach 2
select MaSV,TenSV from SINHVIEN 
where MaSV not in   (
					select MaSV from KETQUA
					where Diem is not null
					)
--4. Cho biết mã môn học, tên môn mà sinh viên có mã số 1 chưa có điểm
select MaMH, TenMH from MONHOC 
where MaMH not in	(
						select MaMH from KETQUA
						where (MaSV=1) and (Diem is not null)
					)
--5. Cho biết điểm cao nhất môn 1 mà các sinh viên đạt được
select MAX(Diem) from KETQUA
where MaMH=1
--6. Cho biết mã sinh viên, tên những sinh viên có điểm thi môn 2 không thấp nhất khoa
select SINHVIEN.MaSV, TenSV 
from SINHVIEN join KETQUA on SINHVIEN.MaSV = KETQUA.MaSV
where	(MaMH = 2)
		and
		(Diem >	(
					select MIN(Diem) from KETQUA
					where MaMH=2
				) )
--7. Cho biết mã sinh viên và tên những sinh viên có điểm thi môn 1 lớn hơn điểm thi môn 1 của sinh viên có mã số 3
select SINHVIEN.MaSV, TenSV 
from SINHVIEN join KETQUA on SINHVIEN.MaSV = KETQUA.MaSV
where	(MaMH = 1)
		and
		(Diem >	(
					select Diem from KETQUA
					where (MaMH = 1) and (MaSV = 3)
				) )
--8. Cho biết số sinh viên phải thi lại môn Toán Cao cấp 
select SINHVIEN.MaSV, TenSV 
from SINHVIEN	join KETQUA on SINHVIEN.MaSV = KETQUA.MaSV
				join MONHOC ON KETQUA.MaMH = MONHOC.MaMH
where	(Diem < 4) and (TenMH like N'Toán cao cấp')
--9. Đối với mỗi môn, cho biết tên môn và số sinh viên phải thi lại môn đó mà số sinh viên thi lại >=2
select TenMH, COUNT(TenMH) as N'Số sinh viên thi lại'  from KETQUA join MONHOC on KETQUA.MaMH = MONHOC.MaMH 
where Diem < 4
group by TenMH
having COUNT(TenMH) >=2
--10. Cho biết mã sinh viên, tên và lớp của sinh viên đạt điểm cao nhất môn Tin đại cương
select SINHVIEN.MaSV, TenSV 
from SINHVIEN	join KETQUA on SINHVIEN.MaSV = KETQUA.MaSV
where Diem =	(
					select MAX(Diem) 
					from KETQUA join MONHOC on KETQUA.MaMH = MONHOC.MaMH
					where (TenMH like N'Tin đại cương')
				)
--11. Đối với mỗi lớp, lập bảng điểm gồm mã sinh viên, tên sinh viên và điểm trung bình chung học tập. 
select Lop,SINHVIEN.MaSV,TenSV, AVG(Diem) as N'Điểm trung bình' 
from SINHVIEN join KETQUA on SINHVIEN.MaSV = KETQUA.MaSV
group by SINHVIEN.MaSV,TenSV,Lop
order by Lop,SINHVIEN.MaSV
--12. Đối với mỗi lớp, cho biết mã sinh viên và tên những sinh viên phải thi lại từ 2 môn trở lên
select Lop,SINHVIEN.MaSV,TenSV
from SINHVIEN 
where MaSV in	(
					select MaSV from KETQUA 
					where (Diem <4) or (Diem is null)
					group by MaSV
					having COUNT(MaSV)>=2
				)
order by Lop,SINHVIEN.MaSV
	--cach 2
select Lop,SINHVIEN.MaSV,TenSV
from SINHVIEN join KETQUA on SINHVIEN.MaSV = KETQUA.MaSV
where (Diem <4)
group by SINHVIEN.MaSV,TenSV,Lop
having COUNT(SINHVIEN.MaSV)>=2
order by Lop,SINHVIEN.MaSV
	--danh sach hoc lai tu 2 mon tro len
select Lop,SINHVIEN.MaSV,TenSV
from SINHVIEN
where MaSV not in	(
						select SINHVIEN.MaSV
						from SINHVIEN full join KETQUA on SINHVIEN.MaSV = KETQUA.MaSV
						where (Diem>4)
						group by SINHVIEN.MaSV
						having COUNT(SINHVIEN.MaSV)>=2
					)
order by Lop,SINHVIEN.MaSV
--13. Cho biết mã số và tên của những sinh viên tham gia thi tất cả các môn.
select SINHVIEN.MaSV, TenSV
from SINHVIEN join KETQUA on SINHVIEN.MaSV = KETQUA.MaSV
where (Diem is not null)
group by SINHVIEN.MaSV, TenSV
having COUNT(SINHVIEN.MaSV)= (select COUNT(*) from MONHOC)
--14. Cho biết mã sinh viên và tên của sinh viên có điểm trung bình chung học tập >=6
select SINHVIEN.MaSV, TenSV,AVG(Diem)
from SINHVIEN join KETQUA on SINHVIEN.MaSV = KETQUA.MaSV
group by SINHVIEN.MaSV, TenSV
having AVG(Diem)>=6.0
--15. Cho biết mã sinh viên và tên những sinh viên phải thi lại ở ít nhất là những môn mà sinh viên có mã số 3 phải thi lại
select SiNHVIEN.MaSV, TenSV
from SINHVIEN join KETQUA on SINHVIEN.MaSV =KETQUA.MaSV
where		((Diem<4) or (Diem is null)) and (SINHVIEN.MaSV!=3)
		and 
			(MaMH in(
					select MONHOC.MaMH 
					from MONHOC join KETQUA on MONHOC.MaMH = KETQUA.MaMH
					where (Diem <4) and (MaSV=3) 
					)
		)
group by SiNHVIEN.MaSV, TenSV
having COUNT(SiNHVIEN.MaSV) =	(
									select COUNT(*) 
									from MONHOC join KETQUA on MONHOC.MaMH = KETQUA.MaMH
									where (Diem <4) and (MaSV=3)
								)
--16. Cho mã sv và tên của những sinh viên có hơn nửa số điểm  >=5. 
select BangSoDiemLonHon5.MaSV, TenSV, SoLuongDiemLonHon5, SoLuongMon
from
	(select SINHVIEN.MaSV, TenSV,COUNT(SINHVIEN.MaSV) as SoLuongDiemLonHon5
	from SINHVIEN join KETQUA on SINHVIEN.MaSV = KETQUA.MaSV
	where (Diem >=5)
	group by SINHVIEN.MaSV, TenSV) as BangSoDiemLonHon5	
join
	(select MaSV,COUNT(MaSV) as SoLuongMon
	from KETQUA 
	group by MaSV) as BangSoMon
on BangSoDiemLonHon5.MaSV = BangSoMon.MaSV
where SoLuongDiemLonHon5 > SoLuongMon / 2
--17. Cho danh sách tên và mã sinh viên có điểm trung bình chung lớn hơn điểm trung bình của toàn khóa.
select SINHVIEN.MaSV, TenSV
from SINHVIEN join KETQUA on SINHVIEN.MaSV = KETQUA.MaSV
group by SINHVIEN.MaSV,TenSV
having AVG(Diem) >	(
						select AVG(Diem) from KETQUA
						where Diem is not null
					)
	-- Diem TB tinh theo Diem TB cua tung lop
select AVG(DiemTB)
from
	(select Lop, AVG(Diem) as DiemTB
	from SINHVIEN join KETQUA on SINHVIEN.MaSV = KETQUA.MaSV
	where Diem is not null
	group by Lop) as BangDiemTB
--18. *Cho danh sách mã sinh viên, tên sinh viên có điểm cao nhất của mỗi lớp.
select distinct SINHVIEN.MaSV,TenSV,DiemCaoNhat
from 
	SINHVIEN join KETQUA on SINHVIEN.MaSV = KETQUA.MaSV
join
	(select Lop,MAX(Diem) as DiemCaoNhat
	from SINHVIEN join KETQUA on SINHVIEN.MaSV = KETQUA.MaSV
	group by(Lop)) as DiemCaoNhatMoiLop
on SINHVIEN.Lop = DiemCaoNhatMoiLop.Lop
where Diem = DiemCaoNhat 
--19. Cho danh sách tên và mã sinh viên có điểm trung bình chung lớn hơn điểm trung bình của lớp sinh viên đó theo học.
select distinct MaSV,TenSV,DiemTBSV,BangDiemTBTheoMaSV.Lop,DiemTBLop
from 
	(select SINHVIEN.MaSV,TenSV,Lop,AVG(Diem) as DiemTBSV
	from SINHVIEN join KETQUA on SINHVIEN.MaSV = KETQUA.MaSV
	group by SINHVIEN.MaSV,TenSV,Lop) as BangDiemTBTheoMaSV
join
	(select Lop, AVG(Diem) as DiemTBLop
	from SINHVIEN join KETQUA on SINHVIEN.MaSV = KETQUA.MaSV
	where Diem is not null
	group by Lop) as BangDiemTBTheoLop
on BangDiemTBTheoMaSV.Lop = BangDiemTBTheoLop.Lop
where DiemTBSV > DiemTBLop
order by BangDiemTBTheoMaSV.Lop
