using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebShopData.Data;
using WebShopData.Models;
using Microsoft.AspNetCore.Session;

namespace WebShop.Client.Controllers
{
    public class AdminController : Controller
    {
        
        public ActionResult Index()
        {
            return View();
        }
        //Đơn hàng: chưa duyệt, đã duyệt    
        public ActionResult DonHang()
        {
            return View();
        }
        //Sản phẩm
        
        public ActionResult SanPham()
        {
         
            return View();
        }
       
        public ActionResult CTSanPham(long id)
        {
            return View();
        }

        //Tài khoản: Khách hàng, nhân viên
        
        public ActionResult Khachhang()
        {
            return View();
        }

        
        public ActionResult NhanVien()
        {
            return View();
        }

        //Thống kê
        
        public ActionResult ThongKe()
        {
            return View();
        }

        //Login
        
        public ActionResult Login()
        {
            return View();
        }

        //Register
        
        public ActionResult Register()
        {
            return View();
        }
        //Danh mục: thể loại, màu sắc, size, khuyến mãi
        
        public ActionResult TheLoai()
        {
            return View();
        }

        
        public ActionResult MauSac()
        {
            return View();
        }

        
        public ActionResult Size()
        {
            return View();
        }

        
        public ActionResult KhuyenMai()
        {
            return View();
        }
        
    }
}
