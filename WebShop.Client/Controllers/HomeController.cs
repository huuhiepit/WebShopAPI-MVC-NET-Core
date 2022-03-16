using Microsoft.AspNetCore.Mvc;

namespace WebShop.Client.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult TrangChu()
        {
            return View();
        }
        public IActionResult Detail(long id)
        {
            return View();
        }

        public IActionResult GioHang()
        {
            return View();
        }
        public IActionResult Login()
        {
            return View();
        }
    }
}
