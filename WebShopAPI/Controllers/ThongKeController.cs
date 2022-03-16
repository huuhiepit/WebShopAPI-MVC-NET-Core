using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebShopData.Data;
using WebShopData.Models;


namespace WebShopAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ThongKeController : ControllerBase
    {
        private readonly WebshopdbContext _thongke;

        public ThongKeController(WebshopdbContext thongke)
        {
            _thongke = thongke;
        }

        //Thống kê doanh thu
        [HttpGet]
        [Route("doanhthu/{dateStarted}&{dateEnded}")]
        public async Task<ActionResult<IEnumerable<ViewDoanhThu>>> ThongKeDoanhThu(DateTime dateStarted, DateTime dateEnded)
        {
            var doanhthu = await _thongke.ViewDoanhThu.OrderBy(dt => dt.NgayDatHang).Where(dt => dt.NgayDatHang >= dateStarted && dt.NgayDatHang <= dateEnded).ToListAsync();
            return Ok(doanhthu);
        }

        //Số lượng sản phẩm bán ra
        [HttpGet]
        [Route("spbanchay/{dateStarted}&{dateEnded}")]
        public async Task<ActionResult<IEnumerable<ViewSanPhamBanChay>>> ThongKeSPBanChay(DateTime dateStarted, DateTime dateEnded)
        {
            var sp_banchay = await _thongke.ViewSanPhamBanChay.OrderByDescending(dt => dt.SoLuongBan).Where(dt => dt.NgayDatHang >= dateStarted && dt.NgayDatHang <= dateEnded).ToListAsync();
            return Ok(sp_banchay);
        }

    }
}
