CREATE DATABASE QuanLyThuVien4;
USE QuanLyThuVien4;

-- 1. Độc giả
CREATE TABLE DocGia (
    SoThe VARCHAR(20) PRIMARY KEY,
    Ten NVARCHAR(100),
    NgayCap DATE,
    NgheNghiep VARCHAR(100),
    Phai VARCHAR(10)
);

-- 2. Tài liệu (Cha của sách và báo)
CREATE TABLE TaiLieu (
    MaTL VARCHAR(20) PRIMARY KEY,
    TenTL NVARCHAR(200),
    LoaiTL VARCHAR(50) -- 'Sach' hoặc 'BaoTapChi'
);

-- 3. Tác giả
CREATE TABLE TacGia (
    MaTG VARCHAR(20) PRIMARY KEY,
    TenTG NVARCHAR(100),
    NamSinh INT
);

-- 4. Nhà xuất bản
CREATE TABLE NXB (
    MaNXB VARCHAR(20) PRIMARY KEY,
    TenNXB NVARCHAR(100),
    DiaChi NVARCHAR(200)
);

-- 5. Sách
CREATE TABLE Sach (
    MaSach VARCHAR(20) PRIMARY KEY,
    MaTL VARCHAR(20),
    MaTG VARCHAR(20),
    STT INT,
    TuaDe NVARCHAR(200),
    LanXB INT,
    SoTrang INT,
    KhoGiay VARCHAR(50),
    CD BIT,
    Gia DECIMAL(10,2),
    SLNhap INT,
    SLCon INT,
    TinhTrang NVARCHAR(20),
    FOREIGN KEY (MaTL) REFERENCES TaiLieu(MaTL),
    FOREIGN KEY (MaTG) REFERENCES TacGia(MaTG)
);

-- 6. Báo / Tạp chí
CREATE TABLE BaoTapChi (
    MaBaoTapChi VARCHAR(20) PRIMARY KEY,
    MaTL VARCHAR(20),
    STT INT,
    DinhKy VARCHAR(20), -- hàng ngày, hàng tuần, hàng tháng
    NamPhatHanh INT,
    SLNhap INT,
    SLCon INT,
    FOREIGN KEY (MaTL) REFERENCES TaiLieu(MaTL)
);

-- 7. Quan hệ nhiều nhiều giữa Tác giả và Sách
CREATE TABLE Viet (
    MaTG VARCHAR(20),
    MaSach VARCHAR(20),
    PRIMARY KEY (MaTG, MaSach),
    FOREIGN KEY (MaTG) REFERENCES TacGia(MaTG),
    FOREIGN KEY (MaSach) REFERENCES Sach(MaSach)
);

-- 8. Thông tin xuất bản
CREATE TABLE XuatBan (
    MaNXB VARCHAR(20),
    MaTL VARCHAR(20),
    KyXB INT,
    NamXB INT,
    PRIMARY KEY (MaNXB, MaTL, KyXB),
    FOREIGN KEY (MaNXB) REFERENCES NXB(MaNXB),
    FOREIGN KEY (MaTL) REFERENCES TaiLieu(MaTL)
);

-- 9. Mượn/trả sách
CREATE TABLE MuonTraSach (
    SoThe VARCHAR(20),
    MaSach VARCHAR(20),
    NgayMuon DATE,
    NgayTra DATE,
    PRIMARY KEY (SoThe, MaSach, NgayMuon),
    FOREIGN KEY (SoThe) REFERENCES DocGia(SoThe),
    FOREIGN KEY (MaSach) REFERENCES Sach(MaSach)
);

-- 10. Mượn/trả báo
CREATE TABLE MuonTraBao (
    SoThe VARCHAR(20),
    MaBaoTapChi VARCHAR(20),
    NgayMuon DATE,
    NgayTra DATE,
    PRIMARY KEY (SoThe, MaBaoTapChi, NgayMuon),
    FOREIGN KEY (SoThe) REFERENCES DocGia(SoThe),
    FOREIGN KEY (MaBaoTapChi) REFERENCES BaoTapChi(MaBaoTapChi)
);

-- 11. Thuộc về (Sách → Tài liệu)
CREATE TABLE Thuoc (
    MaTL VARCHAR(20),
    MaSach VARCHAR(20),
    PRIMARY KEY (MaTL, MaSach),
    FOREIGN KEY (MaTL) REFERENCES TaiLieu(MaTL),
    FOREIGN KEY (MaSach) REFERENCES Sach(MaSach)
);

-- 12. Thuộc về (Báo → Tài liệu)
CREATE TABLE Thuoc_TC (
    MaTL VARCHAR(20),
    MaBaoTapChi VARCHAR(20),
    PRIMARY KEY (MaTL, MaBaoTapChi),
    FOREIGN KEY (MaTL) REFERENCES TaiLieu(MaTL),
    FOREIGN KEY (MaBaoTapChi) REFERENCES BaoTapChi(MaBaoTapChi)
);

--Nhập Dữ Liệu	

-- 1. DocGia
INSERT INTO DocGia VALUES
('DG001', 'Nguyen Van Anh', '2023-01-01', 'Sinh viên', 'Nam'),
('DG002', 'Tran Thi Binh', '2022-12-15', 'Giáo viên', 'Nữ'),
('DG003', 'Le Van Chi', '2024-03-10', 'Kỹ sư', 'Nam'),
('DG004', 'Pham Thi Duyen', '2021-05-25', 'Nhân viên', 'Nữ'),
('DG005', 'Hoang Van Em', '2020-09-17', 'Sinh viên', 'Nam');

-- 2. TaiLieu
INSERT INTO TaiLieu VALUES
('TL001', 'Lap trinh C+', 'Sach'),
('TL002', 'Toan roi rac', 'Sach'),
('TL003', 'Bao KHTN', 'BaoTapChi'),
('TL004', 'Tap chi Tin hoc', 'BaoTapChi'),
('TL005', 'Lap trinh Python', 'Sach');

-- 3. TacGia
INSERT INTO TacGia VALUES
('TG01', 'Nguyen Nhat Anh', 1955),
('TG02', 'Le Hong Phong', 1978),
('TG03', 'Tran Thi Kim', 1985),
('TG04', 'Nguyen Van Hoa', 1990),
('TG05', 'Pham Van Tuan', 1970);

-- 4. NXB
INSERT INTO NXB VALUES
('NXB01', 'NXB Giao Duc', '1 Le Duan'),
('NXB02', 'NXB Tre', '10 Nguyen Thi Minh Khai'),
('NXB03', 'NXB KHTN', '20 Nguyen Van Cu'),
('NXB04', 'NXB Dai Hoc Quoc Gia', '144 Xo Viet Nghe Tinh'),
('NXB05', 'NXB Lao Dong', '33 Tran Hung Dao');

-- 5. Sach
INSERT INTO Sach VALUES
('S001', 'TL001', 'TG01', 1, 'Lap trinh C', 1, 200, 'A4', 1, 50000, 10, 8, 'Tot'),
('S002', 'TL001', 'TG02', 2, 'Lap trinh C', 2, 220, 'A4', 0, 52000, 8, 6, 'Rach'),
('S003', 'TL002', 'TG03', 1, 'Toan roi rac', 1, 180, 'A5', 0, 60000, 5, 3, 'Tot'),
('S004', 'TL005', 'TG04', 1, 'Lap trinh Python', 1, 240, 'A4', 1, 70000, 6, 5, 'Mat trang'),
('S005', 'TL005', 'TG05', 2, 'Lap trinh Python', 2, 260, 'A4', 1, 75000, 4, 2, 'Tot');

-- 6. BaoTapChi
INSERT INTO BaoTapChi VALUES
('B001', 'TL003', 1, 'Hang thang', 2015, 10, 4),
('B002', 'TL003', 2, 'Hang thang', 2016, 8, 3),
('B003', 'TL004', 1, 'Hang tuan', 2020, 15, 7),
('B004', 'TL004', 2, 'Hang tuan', 2021, 12, 6),
('B005', 'TL004', 3, 'Hang ngay', 2022, 20, 10);

-- 7. Viet
INSERT INTO Viet VALUES
('TG01', 'S001'),
('TG02', 'S002'),
('TG03', 'S003'),
('TG04', 'S004'),
('TG05', 'S005');

-- 8. XuatBan
INSERT INTO XuatBan VALUES
('NXB01', 'TL001', 1, 2020),
('NXB02', 'TL001', 2, 2021),
('NXB03', 'TL002', 1, 2019),
('NXB04', 'TL005', 1, 2022),
('NXB05', 'TL005', 2, 2023);

-- 9. MuonTraSach
INSERT INTO MuonTraSach VALUES
('DG001', 'S001', '2024-01-15', '2024-01-30'),
('DG002', 'S002', '2024-02-10', '2024-02-25'),
('DG003', 'S003', '2024-03-05', NULL),
('DG004', 'S004', '2024-04-01', NULL),
('DG005', 'S005', '2024-05-01', NULL);

-- 10. MuonTraBao
INSERT INTO MuonTraBao VALUES
('DG001', 'B001', '2024-01-10', '2024-01-15'),
('DG002', 'B002', '2024-02-01', NULL),
('DG003', 'B003', '2024-02-05', '2024-02-10'),
('DG004', 'B004', '2024-03-01', NULL),
('DG005', 'B005', '2024-04-01', NULL);

-- 11. Thuoc (Sach thuộc TL)
INSERT INTO Thuoc VALUES
('TL001', 'S001'),
('TL001', 'S002'),
('TL002', 'S003'),
('TL005', 'S004'),
('TL005', 'S005');

-- 12. Thuoc_TC (Báo/Tạp chí thuộc TL)
INSERT INTO Thuoc_TC VALUES
('TL003', 'B001'),
('TL003', 'B002'),
('TL004', 'B003'),
('TL004', 'B004'),
('TL004', 'B005');

-- Cá Nhân Duy
--1.	Liệt kê danh sách độc giả đã mượn sách nhưng chưa trả (Ngày trả là NULL hoặc lớn hơn hiện tại):
SELECT dg.SoThe, dg.Ten, ms.MaSach, ms.NgayMuon, ms.NgayTra
FROM DocGia dg
JOIN MuonTraSach ms ON dg.SoThe = ms.SoThe
WHERE ms.NgayTra IS NULL OR ms.NgayTra > GETDATE();

--2.	Tìm tên các tác giả có viết nhiều hơn 3 quyển sách
SELECT tg.TenTG, COUNT(v.MaSach) AS SoLuongSach
FROM TacGia tg
JOIN Viet v ON tg.MaTG = v.MaTG
GROUP BY tg.TenTG
HAVING COUNT(v.MaSach) > 3;

--3. Liệt kê thông tin các tài liệu đã được xuất bản trong năm 2024:
SELECT tl.MaTL, tl.TenTL, xb.KyXB, xb.NamXB, nxb.TenNXB
FROM XuatBan xb
JOIN TaiLieu tl ON xb.MaTL = tl.MaTL
JOIN NXB nxb ON xb.MaNXB = nxb.MaNXB
WHERE xb.NamXB = 2024;

--4.	Liệt kê tên sách và số lần sách đó được mượn:
SELECT s.TuaDe, COUNT(ms.MaSach) AS SoLanMuon
FROM MuonTraSach ms
JOIN Sach s ON ms.MaSach = s.MaSach
GROUP BY s.TuaDe;

--5. Liệt kê tên độc giả đã từng mượn cả sách và báo/tạp chí:
SELECT DISTINCT dg.SoThe, dg.Ten
FROM DocGia dg
WHERE dg.SoThe IN (
    SELECT SoThe FROM MuonTraSach
)
AND dg.SoThe IN (
    SELECT SoThe FROM MuonTraBao
);


--- Cá Nhân Phương
--Câu 1: Liệt kê tên các tựa đề sách có nhiều hơn 1 tác giả.
SELECT s.TuaDe
FROM Sach s
JOIN Viet v ON s.MaSach = v.MaSach
GROUP BY s.TuaDe
HAVING COUNT(DISTINCT v.MaTG) > 1;

--Câu 2: Tìm tên độc giả mượn nhiều sách nhất
SELECT TOP 1 dg.Ten, COUNT(ms.MaSach) AS SoSachMuon
FROM DocGia dg
JOIN MuonTraSach ms ON dg.SoThe = ms.SoThe
GROUP BY dg.Ten
ORDER BY SoSachMuon DESC;

--Câu 3: Liệt kê tên sách mà tất cả các độc giả đều đã mượn ít nhất một lần
SELECT s.TuaDe
FROM Sach s
WHERE NOT EXISTS (
    SELECT 1
    FROM DocGia dg
    WHERE NOT EXISTS (
        SELECT 1
        FROM MuonTraSach ms
        WHERE ms.MaSach = s.MaSach AND ms.SoThe = dg.SoThe
    )
);

--Câu 4: Cập nhật tình trạng mượn trong bảng MuonTraSach thành ‘Lỗi nặng’ khi tài liệu có năm xuất bản trước năm 2000, SLCon hiện tại < 2 và tình trạng là “Rách” hoặc “Mất”.

ALTER TABLE MuonTraSach ADD TinhTrang NVARCHAR(100); -- Do cột TinhTrang chưa có ở MuonTraSach nên phải thêm

UPDATE ms
SET TinhTrang = 'Lỗi nặng'
FROM MuonTraSach ms
JOIN Sach s ON ms.MaSach = s.MaSach
JOIN XuatBan xb ON xb.MaTL = s.MaTL
WHERE xb.NamXB < 2000
  AND s.SLCon < 2
  AND (s.TinhTrang LIKE 'Rach%' OR s.TinhTrang LIKE 'Mat%');



-- Cá Nhân Vân
--Câu 1: Liệt kê thông tin các cuốn sách (STT_Cuon, TinhTrang), tên sách, tên tác giả, và tên thể loại mà độc giả có mã SoDG = 'DG001' đã mượn.
SELECT 
    s.STT AS STT_Cuon,
    s.TinhTrang,
    s.TuaDe,
    tg.TenTG,
    tl.LoaiTL
FROM MuonTraSach ms
JOIN Sach s ON ms.MaSach = s.MaSach
JOIN Viet v ON s.MaSach = v.MaSach
JOIN TacGia tg ON v.MaTG = tg.MaTG
JOIN TaiLieu tl ON s.MaTL = tl.MaTL
WHERE ms.SoThe = 'DG001';

--Câu 2: Cập nhật tình trạng sách MaSach = 'S001' và STT_Cuon = 3 thành 'Đang mượn'.
UPDATE Sach
SET TinhTrang = 'Đang mượn'
WHERE MaSach = 'S001' AND STT = 3;

--Câu 3: Xóa thông tin độc giả có mã SoDG = 'DG999' khỏi hệ thống.
DELETE FROM DocGia
WHERE SoThe = 'DG999';

--Câu 4: Đếm số lượng đầu sách theo từng thể loại tài liệu.
SELECT tl.LoaiTL, COUNT(DISTINCT s.TuaDe) AS SoLuongDauSach
FROM Sach s
JOIN TaiLieu tl ON s.MaTL = tl.MaTL
GROUP BY tl.LoaiTL;

--Câu 5: Tìm tên độc giả đã mượn sách nhiều lần nhất.
SELECT TOP 1 dg.Ten, COUNT(*) AS SoLanMuon
FROM MuonTraSach ms
JOIN DocGia dg ON ms.SoThe = dg.SoThe
GROUP BY dg.Ten
ORDER BY SoLanMuon DESC;


-- Cá Nhân Khánh
--1.	Danh sách các cuốn sách có tình trạng “rách” hoặc “mất trang”
SELECT MaSach, STT, TuaDe, TinhTrang
FROM Sach
WHERE TinhTrang LIKE N'Rách%' OR TinhTrang LIKE N'Mất trang%';

--2.	Danh sách các tác giả có ít nhất 3 cuốn sách đã được xuất bản
SELECT tg.TenTG, COUNT(DISTINCT s.MaSach) AS SoLuongSach
FROM TacGia tg
JOIN Viet v ON tg.MaTG = v.MaTG
JOIN Sach s ON v.MaSach = s.MaSach
JOIN XuatBan xb ON xb.MaTL = s.MaTL
GROUP BY tg.TenTG
HAVING COUNT(DISTINCT s.MaSach) >= 3;

--3.	Danh sách các độc giả đã từng mượn báo_tạp chí trong năm 2024
SELECT DISTINCT dg.SoThe, dg.Ten
FROM MuonTraBao mtb
JOIN DocGia dg ON mtb.SoThe = dg.SoThe
WHERE YEAR(mtb.NgayMuon) = 2024;

--4.	Tổng số cuốn sách đang được mượn theo từng tựa đề
SELECT s.TuaDe, COUNT(*) AS SoLuongDangMuon
FROM MuonTraSach ms
JOIN Sach s ON ms.MaSach = s.MaSach
WHERE ms.NgayTra IS NULL
GROUP BY s.TuaDe;

--5. Danh Sách các báo/ tạp chí còn tồn kho
SELECT btc.MaBaoTapChi, tl.TenTL, btc.STT, btc.SLCon
FROM BaoTapChi btc
JOIN TaiLieu tl ON btc.MaTL = tl.MaTL
WHERE btc.SLCon > 0;


-- Cá Nhân Thi
--Câu 1: Liệt kê tên độc giả, tựa đề sách họ đã từng mượn, và ngày mượn tương ứng, đảm bảo thông tin phản ánh đầy đủ các lần mượn đã phát sinh.
SELECT dg.Ten AS TenDocGia, s.TuaDe, ms.NgayMuon
FROM MuonTraSach ms
JOIN DocGia dg ON ms.SoThe = dg.SoThe
JOIN Sach s ON ms.MaSach = s.MaSach
ORDER BY dg.Ten, ms.NgayMuon;

--Câu 2: Cập nhật nghề nghiệp thành “Bị Cảnh Cáo” cho những độc giả đã từng mượn sách nhưng chưa trả lại bất kỳ quyển nào.
UPDATE DocGia
SET NgheNghiep = N'Bị Cảnh Cáo'
WHERE SoThe IN (
    SELECT SoThe
    FROM MuonTraSach
    WHERE NgayTra IS NULL
);

--Câu 3: Xóa các độc giả không có bất kỳ lượt mượn sách nào trong vòng 3 năm gần nhất (tính từ ngày hiện tại).
DELETE FROM DocGia
WHERE SoThe NOT IN (
    SELECT DISTINCT SoThe
    FROM MuonTraSach
    WHERE NgayMuon >= DATEADD(YEAR, -3, GETDATE())
);

--Câu 4: Liệt kê tên độc giả đã từng mượn tài liệu có giá cao nhất 
SELECT DISTINCT dg.Ten
FROM DocGia dg
JOIN MuonTraSach ms ON dg.SoThe = ms.SoThe
JOIN Sach s ON ms.MaSach = s.MaSach
WHERE s.Gia = (
    SELECT MAX(Gia) FROM Sach
);



--- 12 Câu Truy Vấn

-- 2 câu truy vấn lồng  
-- CÂU 1: Liệt kê tên độc giả và tên sách họ đã mượn, kèm theo tình trạng sách
SELECT dg.Ten AS 'Tên độc giả', s.TuaDe AS 'Tên sách', s.TinhTrang AS 'Tình trạng sách'
FROM DocGia dg
JOIN MuonTraSach mts ON dg.SoThe = mts.SoThe
JOIN Sach s ON mts.MaSach = s.MaSach
ORDER BY dg.Ten, s.TuaDe;

-- CÂU 2: Tìm danh sách các tác giả cùng viết một tựa sách cụ thể (mã Sách 'MS01')
SELECT tg.TenTG AS 'Tên tác giả', s.TuaDe AS 'Tên sách'
FROM TacGia tg
JOIN Viet v ON tg.MaTG = v.MaTG
JOIN Sach s ON v.MaSach = s.MaSach
WHERE s.MaSach = 'MS01'
ORDER BY tg.TenTG;

--2 câu update  
-- CÂU 3: Cập nhật tình trạng của những cuốn sách xuất bản trước năm 2000 thành 'Cũ'
UPDATE s
SET s.TinhTrang = N'Cũ'
FROM Sach s
JOIN XuatBan xb ON s.MaTL = xb.MaTL
WHERE xb.NamXB < 2000;


-- CÂU 4: Cập nhật nghề nghiệp cho những độc giả chưa có thông tin nghề nghiệp thành 'Chưa rõ'
UPDATE DocGia
SET NgheNghiep = N'Chưa rõ'
WHERE NgheNghiep IS NULL OR NgheNghiep = '';

--2 câu delete  
-- CÂU 5: Xoá các tài liệu chưa từng được mượn
DELETE FROM TaiLieu
WHERE MaTL NOT IN (
    SELECT DISTINCT s.MaTL
    FROM Sach s
    JOIN MuonTraSach mts ON s.MaSach = mts.MaSach
) 
AND MaTL NOT IN (
    SELECT DISTINCT btc.MaTL
    FROM BaoTapChi btc
    JOIN MuonTraBao mtb ON btc.MaBaoTapChi = mtb.MaBaoTapChi
);

-- CÂU 6: Xoá những tạp chí có số lượng còn lại bằng 0
DELETE FROM BaoTapChi
WHERE SLCon = 0;

--2 câu group by  
-- CÂU 7: Đếm số lượng sách hiện có theo từng tình trạng (mới, cũ, rách, mất trang...)
SELECT TinhTrang, SUM(SLCon) AS 'Số lượng'
FROM Sach
GROUP BY TinhTrang
ORDER BY SUM(SLCon) DESC;

-- CÂU 8: Cho biết mỗi tác giả đã viết bao nhiêu tựa đề sách. Chỉ hiển thị các tác giả đã viết từ 3 tựa đề sách trở lên
SELECT tg.MaTG, tg.TenTG AS 'Tên tác giả', COUNT(DISTINCT v.MaSach) AS 'Số tựa sách'
FROM TacGia tg
JOIN Viet v ON tg.MaTG = v.MaTG
GROUP BY tg.MaTG, tg.TenTG
HAVING COUNT(DISTINCT v.MaSach) >= 3
ORDER BY COUNT(DISTINCT v.MaSach) DESC;

--2 câu sub query  
-- CÂU 9: Tìm các tác giả chưa có sách tái bản lần thứ hai
SELECT tg.MaTG, tg.TenTG AS 'Tên tác giả'
FROM TacGia tg
WHERE tg.MaTG NOT IN (
    SELECT DISTINCT v.MaTG
    FROM Viet v
    JOIN Sach s ON v.MaSach = s.MaSach
    WHERE s.LanXB >= 2
);

-- CÂU 10: Tìm những cuốn sách mà chưa từng được độc giả có nghề nghiệp là "Sinh viên" mượn
SELECT s.MaSach, s.TuaDe AS 'Tên sách'
FROM Sach s
WHERE s.MaSach NOT IN (
    SELECT DISTINCT mts.MaSach
    FROM MuonTraSach mts
    JOIN DocGia dg ON mts.SoThe = dg.SoThe
    WHERE dg.NgheNghiep = 'Sinh viên'
);

2 câu bất kì  
-- CÂU 11: Liệt kê tên các tạp chí có chu kỳ phát hành là 'hàng tháng'
SELECT btc.MaBaoTapChi, tl.TenTL AS 'Tên tạp chí'
FROM BaoTapChi btc
JOIN TaiLieu tl ON btc.MaTL = tl.MaTL
WHERE btc.DinhKy = 'hàng tháng'
ORDER BY tl.TenTL;

-- CÂU 12: Liệt kê tên các sách có số trang lớn hơn 300 và giá dưới 100,000 đồng
SELECT s.MaSach, s.TuaDe AS 'Tên sách', s.SoTrang, s.Gia
FROM Sach s
WHERE s.SoTrang > 300 AND s.Gia < 100000
ORDER BY s.SoTrang DESC, s.Gia ASC;