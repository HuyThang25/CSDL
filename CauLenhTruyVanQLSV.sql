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
