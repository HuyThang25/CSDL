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
where	(Diem < 4) and (TenMH like N'Toán cao cấp') and (Diem is null)

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
from SINHVIEN	join KETQUA on SINHVIEN.MaSV = KETQUA.MaSV
				join MONHOC on MONHOC.MaMH = KETQUA.MaMH
group by SINHVIEN.MaSV, TenSV
having (sum(Diem*DVHT)/sum(DVHT))>=6.0

--15. Cho biết mã sinh viên và tên những sinh viên phải thi lại ở ít nhất là những môn mà sinh viên có mã số 3 phải thi lại
select SiNHVIEN.MaSV, TenSV
from SINHVIEN join KETQUA on SINHVIEN.MaSV =KETQUA.MaSV
where		((Diem<4) or (Diem is null)) and (SINHVIEN.MaSV!=3)
		and 
			(MaMH in(
					select MaMH 
					from KETQUA
					where ((Diem <4) or Diem is null) and (MaSV=3) 
					)
		)
group by SiNHVIEN.MaSV, TenSV
having COUNT(KETQUA.MaMH) =	(
									select COUNT(*) 
									from KETQUA
									where ((Diem<4) or (Diem is null)) and (MaSV=3)

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
where SoLuongDiemLonHon5 > (SoLuongMon / 2)

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
/******************************/
--1. Viết thủ tục lưu trữ để hiển thị các sinh viên trong lớp gồm thông tin: mã sinh viên, tên sinh viên, môn mà sinh viên này chưa qua theo giá trị lớp nhập vào.
	--	+ Nếu nhập '*' thì in tất cả các sinh viên và môn học sinh viên đó phải thi lại
go
create proc proc_SVThiTruotTrongLop(@Lop Nvarchar(5))
as
	if (@Lop like '*')
		select SINHVIEN.MaSV, TenSV, TenMH 
		from SINHVIEN	join KETQUA on SINHVIEN.MaSV = KETQUA.MaSV
						join MONHOC on KETQUA.MaMH = MONHOC.MaMH
		where (Diem <4)
	else
		select SINHVIEN.MaSV, TenSV, TenMH 
		from SINHVIEN	join KETQUA on SINHVIEN.MaSV = KETQUA.MaSV
						join MONHOC on KETQUA.MaMH = MONHOC.MaMH
		where (Diem <4) and (@Lop = Lop)
go;
exec proc_SVThiTruotTrongLop 'L01'
--2. Viết thủ tục lưu trữ để hiển thị các sinh viên đạt được học bổng, biết rằng để được học bổng thì sinh viên đó phải có điểm tổng kết >= 7.0 và không được thi/học lại môn nào
create proc proc_SVCoHocBong
as
	select SINHVIEN.MaSV, TenSV, AVG(Diem)
	from SINHVIEN	join KETQUA on SINHVIEN.MaSV = KETQUA.MaSV
	where SINHVIEn.MaSV  not in	(--Danh sach thi lai
									select MaSV from KETQUA 
									where Diem < 4
								)
	group by SINHVIEN.MaSV,TenSV
	having AVG(Diem) >= 7.0
--3. Viết thủ tục lưu trữ để cập nhật lại điểm các sinh viên thi môn có mã môn học là @maMH: tất cả các sinh viên được cộng 1đ, max là 10đ
create proc proc_SuaSV(@MaSV int)
as 
	update KETQUA 
	set Diem = Diem+1
	where (MaSV = @MaSV) and (Diem <=9)
--4. Nhập vào mã môn học và mã sinh viên, kiểm tra sinh viên này có đậu môn này hay không, nếu có thì in ra 'Đậu', không thì in ra 'Trượt'
 create proc proc_CheckSVDau(@MaMH int , @MaSV int)
 as
	if (
			select Diem from KETQUA
			where (MaSV = @MaSV) and (MaMH = @MaMH)
		) > 4
	print N'Đậu'
	else 
	print N'Trượt'
	select * from KETQUA

--5. In tất cả các điểm với tên cột là tên môn học của 1 sinh viên khi ta truyền vào mã sinh viên. Thêm 1 cột cuối cùng là Điểm trung bình.
 go
 declare @MaSV int = 10
 declare @AmountMH int = (select COUNT(*) from KETQUA where MaSV = @MaSV)
 declare @index int = 1
 declare @sql Nvarchar(1000)
 declare @tenCot Nvarchar(20)
 declare @MaMH int
 --print @sql
 --declare @diemTB float  = (select AVG(Diem) from KETQUA where MaSV = @MaSV)
 set @sql = 'select * from '
 while @index <= @AmountMH
 begin
	set @tenCot= (select top(1) TenMH from (select top(@index) TenMH, MaMH from MONHOC order by MaMH asc) as MONHOC order by MaMH desc )
	set @MaMH= (select top(1) MaMH from (select top(@index) TenMH, MaMH from MONHOC order by MaMH asc) as MONHOC order by MaMH desc )
	set @sql = @sql+ '(select diem as N''' + @tenCot + ''' from KETQUA where MaSV = ' + CAST(@MaSV as varchar) + ' and MaMH = ' + CAST(@MaMH as varchar) +') as tmp'+CAST(@index as nvarchar) + ' , '
	set @index = @index + 1
 end
 set @sql = @sql + '(select AVG(Diem) as N''Điểm TB'' from KETQUA where MaSV = ' + CAST(@MaSV as nvarchar) +') diemTB'
 print @sql
 	exec sp_sqlexec @sql
 go;
--6. Nhập vào mã sinh viên và mã môn học tương ứng, in ra các sinh viên có điểm thi môn học đó cao hơn sinh viên có mã sinh viên ta nhập.
 
 --		function

 --1. Thống kê các sinh viên có điểm trung bình từ 8 trở lên theo từng lớp
 go 
`create function func_list_student_is_HSG_by_lop(@Lop Nvarchar(5))
 returns @list_student table (MaSV int , TenSV Nvarchar(30), DiemTB float, Lop Nvarchar(5))
 as 
 begin
	insert into @list_student
	select SINHVIEN.MaSV, TenSV, AVG(Diem), Lop 
	from SINHVIEN	join KETQUA on SINHVIEN.MaSV = KETQUA.MaSV
	where Lop like @Lop
	group by SINHVIEN.MaSV, TenSV, Lop
	return
 end
 go;
 select * from dbo.func_list_student_is_HSG_by_lop('L03')
 --2. Thống kê số lượng sinh viên thi lại theo từng quê (thi lại 1 môn bất kì)
 go 
 create function func_list_count_student_by_que(@Que Nvarchar(15))
 returns @list_count_student table (Que Nvarchar (15), SVHocLai int)
 as 
 begin
	if (@Que like '*')
		begin
			insert into @list_count_student
			select Que, COUNT(distinct SINHVIEN.MaSV) 
			from SINHVIEN	join KETQUA on SINHVIEn.MaSV = KETQUA.MaSV
			where Diem < 4
			group by Que
		end
	else 
		begin
			insert into @list_count_student
			select Que, COUNT(distinct SINHVIEN.MaSV) 
			from SINHVIEN	join KETQUA on SINHVIEn.MaSV = KETQUA.MaSV
			where (Diem < 4) and (Que like @Que)
			group by Que
		end
	return
 end
 go;
 select * from dbo.func_list_count_student_by_que('Ninh Bình')
 --3. Nhập mã môn học, in ra danh sách điểm thi của môn học đó
 go 
 create function func_list_diem_by_mon_hoc (@MaMH int)
 returns @list_diem table (MaSV int, TenSV Nvarchar(30), Lop Nvarchar(5), Diem float)
 as
 begin
	insert into @list_diem 
		select SINHVIEN.MaSV, TenSV, Lop, Diem
		from SINHVIEN	join KETQUA on SINHVIEN.MaSV = KETQUA.MaSV
		where MaMH = @MaMH
	return
 end
 go;
 select * from dbo.func_list_diem_by_mon_hoc(2)
 --4. Nhập mã môn học, mã sinh viên, in ra điểm thi của người đó
 --NOTE: câu 3 và 4: nếu nhập mã môn học là '*' thì in ra tất cả môn học, nếu nhập mã sinh viên là '*' thì in ra kết quả của mọi sinh viên
 --5. Nhà trường hỗ trợ kinh phí cho sinh viên nữ ngoại tỉnh Hà Nội và HCM, hãy tìm danh sách các sinh viên đó
 --6. Sửa lại giá trị ngày sinh của sinh viên có @maSV truyền vào bằng cách thêm vào 10 năm tuổi, nếu giá trị @maSV = '*' thì sửa năm sinh của tất cả sinh viên them 1 năm, nếu giá trị @maSV là  1 lớp nào đó thì sửa năm sinh toàn bộ lớp đó thêm 1 năm. Nếu có sinh viên nào trong danh sách các sinh viên sửa năm sinh mà sau khi thêm giá trị ngày hiện tại thì không thực hiện lệnh đó.
