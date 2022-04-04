USE QLBH
--1. In ra danh sách các sản phẩm do “Trung Quoc” sản xuất.
select * from SANPHAM 
where NuocSX like 'Trung Quoc'
--2. In ra danh sách các sản phẩm có đơn vị tính là “cay”, ”quyen”.
select * from SANPHAM
where (DVT like 'cay') or (DVT like 'quyen')
--3. In ra danh sách các sản phẩm có mã sản phẩm bắt đầu là “B” và kết thúc là “01”.
select * from SANPHAM
where MaSP like 'B%01'
--4. In ra danh sách các sản phẩm do “Trung Quoc” hoặc “Thai Lan” sản xuất có giá từ 30.000 đến 40.000.
select * from SANPHAM
where (Gia between 30000 and 40000) and ((NuocSX like 'Trung Quoc') or (NuocSX like 'Thai Lan'))
--5. In ra giá trung bình các sản phẩm theo từng quốc gia. Cho biết giá sản phẩm ở quốc gia nào có giá trị trung bình nhỏ nhất.
select NuocSX, AVG(Gia) from SANPHAM
group by NuocSX
order by NuocSX asc
--6. In ra các số hóa đơn, trị giá hóa đơn bán ra trong ngày 1/1/2007 và ngày 2/1/2007.
select  SoHD,TriGia,NgHD  from HOADON
where (NgHD = '2007-01-01') or (NgHD = '2007-01-02')
--7. In ra các số hóa đơn, trị giá hóa đơn trong tháng 1/2007, sắp xếp theo ngày (tăng dần) và trị giá của hóa đơn (giảm dần).
select SoHD, TriGia, NgHD from HOADON
where (YEAR(NgHD) = 2007) and (MONTH(NgHD)=1)
order by NgHD asc, TriGia desc
--8. In ra danh sách các khách hàng đã mua hàng trong ngày 1/1/2007.
select KHACHHANG.* 
from HOADON join KHACHHANG on HOADON.MaKH=KHACHHANG.MaKH
where NgHD = '2007-01-01'
--9. In ra số lượng hoá đơn từng thực hiện cho mỗi khách hàng
select KHACHHANG.MaKH, HoTen, COUNT(KHACHHANG.MaKH) as N'Số hóa đơn từng thực hiện' 
from HOADON join KHACHHANG on HOADON.MaKH=KHACHHANG.MaKH
group by KHACHHANG.MaKH, HoTen
--10. Tìm khách hàng tiêu nhiều tiền nhất.
select MaKH, HoTen from KHACHHANG
where DoanhSo = (select MAX(DoanhSo) from KHACHHANG)
--11. In ra số hóa đơn, trị giá các hóa đơn do nhân viên có tên “Nguyen Van B” lập trong ngày 28/10/2006.
select HOADON.* 
from HOADON join NHANVIEN on HOADON.MaNV = NHANVIEN.MaNV
where HoTen like 'Nguyen Van B'
--12. In ra danh sách các sản phẩm (MASP,TENSP) được khách hàng có tên “Nguyen Van A” mua trong tháng 10/2006.
select SANPHAM.MaSP, TenSP 
from HOADON	join KHACHHANG on HOADON.MaKH = KHACHHANG.MaKH
			join CTHD on HOADON.SoHD = CTHD.SoHD
			join SANPHAM on CTHD.MaSP = SANPHAM.MaSP
where KHACHHANG.HoTen like 'Nguyen Van A'
group by CTHD.SoHD
--13. Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”.
select * 
from HOADON join CTHD on HOADON.SoHD = CTHD.SoHD
where (MaSP like 'BB01') or (MaSP like 'BB02')
--14. Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
select * 
from HOADON join CTHD on HOADON.SoHD = CTHD.SoHD
where ((MaSP like 'BB01') or (MaSP like 'BB02')) and (SL between 10 and 20)
--15. Tìm các số hóa đơn mua cùng lúc 2 sản phẩm có mã số “BB01” và “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
(
	select HOADON.SoHD 
	from HOADON join CTHD on HOADON.SoHD = CTHD.SoHD
	where (MaSP like 'BB01') and (SL between 10 and 20)
)
intersect
(
	select HOADON.SoHD
	from HOADON join CTHD on HOADON.SoHD = CTHD.SoHD
	where (MaSP like 'BB02') and (SL between 10 and 20)
)
--16. Tìm các số hoá đơn mua nhiều loại sản phẩm nhất

--17. Tìm các số hoá đơn mua nhiều số lượng sản phẩm nhất
--18. Tìm sản phẩm bán chạy nhất từ trước đến nay
--19. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất hoặc các sản phẩm được bán ra trong ngày 1/1/2007.
--20. In ra danh sách các sản phẩm (MASP,TENSP) không bán được.
--21. In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006.
--22. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất không bán được trong năm 2006.
--23. Tìm số hóa đơn đã mua tất cả các sản phẩm do Singapore sản xuất.
--24. Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua?
--25. Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2006.
--26. Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu?
--27. Tính doanh thu bán hàng trong năm 2006.
--28. Tìm số hóa đơn có trị giá cao nhất trong năm 2006.
--29. Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006.
--30. In ra danh sách 3 khách hàng (MAKH, HOTEN) có doanh số cao nhất.
--31. In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất.
--32. In ra danh sách các sản phẩm (MASP, TENSP) do “Thai Lan” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của tất cả các sản phẩm).
--33. In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quoc” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của sản phẩm do “Trung Quoc” sản xuất).
--34. * In ra danh sách 3 khách hàng có doanh số cao nhất (sắp xếp theo kiểu xếp hạng).
--35. Tính tổng số sản phẩm do “Trung Quoc” sản xuất.
--36. Tính tổng số sản phẩm của từng nước sản xuất.
--37. Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm.
--38. Tính doanh thu bán hàng mỗi ngày.
--39. Tính tổng số lượng của từng sản phẩm bán ra trong tháng 10/2006.
--40. Tính doanh thu bán hàng của từng tháng trong năm 2006.
--41. Tìm hóa đơn có mua ít nhất 4 sản phẩm khác nhau.
--42. Tìm hóa đơn có mua 3 sản phẩm do “Viet Nam” sản xuất (3 sản phẩm khác nhau).
--43. Tìm khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất.
--44. Tháng mấy trong năm 2006, doanh số bán hàng cao nhất ?
--45. Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra thấp nhất trong năm 2006.
--46. *Mỗi nước sản xuất, tìm sản phẩm (MASP,TENSP) có giá bán cao nhất.
--47. Tìm nước sản xuất sản xuất ít nhất 3 sản phẩm có giá bán khác nhau.
--48. *Trong 10 khách hàng có doanh số cao nhất, tìm khách hàng có số lần mua hàng nhiều nhất.
--49. Cập nhật giá trị Giá sản phẩm lên gấp đôi.
--50. Liệt kê số lượng sản phẩm bán được theo phân khúc lứa tuổi: dưới 50 tuổi, từ 50-60 tuổi và trên 60 tuổi.