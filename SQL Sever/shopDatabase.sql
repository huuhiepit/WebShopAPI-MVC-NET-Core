USE [master]
GO
/****** Object:  Database [WebshopDB]    Script Date: 24/03/2022 09:40:15 ******/
CREATE DATABASE [WebshopDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'WebshopDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\WebshopDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'WebshopDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\WebshopDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [WebshopDB] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WebshopDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WebshopDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WebshopDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WebshopDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WebshopDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WebshopDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [WebshopDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [WebshopDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WebshopDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WebshopDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WebshopDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WebshopDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WebshopDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WebshopDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WebshopDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WebshopDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [WebshopDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WebshopDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WebshopDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WebshopDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [WebshopDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WebshopDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [WebshopDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WebshopDB] SET RECOVERY FULL 
GO
ALTER DATABASE [WebshopDB] SET  MULTI_USER 
GO
ALTER DATABASE [WebshopDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WebshopDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [WebshopDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [WebshopDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [WebshopDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [WebshopDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [WebshopDB] SET QUERY_STORE = OFF
GO
USE [WebshopDB]
GO
/****** Object:  Table [dbo].[ChiTietSanPham]    Script Date: 24/03/2022 09:40:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietSanPham](
	[idCTSP] [bigint] IDENTITY(1,1) NOT NULL,
	[idSanPham] [bigint] NOT NULL,
	[idSize] [bigint] NOT NULL,
	[idMauSac] [bigint] NOT NULL,
	[Image_URL] [nvarchar](150) NOT NULL,
	[SoLuong] [int] NOT NULL,
 CONSTRAINT [PK_ChiTietSanPham] PRIMARY KEY CLUSTERED 
(
	[idCTSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietDonHang]    Script Date: 24/03/2022 09:40:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietDonHang](
	[idCTDH] [bigint] IDENTITY(1,1) NOT NULL,
	[idDonHang] [bigint] NOT NULL,
	[idCTSP] [bigint] NOT NULL,
	[Gia] [bigint] NOT NULL,
	[SoLuong] [int] NOT NULL,
 CONSTRAINT [PK_ChiTietDonHang] PRIMARY KEY CLUSTERED 
(
	[idCTDH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SanPham]    Script Date: 24/03/2022 09:40:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPham](
	[idSanPham] [bigint] IDENTITY(1,1) NOT NULL,
	[TenSP] [nvarchar](150) NOT NULL,
	[idTheLoai] [bigint] NOT NULL,
	[Image] [nvarchar](150) NOT NULL,
	[GiaNhap] [bigint] NOT NULL,
	[GiaBan] [bigint] NOT NULL,
	[GiamGia] [bigint] NOT NULL,
	[NgayTao] [date] NOT NULL,
 CONSTRAINT [PK_SanPham] PRIMARY KEY CLUSTERED 
(
	[idSanPham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DonHang]    Script Date: 24/03/2022 09:40:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonHang](
	[idDonHang] [bigint] IDENTITY(1,1) NOT NULL,
	[idKhachHang] [bigint] NOT NULL,
	[NgayDatHang] [date] NOT NULL,
	[DiaChi] [nvarchar](150) NOT NULL,
	[SDT] [nvarchar](150) NOT NULL,
	[TrangThai] [bit] NOT NULL,
	[TongTien] [bigint] NOT NULL,
 CONSTRAINT [PK_DonHang] PRIMARY KEY CLUSTERED 
(
	[idDonHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_SanPhamBanChay]    Script Date: 24/03/2022 09:40:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_SanPhamBanChay]
AS
SELECT                      TOP (100) PERCENT dbo.SanPham.TenSP, dbo.DonHang.NgayDatHang, SUM(dbo.ChiTietDonHang.SoLuong) AS SoLuongBan
FROM                         dbo.ChiTietSanPham INNER JOIN
                                      dbo.SanPham ON dbo.ChiTietSanPham.idSanPham = dbo.SanPham.idSanPham INNER JOIN
                                      dbo.ChiTietDonHang ON dbo.ChiTietSanPham.idCTSP = dbo.ChiTietDonHang.idCTSP INNER JOIN
                                      dbo.DonHang ON dbo.ChiTietDonHang.idDonHang = dbo.DonHang.idDonHang
WHERE                       (dbo.DonHang.TrangThai = 'true')
GROUP BY              dbo.SanPham.TenSP, dbo.DonHang.NgayDatHang
GO
/****** Object:  Table [dbo].[TheLoai]    Script Date: 24/03/2022 09:40:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TheLoai](
	[idTheLoai] [bigint] IDENTITY(1,1) NOT NULL,
	[TenTheLoai] [nvarchar](150) NOT NULL,
 CONSTRAINT [PK_TheLoai] PRIMARY KEY CLUSTERED 
(
	[idTheLoai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_SanPham]    Script Date: 24/03/2022 09:40:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[View_SanPham] as
SELECT                      dbo.SanPham.idSanPham, dbo.SanPham.TenSP, dbo.SanPham.idTheLoai, dbo.TheLoai.TenTheLoai, dbo.SanPham.Image, dbo.SanPham.GiaNhap, dbo.SanPham.GiaBan, dbo.SanPham.GiamGia, 
                                      dbo.SanPham.NgayTao, SUM(dbo.ChiTietSanPham.SoLuong) AS SoLuong
FROM                         dbo.SanPham INNER JOIN
                                      dbo.TheLoai ON dbo.SanPham.idTheLoai = dbo.TheLoai.idTheLoai LEFT JOIN
                                      dbo.ChiTietSanPham ON dbo.SanPham.idSanPham = dbo.ChiTietSanPham.idSanPham
GROUP BY              dbo.SanPham.idSanPham, dbo.SanPham.TenSP, dbo.SanPham.idTheLoai, dbo.TheLoai.TenTheLoai, dbo.SanPham.Image, dbo.SanPham.GiaNhap, dbo.SanPham.GiaBan, dbo.SanPham.GiamGia, dbo.SanPham.NgayTao
GO
/****** Object:  Table [dbo].[MauSac]    Script Date: 24/03/2022 09:40:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MauSac](
	[idMauSac] [bigint] IDENTITY(1,1) NOT NULL,
	[TenMauSac] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_MauSac] PRIMARY KEY CLUSTERED 
(
	[idMauSac] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Size]    Script Date: 24/03/2022 09:40:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Size](
	[idSize] [bigint] IDENTITY(1,1) NOT NULL,
	[TenSize] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Size] PRIMARY KEY CLUSTERED 
(
	[idSize] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_CTSanPham]    Script Date: 24/03/2022 09:40:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_CTSanPham]
AS
SELECT                      dbo.ChiTietSanPham.idCTSP, dbo.ChiTietSanPham.idSanPham, dbo.SanPham.TenSP, dbo.ChiTietSanPham.idSize, dbo.Size.TenSize, dbo.ChiTietSanPham.idMauSac, dbo.MauSac.TenMauSac, 
                                      dbo.ChiTietSanPham.Image_URL, dbo.ChiTietSanPham.SoLuong
FROM                         dbo.ChiTietSanPham INNER JOIN
                                      dbo.SanPham ON dbo.ChiTietSanPham.idSanPham = dbo.SanPham.idSanPham INNER JOIN
                                      dbo.MauSac ON dbo.ChiTietSanPham.idMauSac = dbo.MauSac.idMauSac INNER JOIN
                                      dbo.Size ON dbo.ChiTietSanPham.idSize = dbo.Size.idSize
GO
/****** Object:  View [dbo].[View_CTDonHang]    Script Date: 24/03/2022 09:40:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_CTDonHang]
AS
SELECT                      dbo.ChiTietDonHang.idCTDH, dbo.ChiTietDonHang.idDonHang, dbo.SanPham.idSanPham, dbo.SanPham.TenSP, dbo.Size.idSize, dbo.Size.TenSize, dbo.MauSac.idMauSac, dbo.MauSac.TenMauSac, 
                                      dbo.ChiTietSanPham.Image_URL, dbo.ChiTietDonHang.Gia, dbo.ChiTietDonHang.SoLuong
FROM                         dbo.SanPham INNER JOIN
                                      dbo.ChiTietSanPham ON dbo.SanPham.idSanPham = dbo.ChiTietSanPham.idSanPham INNER JOIN
                                      dbo.Size ON dbo.ChiTietSanPham.idSize = dbo.Size.idSize INNER JOIN
                                      dbo.MauSac ON dbo.ChiTietSanPham.idMauSac = dbo.MauSac.idMauSac INNER JOIN
                                      dbo.ChiTietDonHang ON dbo.ChiTietSanPham.idCTSP = dbo.ChiTietDonHang.idCTSP
GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 24/03/2022 09:40:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHang](
	[idKhachHang] [bigint] IDENTITY(1,1) NOT NULL,
	[HovaTen] [nvarchar](100) NOT NULL,
	[NgaySinh] [date] NOT NULL,
	[DiaChi] [nvarchar](150) NOT NULL,
	[SDT] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[PassWord] [nvarchar](50) NOT NULL,
	[NgayTao] [date] NOT NULL,
 CONSTRAINT [PK_KhachHang] PRIMARY KEY CLUSTERED 
(
	[idKhachHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_DonHang]    Script Date: 24/03/2022 09:40:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_DonHang]
AS
SELECT                      dbo.DonHang.idDonHang, dbo.DonHang.idKhachHang, dbo.KhachHang.HovaTen, dbo.DonHang.NgayDatHang, dbo.DonHang.DiaChi, dbo.DonHang.SDT, dbo.DonHang.TongTien, dbo.DonHang.TrangThai
FROM                         dbo.DonHang INNER JOIN
                                      dbo.KhachHang ON dbo.DonHang.idKhachHang = dbo.KhachHang.idKhachHang
GO
/****** Object:  View [dbo].[View_LichSuMuaHang]    Script Date: 24/03/2022 09:40:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_LichSuMuaHang]
AS
SELECT                      dbo.KhachHang.idKhachHang, dbo.DonHang.idDonHang, dbo.ChiTietDonHang.idCTSP, dbo.SanPham.TenSP, dbo.TheLoai.TenTheLoai, dbo.Size.TenSize, dbo.MauSac.TenMauSac, dbo.ChiTietDonHang.Gia, 
                                      dbo.ChiTietDonHang.SoLuong, dbo.DonHang.NgayDatHang, dbo.DonHang.TrangThai, dbo.ChiTietSanPham.Image_URL
FROM                         dbo.TheLoai INNER JOIN
                                      dbo.SanPham ON dbo.TheLoai.idTheLoai = dbo.SanPham.idTheLoai INNER JOIN
                                      dbo.ChiTietSanPham ON dbo.SanPham.idSanPham = dbo.ChiTietSanPham.idSanPham INNER JOIN
                                      dbo.Size ON dbo.ChiTietSanPham.idSize = dbo.Size.idSize INNER JOIN
                                      dbo.MauSac ON dbo.ChiTietSanPham.idMauSac = dbo.MauSac.idMauSac INNER JOIN
                                      dbo.ChiTietDonHang ON dbo.ChiTietSanPham.idCTSP = dbo.ChiTietDonHang.idCTSP INNER JOIN
                                      dbo.KhachHang INNER JOIN
                                      dbo.DonHang ON dbo.KhachHang.idKhachHang = dbo.DonHang.idKhachHang ON dbo.ChiTietDonHang.idDonHang = dbo.DonHang.idDonHang
GO
/****** Object:  View [dbo].[View_DoanhThu]    Script Date: 24/03/2022 09:40:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[View_DoanhThu] as
SELECT  dbo.ChiTietDonHang.idDonHang, dbo.DonHang.NgayDatHang, SUM(dbo.ChiTietDonHang.Gia * dbo.ChiTietDonHang.SoLuong) as TongTien 
FROM    dbo.ChiTietDonHang INNER JOIN
        dbo.DonHang ON dbo.ChiTietDonHang.idDonHang = dbo.DonHang.idDonHang
Group by dbo.ChiTietDonHang.idDonHang, dbo.DonHang.NgayDatHang
GO
/****** Object:  Table [dbo].[Admin]    Script Date: 24/03/2022 09:40:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admin](
	[idAdmin] [bigint] IDENTITY(1,1) NOT NULL,
	[HovaTen] [nvarchar](150) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[SDT] [nvarchar](50) NOT NULL,
	[DiaChi] [nvarchar](150) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[PassWord] [nchar](50) NOT NULL,
	[ChucVu] [bit] NOT NULL,
	[NgayTao] [date] NOT NULL,
 CONSTRAINT [PK_Admin] PRIMARY KEY CLUSTERED 
(
	[idAdmin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhuyenMai]    Script Date: 24/03/2022 09:40:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhuyenMai](
	[idKhuyenMai] [bigint] IDENTITY(1,1) NOT NULL,
	[TenKhuyenMai] [nvarchar](150) NOT NULL,
	[NgayBatDau] [date] NOT NULL,
	[NgayKetThuc] [date] NOT NULL,
	[GiamGia] [bigint] NOT NULL,
 CONSTRAINT [PK_KhuyenMai] PRIMARY KEY CLUSTERED 
(
	[idKhuyenMai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Admin] ON 

INSERT [dbo].[Admin] ([idAdmin], [HovaTen], [Email], [SDT], [DiaChi], [UserName], [PassWord], [ChucVu], [NgayTao]) VALUES (1, N'Nguyễn Hữu Hiệp', N'hiep@gmail.com', N'093313131', N'Phú Mỹ - Huế', N'admin', N'202cb962ac59075b964b07152d234b70                  ', 1, CAST(N'2022-03-11' AS Date))
INSERT [dbo].[Admin] ([idAdmin], [HovaTen], [Email], [SDT], [DiaChi], [UserName], [PassWord], [ChucVu], [NgayTao]) VALUES (2, N'James Bond', N'jbond123@g', N'0356412356', N'Huế', N'James Bond', N'jb@123                                            ', 1, CAST(N'2022-03-11' AS Date))
INSERT [dbo].[Admin] ([idAdmin], [HovaTen], [Email], [SDT], [DiaChi], [UserName], [PassWord], [ChucVu], [NgayTao]) VALUES (3, N'Hoàng Văn Thịnh', N'thinh123@gmail.com', N'0368945642', N'Huế', N'thinh123', N'jaayc12                                           ', 0, CAST(N'0001-01-01' AS Date))
INSERT [dbo].[Admin] ([idAdmin], [HovaTen], [Email], [SDT], [DiaChi], [UserName], [PassWord], [ChucVu], [NgayTao]) VALUES (4, N'Thuy Tien', N'tien123@gmail.com', N'023467891', N'22/2A Điện Biên Phủ Huế', N'Tien2352', N'Tien1234                                          ', 0, CAST(N'0001-01-01' AS Date))
INSERT [dbo].[Admin] ([idAdmin], [HovaTen], [Email], [SDT], [DiaChi], [UserName], [PassWord], [ChucVu], [NgayTao]) VALUES (5, N'tien1235', N'tien_123@gmail.com', N'0356456456', N'Huế', N'tien123', N'tien123                                           ', 0, CAST(N'0001-01-01' AS Date))
INSERT [dbo].[Admin] ([idAdmin], [HovaTen], [Email], [SDT], [DiaChi], [UserName], [PassWord], [ChucVu], [NgayTao]) VALUES (7, N'Bàng Long', N'banglong_12@gmail.com', N'0356500567', N'Huế', N'banglong1', N'Bang123                                           ', 0, CAST(N'0001-01-01' AS Date))
INSERT [dbo].[Admin] ([idAdmin], [HovaTen], [Email], [SDT], [DiaChi], [UserName], [PassWord], [ChucVu], [NgayTao]) VALUES (8, N'Nguyễn Nhật Ánh', N'wrefrf@gmail.com', N'0654512350', N'Huế', N'Anh12300', N'Anh12345                                          ', 0, CAST(N'0001-01-01' AS Date))
INSERT [dbo].[Admin] ([idAdmin], [HovaTen], [Email], [SDT], [DiaChi], [UserName], [PassWord], [ChucVu], [NgayTao]) VALUES (9, N'Nguyen Nguyen', N'faregf@gmail.com', N'0654512350', N'Huế', N'nguyennguyen', N'Asng123                                           ', 0, CAST(N'0001-01-01' AS Date))
INSERT [dbo].[Admin] ([idAdmin], [HovaTen], [Email], [SDT], [DiaChi], [UserName], [PassWord], [ChucVu], [NgayTao]) VALUES (12, N'Nguyễn Ngạn Ngọc', N'Ngaocj121@gmail.com', N'0332320200', N'Huế', N'Ngoc123', N'Ngoc1321                                          ', 0, CAST(N'0001-01-01' AS Date))
INSERT [dbo].[Admin] ([idAdmin], [HovaTen], [Email], [SDT], [DiaChi], [UserName], [PassWord], [ChucVu], [NgayTao]) VALUES (13, N'Nguyễn Nhật Ánh', N'madame123@gmail.com', N'0326546253', N'12/5 Hoàng Văn Thụ huế', N'madameAnh', N'Anh12356                                          ', 0, CAST(N'0001-01-01' AS Date))
INSERT [dbo].[Admin] ([idAdmin], [HovaTen], [Email], [SDT], [DiaChi], [UserName], [PassWord], [ChucVu], [NgayTao]) VALUES (15, N'Nguyễn Khánh', N'Khanh123@gmail.com', N'0123456789', N'25/2A khu đô thị mới Trường Chinh, Huế', N'Khanh123', N'Asd123dd                                          ', 0, CAST(N'0001-01-01' AS Date))
INSERT [dbo].[Admin] ([idAdmin], [HovaTen], [Email], [SDT], [DiaChi], [UserName], [PassWord], [ChucVu], [NgayTao]) VALUES (16, N'Lê Ngọc Anh', N'ngocAn13@gmail.com', N'03562562202', N'Thành phố Hồ Chí Minh', N'ngocAnhdf', N'ngocAnh123                                        ', 0, CAST(N'0001-01-01' AS Date))
INSERT [dbo].[Admin] ([idAdmin], [HovaTen], [Email], [SDT], [DiaChi], [UserName], [PassWord], [ChucVu], [NgayTao]) VALUES (17, N'Hoàng Thất Việt Tùng', N'Tung1234@gmail.com', N'03221522', N'235 Hoàng Quốc Việt, Huế', N'Tung1234', N'Tung124                                           ', 0, CAST(N'0001-01-01' AS Date))
INSERT [dbo].[Admin] ([idAdmin], [HovaTen], [Email], [SDT], [DiaChi], [UserName], [PassWord], [ChucVu], [NgayTao]) VALUES (18, N'123 Tien', N'tien@gmail.com', N'02456123123', N'Huế-2', N'tien1234', N'202cb962ac59075b964b07152d234b70                  ', 0, CAST(N'2022-03-11' AS Date))
INSERT [dbo].[Admin] ([idAdmin], [HovaTen], [Email], [SDT], [DiaChi], [UserName], [PassWord], [ChucVu], [NgayTao]) VALUES (19, N'Hiep Nguyen', N'hiep@gmail.com', N'0354654645', N'Huế12', N'admin1', N'b4b7d609e9baa998089d8e3686f2d66f                  ', 0, CAST(N'2022-03-16' AS Date))
INSERT [dbo].[Admin] ([idAdmin], [HovaTen], [Email], [SDT], [DiaChi], [UserName], [PassWord], [ChucVu], [NgayTao]) VALUES (20, N'Hiep Nguyen', N'tien@gmail.com', N'123456789', N'Huế2', N'hiep123', N'202cb962ac59075b964b07152d234b70                  ', 1, CAST(N'2022-03-16' AS Date))
INSERT [dbo].[Admin] ([idAdmin], [HovaTen], [Email], [SDT], [DiaChi], [UserName], [PassWord], [ChucVu], [NgayTao]) VALUES (21, N' ', N'', N'', N'', N'', N'd41d8cd98f00b204e9800998ecf8427e                  ', 0, CAST(N'2022-03-23' AS Date))
SET IDENTITY_INSERT [dbo].[Admin] OFF
GO
SET IDENTITY_INSERT [dbo].[ChiTietDonHang] ON 

INSERT [dbo].[ChiTietDonHang] ([idCTDH], [idDonHang], [idCTSP], [Gia], [SoLuong]) VALUES (1, 1, 19, 295000, 1)
INSERT [dbo].[ChiTietDonHang] ([idCTDH], [idDonHang], [idCTSP], [Gia], [SoLuong]) VALUES (2, 1, 18, 250000, 1)
INSERT [dbo].[ChiTietDonHang] ([idCTDH], [idDonHang], [idCTSP], [Gia], [SoLuong]) VALUES (3, 1, 22, 295000, 1)
INSERT [dbo].[ChiTietDonHang] ([idCTDH], [idDonHang], [idCTSP], [Gia], [SoLuong]) VALUES (4, 2, 14, 540000, 2)
INSERT [dbo].[ChiTietDonHang] ([idCTDH], [idDonHang], [idCTSP], [Gia], [SoLuong]) VALUES (5, 2, 10, 600000, 2)
INSERT [dbo].[ChiTietDonHang] ([idCTDH], [idDonHang], [idCTSP], [Gia], [SoLuong]) VALUES (7, 2, 7, 405000, 2)
INSERT [dbo].[ChiTietDonHang] ([idCTDH], [idDonHang], [idCTSP], [Gia], [SoLuong]) VALUES (8, 3, 6, 405000, 2)
INSERT [dbo].[ChiTietDonHang] ([idCTDH], [idDonHang], [idCTSP], [Gia], [SoLuong]) VALUES (9, 4, 7, 405000, 2)
INSERT [dbo].[ChiTietDonHang] ([idCTDH], [idDonHang], [idCTSP], [Gia], [SoLuong]) VALUES (11, 5, 19, 295000, 3)
INSERT [dbo].[ChiTietDonHang] ([idCTDH], [idDonHang], [idCTSP], [Gia], [SoLuong]) VALUES (12, 5, 9, 600000, 2)
SET IDENTITY_INSERT [dbo].[ChiTietDonHang] OFF
GO
SET IDENTITY_INSERT [dbo].[ChiTietSanPham] ON 

INSERT [dbo].[ChiTietSanPham] ([idCTSP], [idSanPham], [idSize], [idMauSac], [Image_URL], [SoLuong]) VALUES (5, 1, 6, 2, N'429e32d9580e836a23f6a17d5f76a013.jpg', 12)
INSERT [dbo].[ChiTietSanPham] ([idCTSP], [idSanPham], [idSize], [idMauSac], [Image_URL], [SoLuong]) VALUES (6, 3, 5, 2, N'AO_SOMI_M1SMD11103BOSTR_(ao_so_mi_nam_m1smd11103bostr_toto_shop_(6)).jpg', 26)
INSERT [dbo].[ChiTietSanPham] ([idCTSP], [idSanPham], [idSize], [idMauSac], [Image_URL], [SoLuong]) VALUES (7, 3, 4, 2, N'AO_SOMI_M1SMD11103BOSTR_(ao_so_mi_nam_m1smd11103bostr_toto_shop_(8)).jpg', 4)
INSERT [dbo].[ChiTietSanPham] ([idCTSP], [idSanPham], [idSize], [idMauSac], [Image_URL], [SoLuong]) VALUES (8, 3, 1, 2, N'AO_SOMI_M1SMD11103BOSTR_(ao_so_mi_nam_m1smd11103bostr_toto_shop_(3)).jpg', 30)
INSERT [dbo].[ChiTietSanPham] ([idCTSP], [idSanPham], [idSize], [idMauSac], [Image_URL], [SoLuong]) VALUES (9, 4, 5, 8, N'QUAN_TAY_M1QTY11101BSFTR_(quan_tay_nam_m1qty11101bsftr_toto_shop_(3)).jpg', 12)
INSERT [dbo].[ChiTietSanPham] ([idCTSP], [idSanPham], [idSize], [idMauSac], [Image_URL], [SoLuong]) VALUES (10, 4, 4, 8, N'QUAN_TAY_M1QTY11101BSFTR_(quan_tay_nam_m1qty11101bsftr_toto_shop_(4)).jpg', 1)
INSERT [dbo].[ChiTietSanPham] ([idCTSP], [idSanPham], [idSize], [idMauSac], [Image_URL], [SoLuong]) VALUES (11, 4, 2, 8, N'QUAN_TAY_M1QTY11101BSFTR_(quan_tay_nam_m1qty11101bsftr_toto_shop_(9)).jpg', 20)
INSERT [dbo].[ChiTietSanPham] ([idCTSP], [idSanPham], [idSize], [idMauSac], [Image_URL], [SoLuong]) VALUES (12, 5, 5, 1, N'QUAN_TAY_M1QTY11104BSFTR_(quan_tay_nam_m1qty11104bsftr_toto_shop_(2)).jpg', 7)
INSERT [dbo].[ChiTietSanPham] ([idCTSP], [idSanPham], [idSize], [idMauSac], [Image_URL], [SoLuong]) VALUES (13, 5, 3, 1, N'QUAN_TAY_M1QTY11104BSFTR_(quan_tay_nam_m1qty11104bsftr_toto_shop_(4)).jpg', 24)
INSERT [dbo].[ChiTietSanPham] ([idCTSP], [idSanPham], [idSize], [idMauSac], [Image_URL], [SoLuong]) VALUES (14, 5, 1, 1, N'QUAN_TAY_M1QTY11104BSFTR_(quan_tay_nam_m1qty11104bsftr_toto_shop_(5)).jpg', 7)
INSERT [dbo].[ChiTietSanPham] ([idCTSP], [idSanPham], [idSize], [idMauSac], [Image_URL], [SoLuong]) VALUES (15, 6, 5, 2, N'30122021121219_quan_jogger_M1QJK12105FBGCR_toto_shop__2_.jpg', 20)
INSERT [dbo].[ChiTietSanPham] ([idCTSP], [idSanPham], [idSize], [idMauSac], [Image_URL], [SoLuong]) VALUES (16, 6, 4, 2, N'30122021121219_quan_jogger_M1QJK12105FBGCR_toto_shop__2_.jpg', 14)
INSERT [dbo].[ChiTietSanPham] ([idCTSP], [idSanPham], [idSize], [idMauSac], [Image_URL], [SoLuong]) VALUES (17, 7, 5, 1, N'19022022080214_A__O_THUN_NU_____W2ATN01217BOSBA___ait___Shop__10_.jpg', 15)
INSERT [dbo].[ChiTietSanPham] ([idCTSP], [idSanPham], [idSize], [idMauSac], [Image_URL], [SoLuong]) VALUES (18, 7, 3, 1, N'IMG_6033.jpg', 15)
INSERT [dbo].[ChiTietSanPham] ([idCTSP], [idSanPham], [idSize], [idMauSac], [Image_URL], [SoLuong]) VALUES (19, 8, 5, 7, N'19022022080213_A__O_THUN_NU_____W2ATN01224BOSBA___ait___Shop__9_.jpg', 10)
INSERT [dbo].[ChiTietSanPham] ([idCTSP], [idSanPham], [idSize], [idMauSac], [Image_URL], [SoLuong]) VALUES (20, 8, 3, 7, N'A__O_THUN_NU_____W2ATN01224BOSBA___ToTo___Shop__14_.jpg', 15)
INSERT [dbo].[ChiTietSanPham] ([idCTSP], [idSanPham], [idSize], [idMauSac], [Image_URL], [SoLuong]) VALUES (21, 9, 3, 2, N'01032022100342_1000_x_1500__W2ATN01221BOSBA_Dai_dien_1.jpg', 15)
INSERT [dbo].[ChiTietSanPham] ([idCTSP], [idSanPham], [idSize], [idMauSac], [Image_URL], [SoLuong]) VALUES (22, 9, 2, 2, N'A__O_THUN_NU_____W2ATN01224BOSBA___ToTo___Shop__16_.jpg', 13)
INSERT [dbo].[ChiTietSanPham] ([idCTSP], [idSanPham], [idSize], [idMauSac], [Image_URL], [SoLuong]) VALUES (23, 10, 5, 5, N'DSC_6526.jpg', 15)
INSERT [dbo].[ChiTietSanPham] ([idCTSP], [idSanPham], [idSize], [idMauSac], [Image_URL], [SoLuong]) VALUES (24, 10, 2, 5, N'DSC_8506_thumb.jpg', 15)
INSERT [dbo].[ChiTietSanPham] ([idCTSP], [idSanPham], [idSize], [idMauSac], [Image_URL], [SoLuong]) VALUES (25, 10, 4, 5, N'DSC_7732.jpg', 17)
INSERT [dbo].[ChiTietSanPham] ([idCTSP], [idSanPham], [idSize], [idMauSac], [Image_URL], [SoLuong]) VALUES (26, 11, 5, 3, N'DSC_8434.jpg', 15)
INSERT [dbo].[ChiTietSanPham] ([idCTSP], [idSanPham], [idSize], [idMauSac], [Image_URL], [SoLuong]) VALUES (27, 11, 4, 6, N'DSC_8415_thumb.jpg', 15)
INSERT [dbo].[ChiTietSanPham] ([idCTSP], [idSanPham], [idSize], [idMauSac], [Image_URL], [SoLuong]) VALUES (28, 11, 2, 7, N'DSC_9455_thumb.jpg', 15)
INSERT [dbo].[ChiTietSanPham] ([idCTSP], [idSanPham], [idSize], [idMauSac], [Image_URL], [SoLuong]) VALUES (29, 12, 3, 3, N'DSC_6745.jpg', 15)
INSERT [dbo].[ChiTietSanPham] ([idCTSP], [idSanPham], [idSize], [idMauSac], [Image_URL], [SoLuong]) VALUES (30, 12, 2, 6, N'DSC_7072_thumb.jpg', 15)
SET IDENTITY_INSERT [dbo].[ChiTietSanPham] OFF
GO
SET IDENTITY_INSERT [dbo].[DonHang] ON 

INSERT [dbo].[DonHang] ([idDonHang], [idKhachHang], [NgayDatHang], [DiaChi], [SDT], [TrangThai], [TongTien]) VALUES (1, 1, CAST(N'2022-03-22' AS Date), N'Phú mỹ - Phú Vang - Thừa Thiên Huế', N'03664512148', 1, 2270000)
INSERT [dbo].[DonHang] ([idDonHang], [idKhachHang], [NgayDatHang], [DiaChi], [SDT], [TrangThai], [TongTien]) VALUES (2, 1, CAST(N'2022-03-22' AS Date), N'Phú mỹ - Phú Vang - Thừa Thiên Huế', N'03664512148', 1, 4800000)
INSERT [dbo].[DonHang] ([idDonHang], [idKhachHang], [NgayDatHang], [DiaChi], [SDT], [TrangThai], [TongTien]) VALUES (3, 1, CAST(N'2022-03-22' AS Date), N'Phú mỹ - Phú Vang - Thừa Thiên Huế', N'03664512148', 1, 810000)
INSERT [dbo].[DonHang] ([idDonHang], [idKhachHang], [NgayDatHang], [DiaChi], [SDT], [TrangThai], [TongTien]) VALUES (4, 1, CAST(N'2022-03-23' AS Date), N'Phú mỹ - Phú Vang - Thừa Thiên Huế', N'03664512148', 1, 810000)
INSERT [dbo].[DonHang] ([idDonHang], [idKhachHang], [NgayDatHang], [DiaChi], [SDT], [TrangThai], [TongTien]) VALUES (5, 1, CAST(N'2022-03-24' AS Date), N'Phú mỹ - Phú Vang - Thừa Thiên Huế', N'03664512148', 0, 3285000)
SET IDENTITY_INSERT [dbo].[DonHang] OFF
GO
SET IDENTITY_INSERT [dbo].[KhachHang] ON 

INSERT [dbo].[KhachHang] ([idKhachHang], [HovaTen], [NgaySinh], [DiaChi], [SDT], [Email], [UserName], [PassWord], [NgayTao]) VALUES (1, N'Nguyễn Hiệp', CAST(N'2020-01-13' AS Date), N'Huế', N'03665144820', N'hiep@gmail.com', N'hiep', N'202cb962ac59075b964b07152d234b70', CAST(N'2022-03-15' AS Date))
INSERT [dbo].[KhachHang] ([idKhachHang], [HovaTen], [NgaySinh], [DiaChi], [SDT], [Email], [UserName], [PassWord], [NgayTao]) VALUES (2, N'Nguyễn Hữu Hiệp1', CAST(N'2000-01-13' AS Date), N'Huế2', N'0366641312', N'hiep@gmail.com', N'hiep1', N'202cb962ac59075b964b07152d234b70', CAST(N'2022-03-15' AS Date))
SET IDENTITY_INSERT [dbo].[KhachHang] OFF
GO
SET IDENTITY_INSERT [dbo].[KhuyenMai] ON 

INSERT [dbo].[KhuyenMai] ([idKhuyenMai], [TenKhuyenMai], [NgayBatDau], [NgayKetThuc], [GiamGia]) VALUES (1, N'Giáng Sinh', CAST(N'2022-02-07' AS Date), CAST(N'2022-02-18' AS Date), 10)
INSERT [dbo].[KhuyenMai] ([idKhuyenMai], [TenKhuyenMai], [NgayBatDau], [NgayKetThuc], [GiamGia]) VALUES (10007, N'Tết', CAST(N'2021-02-15' AS Date), CAST(N'2021-02-16' AS Date), 20)
INSERT [dbo].[KhuyenMai] ([idKhuyenMai], [TenKhuyenMai], [NgayBatDau], [NgayKetThuc], [GiamGia]) VALUES (10010, N'Trung thu', CAST(N'2022-08-10' AS Date), CAST(N'2022-02-16' AS Date), 10)
INSERT [dbo].[KhuyenMai] ([idKhuyenMai], [TenKhuyenMai], [NgayBatDau], [NgayKetThuc], [GiamGia]) VALUES (10014, N'Tết 2022', CAST(N'2022-02-01' AS Date), CAST(N'2022-02-03' AS Date), 20)
INSERT [dbo].[KhuyenMai] ([idKhuyenMai], [TenKhuyenMai], [NgayBatDau], [NgayKetThuc], [GiamGia]) VALUES (10015, N'Sinh nhật', CAST(N'2022-02-01' AS Date), CAST(N'2022-02-03' AS Date), 20)
INSERT [dbo].[KhuyenMai] ([idKhuyenMai], [TenKhuyenMai], [NgayBatDau], [NgayKetThuc], [GiamGia]) VALUES (10016, N'Tết2012', CAST(N'2012-01-10' AS Date), CAST(N'2012-01-17' AS Date), 20)
INSERT [dbo].[KhuyenMai] ([idKhuyenMai], [TenKhuyenMai], [NgayBatDau], [NgayKetThuc], [GiamGia]) VALUES (10017, N'Tết', CAST(N'2022-02-01' AS Date), CAST(N'2022-02-01' AS Date), 10)
SET IDENTITY_INSERT [dbo].[KhuyenMai] OFF
GO
SET IDENTITY_INSERT [dbo].[MauSac] ON 

INSERT [dbo].[MauSac] ([idMauSac], [TenMauSac]) VALUES (1, N'Đen')
INSERT [dbo].[MauSac] ([idMauSac], [TenMauSac]) VALUES (2, N'Trắng')
INSERT [dbo].[MauSac] ([idMauSac], [TenMauSac]) VALUES (3, N'Xanh dương')
INSERT [dbo].[MauSac] ([idMauSac], [TenMauSac]) VALUES (4, N'Vàng')
INSERT [dbo].[MauSac] ([idMauSac], [TenMauSac]) VALUES (5, N'Cam')
INSERT [dbo].[MauSac] ([idMauSac], [TenMauSac]) VALUES (6, N'Đỏ')
INSERT [dbo].[MauSac] ([idMauSac], [TenMauSac]) VALUES (7, N'Hồng')
INSERT [dbo].[MauSac] ([idMauSac], [TenMauSac]) VALUES (8, N'Xám')
SET IDENTITY_INSERT [dbo].[MauSac] OFF
GO
SET IDENTITY_INSERT [dbo].[SanPham] ON 

INSERT [dbo].[SanPham] ([idSanPham], [TenSP], [idTheLoai], [Image], [GiaNhap], [GiaBan], [GiamGia], [NgayTao]) VALUES (1, N'Áo thun trắng MAT123', 1, N'21012022070115_ao_thun_nam_U1ATN01201FOSHT_ait_shop__12_.jpg', 125000, 250000, 0, CAST(N'2022-03-11' AS Date))
INSERT [dbo].[SanPham] ([idSanPham], [TenSP], [idTheLoai], [Image], [GiaNhap], [GiaBan], [GiamGia], [NgayTao]) VALUES (2, N'Áo thun nam U1AN12108FOSHT', 1, N'21012022070122_ao_thun_nam_U1ATN12108FOSHT_toto_shop__1_.jpg', 120000, 253000, 0, CAST(N'2022-03-09' AS Date))
INSERT [dbo].[SanPham] ([idSanPham], [TenSP], [idTheLoai], [Image], [GiaNhap], [GiaBan], [GiamGia], [NgayTao]) VALUES (3, N'Áo sơ mi nam M1SMD11103BOSTR', 1, N'25112021071110_ao_so_mi_nam_M1SMD11103BOSTR_ait_shop__1_.jpg', 200000, 450000, 10, CAST(N'2022-03-11' AS Date))
INSERT [dbo].[SanPham] ([idSanPham], [TenSP], [idTheLoai], [Image], [GiaNhap], [GiaBan], [GiamGia], [NgayTao]) VALUES (4, N'Quần tây nam M1QTY11101BSFTR', 1, N'21122021121240_quan_tay_nam_M1QTY11104BSFTR_ait_shop__1_.jpg', 350000, 600000, 0, CAST(N'2022-03-11' AS Date))
INSERT [dbo].[SanPham] ([idSanPham], [TenSP], [idTheLoai], [Image], [GiaNhap], [GiaBan], [GiamGia], [NgayTao]) VALUES (5, N'Quần tây nam M1QTY11107BSFTR', 1, N'25112021051148_quan_tay_nam_M1QTY11107BSFTR_ait_shop__1_.jpg', 350000, 600000, 10, CAST(N'2022-03-11' AS Date))
INSERT [dbo].[SanPham] ([idSanPham], [TenSP], [idTheLoai], [Image], [GiaNhap], [GiaBan], [GiamGia], [NgayTao]) VALUES (6, N'Quần jogger nam M1QJK12105FBGCR', 1, N'30122021121244_quan_jogger_M1QJK12105FBGCR_ait_shop__1_.jpg', 150000, 350000, 0, CAST(N'2022-03-11' AS Date))
INSERT [dbo].[SanPham] ([idSanPham], [TenSP], [idTheLoai], [Image], [GiaNhap], [GiaBan], [GiamGia], [NgayTao]) VALUES (7, N'Áo thun nữ  BOSBA 12', 2, N'19022022080214_A__O_THUN_NU_____W2ATN01217BOSBA___ait___Shop__10_.jpg', 125000, 250000, 0, CAST(N'2022-03-11' AS Date))
INSERT [dbo].[SanPham] ([idSanPham], [TenSP], [idTheLoai], [Image], [GiaNhap], [GiaBan], [GiamGia], [NgayTao]) VALUES (8, N'Áo thun nữ BOSBA 13', 2, N'19022022080213_A__O_THUN_NU_____W2ATN01224BOSBA___ait___Shop__9_.jpg', 125000, 295000, 0, CAST(N'2022-03-11' AS Date))
INSERT [dbo].[SanPham] ([idSanPham], [TenSP], [idTheLoai], [Image], [GiaNhap], [GiaBan], [GiamGia], [NgayTao]) VALUES (9, N'Áo thun nữ BOSBA 15', 2, N'01032022100342_1000_x_1500__W2ATN01221BOSBA_Dai_dien_1.jpg', 125000, 295000, 0, CAST(N'2022-03-11' AS Date))
INSERT [dbo].[SanPham] ([idSanPham], [TenSP], [idTheLoai], [Image], [GiaNhap], [GiaBan], [GiamGia], [NgayTao]) VALUES (10, N'Áo dài cách tân cánh tiên', 2, N'DSC_7732.jpg', 1000000, 1850000, 10, CAST(N'2022-03-11' AS Date))
INSERT [dbo].[SanPham] ([idSanPham], [TenSP], [idTheLoai], [Image], [GiaNhap], [GiaBan], [GiamGia], [NgayTao]) VALUES (11, N'Áo dài cách tân cổ tròn', 2, N'DSC_6745.jpg', 1000000, 1900000, 10, CAST(N'2022-03-11' AS Date))
INSERT [dbo].[SanPham] ([idSanPham], [TenSP], [idTheLoai], [Image], [GiaNhap], [GiaBan], [GiamGia], [NgayTao]) VALUES (12, N'Áo dài tay cánh tiên phối', 2, N'DSC_8506_thumb.jpg', 1000000, 1900000, 10, CAST(N'2022-03-11' AS Date))
INSERT [dbo].[SanPham] ([idSanPham], [TenSP], [idTheLoai], [Image], [GiaNhap], [GiaBan], [GiamGia], [NgayTao]) VALUES (13, N'Đầm ngắn cổ xoắn', 2, N'DSC_0189_thumb.jpg', 300000, 650000, 10, CAST(N'2022-03-11' AS Date))
INSERT [dbo].[SanPham] ([idSanPham], [TenSP], [idTheLoai], [Image], [GiaNhap], [GiaBan], [GiamGia], [NgayTao]) VALUES (14, N'Áo thun đôi ATND123', 3, N'21022022060243_1000_x_1500_ATND123_ait__Dai_dien.jpg', 125000, 295000, 10, CAST(N'2022-03-11' AS Date))
INSERT [dbo].[SanPham] ([idSanPham], [TenSP], [idTheLoai], [Image], [GiaNhap], [GiaBan], [GiamGia], [NgayTao]) VALUES (15, N'Áo thun đôi ATN111', 3, N'22022022100245_A__o_Thun_Doi___D1ATN111__ait___Shop__7_.jpg', 125000, 295000, 10, CAST(N'2022-03-11' AS Date))
INSERT [dbo].[SanPham] ([idSanPham], [TenSP], [idTheLoai], [Image], [GiaNhap], [GiaBan], [GiamGia], [NgayTao]) VALUES (16, N'Áo khoác đôi AKD1001', 3, N'05112021081124_1000_x_1500_AKD1001_Dai_dien.jpg', 345000, 600000, 10, CAST(N'2022-03-11' AS Date))
INSERT [dbo].[SanPham] ([idSanPham], [TenSP], [idTheLoai], [Image], [GiaNhap], [GiaBan], [GiamGia], [NgayTao]) VALUES (17, N'Áo khoác đôi AKD1002', 3, N'15052021060544_AKD1002_Dai_dien.jpg', 425000, 650000, 10, CAST(N'2022-03-11' AS Date))
INSERT [dbo].[SanPham] ([idSanPham], [TenSP], [idTheLoai], [Image], [GiaNhap], [GiaBan], [GiamGia], [NgayTao]) VALUES (18, N'Áo khoác nữ AKN1001', 4, N'133066276_AKN1001_thumb.jpg', 700000, 1900000, 10, CAST(N'2022-03-11' AS Date))
INSERT [dbo].[SanPham] ([idSanPham], [TenSP], [idTheLoai], [Image], [GiaNhap], [GiaBan], [GiamGia], [NgayTao]) VALUES (19, N'Áo khoác Tweed nữ AKN1002', 4, N'128705478_AKN1002_thumb.jpg', 450000, 1000000, 10, CAST(N'2022-03-11' AS Date))
INSERT [dbo].[SanPham] ([idSanPham], [TenSP], [idTheLoai], [Image], [GiaNhap], [GiaBan], [GiamGia], [NgayTao]) VALUES (20, N'Áo khoác nữ AKN1003', 4, N'254283974_AKN1003_thumb.jpg', 900000, 1800000, 10, CAST(N'2022-03-11' AS Date))
INSERT [dbo].[SanPham] ([idSanPham], [TenSP], [idTheLoai], [Image], [GiaNhap], [GiaBan], [GiamGia], [NgayTao]) VALUES (21, N'Chân váy dáng xẻ CV1001', 2, N'249372267_CV1001.jpg', 300000, 650000, 10, CAST(N'2022-03-11' AS Date))
INSERT [dbo].[SanPham] ([idSanPham], [TenSP], [idTheLoai], [Image], [GiaNhap], [GiaBan], [GiamGia], [NgayTao]) VALUES (22, N'Chân váy chữ A CV1002', 2, N'128705478_CV1002_thumb.jpg', 250000, 495000, 10, CAST(N'2022-03-11' AS Date))
INSERT [dbo].[SanPham] ([idSanPham], [TenSP], [idTheLoai], [Image], [GiaNhap], [GiaBan], [GiamGia], [NgayTao]) VALUES (23, N'Chân váy xếp ly CV1003', 2, N'144139493_CV1003.jpg', 350000, 690000, 10, CAST(N'2022-03-11' AS Date))
INSERT [dbo].[SanPham] ([idSanPham], [TenSP], [idTheLoai], [Image], [GiaNhap], [GiaBan], [GiamGia], [NgayTao]) VALUES (24, N'Váy dài nữ VN1004', 2, N'247632086_VN1004_thumb.jpg', 250000, 350000, 10, CAST(N'2022-03-11' AS Date))
SET IDENTITY_INSERT [dbo].[SanPham] OFF
GO
SET IDENTITY_INSERT [dbo].[Size] ON 

INSERT [dbo].[Size] ([idSize], [TenSize]) VALUES (1, N'XS')
INSERT [dbo].[Size] ([idSize], [TenSize]) VALUES (2, N'S')
INSERT [dbo].[Size] ([idSize], [TenSize]) VALUES (3, N'M')
INSERT [dbo].[Size] ([idSize], [TenSize]) VALUES (4, N'L')
INSERT [dbo].[Size] ([idSize], [TenSize]) VALUES (5, N'XL')
INSERT [dbo].[Size] ([idSize], [TenSize]) VALUES (6, N'XXL')
SET IDENTITY_INSERT [dbo].[Size] OFF
GO
SET IDENTITY_INSERT [dbo].[TheLoai] ON 

INSERT [dbo].[TheLoai] ([idTheLoai], [TenTheLoai]) VALUES (1, N'Đồ Nam')
INSERT [dbo].[TheLoai] ([idTheLoai], [TenTheLoai]) VALUES (2, N'Đồ Nữ')
INSERT [dbo].[TheLoai] ([idTheLoai], [TenTheLoai]) VALUES (3, N'Đồ Đôi')
INSERT [dbo].[TheLoai] ([idTheLoai], [TenTheLoai]) VALUES (4, N'Áo Khoác')
SET IDENTITY_INSERT [dbo].[TheLoai] OFF
GO
ALTER TABLE [dbo].[Admin] ADD  CONSTRAINT [DF_Admin_HovaTen]  DEFAULT (N' ') FOR [HovaTen]
GO
ALTER TABLE [dbo].[Admin] ADD  CONSTRAINT [DF_Admin_ChucVu]  DEFAULT ((0)) FOR [ChucVu]
GO
ALTER TABLE [dbo].[ChiTietDonHang] ADD  CONSTRAINT [DF_ChiTietDonHang_SoLuong]  DEFAULT ((0)) FOR [SoLuong]
GO
ALTER TABLE [dbo].[ChiTietSanPham] ADD  CONSTRAINT [DF_ChiTietSanPham_Image_1]  DEFAULT (N' ') FOR [Image_URL]
GO
ALTER TABLE [dbo].[ChiTietSanPham] ADD  CONSTRAINT [DF_ChiTietSanPham_SoLuong_1]  DEFAULT ((0)) FOR [SoLuong]
GO
ALTER TABLE [dbo].[DonHang] ADD  CONSTRAINT [DF_DonHang_DiaChi]  DEFAULT (N' ') FOR [DiaChi]
GO
ALTER TABLE [dbo].[DonHang] ADD  CONSTRAINT [DF_DonHang_SDT]  DEFAULT (N' ') FOR [SDT]
GO
ALTER TABLE [dbo].[DonHang] ADD  CONSTRAINT [DF_DonHang_TrangThai]  DEFAULT ((0)) FOR [TrangThai]
GO
ALTER TABLE [dbo].[KhachHang] ADD  CONSTRAINT [DF_KhachHang_HovaTen]  DEFAULT (N' ') FOR [HovaTen]
GO
ALTER TABLE [dbo].[KhachHang] ADD  CONSTRAINT [DF_KhachHang_DiaChi]  DEFAULT (N' ') FOR [DiaChi]
GO
ALTER TABLE [dbo].[KhachHang] ADD  CONSTRAINT [DF_KhachHang_SDT]  DEFAULT (N' ') FOR [SDT]
GO
ALTER TABLE [dbo].[KhachHang] ADD  CONSTRAINT [DF_KhachHang_Email]  DEFAULT (N' ') FOR [Email]
GO
ALTER TABLE [dbo].[KhachHang] ADD  CONSTRAINT [DF_KhachHang_UserName]  DEFAULT (N' ') FOR [UserName]
GO
ALTER TABLE [dbo].[KhachHang] ADD  CONSTRAINT [DF_KhachHang_Password]  DEFAULT (N' ') FOR [PassWord]
GO
ALTER TABLE [dbo].[KhuyenMai] ADD  CONSTRAINT [DF_KhuyenMai_TenKhuyenMai]  DEFAULT (N' ') FOR [TenKhuyenMai]
GO
ALTER TABLE [dbo].[KhuyenMai] ADD  CONSTRAINT [DF_KhuyenMai_GiamGia]  DEFAULT ((0)) FOR [GiamGia]
GO
ALTER TABLE [dbo].[MauSac] ADD  CONSTRAINT [DF_MauSac_TenMauSac]  DEFAULT (N' ') FOR [TenMauSac]
GO
ALTER TABLE [dbo].[SanPham] ADD  CONSTRAINT [DF_SanPham_TenSP]  DEFAULT (N' ') FOR [TenSP]
GO
ALTER TABLE [dbo].[SanPham] ADD  CONSTRAINT [DF_SanPham_Image_1]  DEFAULT (N' ') FOR [Image]
GO
ALTER TABLE [dbo].[Size] ADD  CONSTRAINT [DF_Size_TenSize]  DEFAULT (N' ') FOR [TenSize]
GO
ALTER TABLE [dbo].[TheLoai] ADD  CONSTRAINT [DF_TheLoai_TenTheLoai]  DEFAULT (N' ') FOR [TenTheLoai]
GO
ALTER TABLE [dbo].[ChiTietDonHang]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietDonHang_ChiTietSanPham] FOREIGN KEY([idCTSP])
REFERENCES [dbo].[ChiTietSanPham] ([idCTSP])
GO
ALTER TABLE [dbo].[ChiTietDonHang] CHECK CONSTRAINT [FK_ChiTietDonHang_ChiTietSanPham]
GO
ALTER TABLE [dbo].[ChiTietDonHang]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietDonHang_DonHang] FOREIGN KEY([idDonHang])
REFERENCES [dbo].[DonHang] ([idDonHang])
GO
ALTER TABLE [dbo].[ChiTietDonHang] CHECK CONSTRAINT [FK_ChiTietDonHang_DonHang]
GO
ALTER TABLE [dbo].[ChiTietSanPham]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietSanPham_MauSac] FOREIGN KEY([idMauSac])
REFERENCES [dbo].[MauSac] ([idMauSac])
GO
ALTER TABLE [dbo].[ChiTietSanPham] CHECK CONSTRAINT [FK_ChiTietSanPham_MauSac]
GO
ALTER TABLE [dbo].[ChiTietSanPham]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietSanPham_SanPham] FOREIGN KEY([idSanPham])
REFERENCES [dbo].[SanPham] ([idSanPham])
GO
ALTER TABLE [dbo].[ChiTietSanPham] CHECK CONSTRAINT [FK_ChiTietSanPham_SanPham]
GO
ALTER TABLE [dbo].[ChiTietSanPham]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietSanPham_Size] FOREIGN KEY([idSize])
REFERENCES [dbo].[Size] ([idSize])
GO
ALTER TABLE [dbo].[ChiTietSanPham] CHECK CONSTRAINT [FK_ChiTietSanPham_Size]
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD  CONSTRAINT [FK_DonHang_KhachHang] FOREIGN KEY([idKhachHang])
REFERENCES [dbo].[KhachHang] ([idKhachHang])
GO
ALTER TABLE [dbo].[DonHang] CHECK CONSTRAINT [FK_DonHang_KhachHang]
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [FK_SanPham_TheLoai] FOREIGN KEY([idTheLoai])
REFERENCES [dbo].[TheLoai] ([idTheLoai])
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [FK_SanPham_TheLoai]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'KhachHang', @level2type=N'COLUMN',@level2name=N'idKhachHang'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "SanPham"
            Begin Extent = 
               Top = 154
               Left = 59
               Bottom = 284
               Right = 229
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ChiTietSanPham"
            Begin Extent = 
               Top = 171
               Left = 406
               Bottom = 301
               Right = 576
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Size"
            Begin Extent = 
               Top = 0
               Left = 610
               Bottom = 96
               Right = 780
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MauSac"
            Begin Extent = 
               Top = 129
               Left = 692
               Bottom = 225
               Right = 862
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ChiTietDonHang"
            Begin Extent = 
               Top = 14
               Left = 207
               Bottom = 144
               Right = 377
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
      ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_CTDonHang'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'   Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_CTDonHang'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_CTDonHang'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ChiTietSanPham"
            Begin Extent = 
               Top = 187
               Left = 456
               Bottom = 317
               Right = 626
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "SanPham"
            Begin Extent = 
               Top = 0
               Left = 237
               Bottom = 130
               Right = 407
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MauSac"
            Begin Extent = 
               Top = 180
               Left = 77
               Bottom = 276
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Size"
            Begin Extent = 
               Top = 6
               Left = 662
               Bottom = 102
               Right = 832
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_CTSanPham'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_CTSanPham'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "DonHang"
            Begin Extent = 
               Top = 44
               Left = 93
               Bottom = 174
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "KhachHang"
            Begin Extent = 
               Top = 42
               Left = 461
               Bottom = 172
               Right = 631
            End
            DisplayFlags = 280
            TopColumn = 5
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_DonHang'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_DonHang'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[54] 4[24] 2[18] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TheLoai"
            Begin Extent = 
               Top = 20
               Left = 263
               Bottom = 116
               Right = 433
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SanPham"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 136
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ChiTietSanPham"
            Begin Extent = 
               Top = 232
               Left = 851
               Bottom = 362
               Right = 1021
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Size"
            Begin Extent = 
               Top = 35
               Left = 727
               Bottom = 131
               Right = 897
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MauSac"
            Begin Extent = 
               Top = 66
               Left = 1097
               Bottom = 162
               Right = 1267
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ChiTietDonHang"
            Begin Extent = 
               Top = 235
               Left = 534
               Bottom = 365
               Right = 704
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "KhachHang"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            Displ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_LichSuMuaHang'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'ayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DonHang"
            Begin Extent = 
               Top = 198
               Left = 253
               Bottom = 328
               Right = 423
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_LichSuMuaHang'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_LichSuMuaHang'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[32] 4[29] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "SanPham"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TheLoai"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 102
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_SanPham'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_SanPham'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ChiTietSanPham"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 224
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SanPham"
            Begin Extent = 
               Top = 6
               Left = 262
               Bottom = 136
               Right = 448
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ChiTietDonHang"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 224
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DonHang"
            Begin Extent = 
               Top = 138
               Left = 262
               Bottom = 268
               Right = 448
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_SanPhamBanChay'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_SanPhamBanChay'
GO
USE [master]
GO
ALTER DATABASE [WebshopDB] SET  READ_WRITE 
GO
