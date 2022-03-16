using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebShopData.Data;
using WebShopData.Models;

namespace WebShopAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DonHangController : ControllerBase
{
        private readonly WebshopdbContext _donhang;

        public DonHangController(WebshopdbContext donhang)
        {
            _donhang = donhang;
        }

        //Hiển thị đơn hàng
        [HttpGet("trangthai/{tt}")]
        public async Task<ActionResult<IEnumerable<DonHang>>> GetDonHangTT(bool tt)
        {
            var donhang = await _donhang.ViewDonHang.OrderByDescending(dh => dh.NgayDatHang).Where(dh => dh.TrangThai == tt).ToListAsync();
            if(donhang == null)
            {
                return BadRequest();
            }

            return Ok(donhang);
        }

        //Xem chi tiết đơn hàng
        [HttpGet("viewdonhang/{id}")]
        public async Task<ActionResult<IEnumerable<ViewDonHang>>> ViewDonHang(long id)
        {
            var ctdonhang = await _donhang.ViewDonHang.Where(dh => dh.IdDonHang == id).ToArrayAsync();
            return Ok(ctdonhang);
        }

        //Tạo đơn hàng
        [HttpPost]
        public async Task<IActionResult> CreateDonHang([FromBody] DonHang dh)
        {
            if (DonHangExists(dh.IdDonHang))
            {
                return NotFound();
            }
            _donhang.DonHang.Add(dh);
            await _donhang.SaveChangesAsync();
            return Ok(dh);
        }

        //Duyệt đơn hàng: đổi thanh trang thái thành đã duyệt
        [HttpPut("doitrangthai/{id}")]
        public async Task<IActionResult> DoiTrangThaiDH(long id, DonHang dh)
        {

            if (id != dh.IdDonHang)
            {
                return NotFound();
            }

            var list_ctdh = await _donhang.ChiTietDonHang.Where(dh => dh.IdDonHang == dh.IdDonHang).ToListAsync();

            if (list_ctdh != null && list_ctdh.Count() > 0)
            {
                foreach (var ctdh in list_ctdh)
                {
                    var ctsp = await _donhang.ChiTietSanPham.FindAsync(ctdh.IdCtsp);

                    if (ctsp == null) return NotFound();

                    if (ctsp.SoLuong >= ctdh.SoLuong)
                    {
                        _donhang.ChiTietSanPham.Attach(ctsp);
                        ctsp.SoLuong = ctsp.SoLuong - ctdh.SoLuong;
                    }
                    else
                    {
                        return BadRequest("Số lượng sản phẩm có trong kho không đủ");
                    }
                }
            }

            _donhang.DonHang.Attach(dh);
            dh.TrangThai = true;

            try
            {
                await _donhang.SaveChangesAsync();        
            }
            catch(DbUpdateConcurrencyException)
            {
                return BadRequest();
            }

            return Ok(dh);
        }
 
        //Sửa đơn hàng
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateDonHang(long id, DonHang dh)
        {
            if (id != dh.IdDonHang)
            {
                return BadRequest("Đơn Hàng không tồn tại.");
            }

            _donhang.Entry(dh).State = EntityState.Modified;

            try
            {
                await _donhang.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!DonHangExists(id))
                {
                    return BadRequest("Update ERROS");
                }
                else
                {
                    throw;
                }
            }

            return Ok("Update Success!");
        }
      
        //Xóa đơn hàng
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteDonHang(long id)
        {
            var dh = await _donhang.DonHang.FindAsync(id);
            if (dh == null)
            {
                return BadRequest("Đơn hàng không tồn tại.");
            }

            var list_ctdh = await _donhang.ChiTietDonHang.Where(ctdh => ctdh.IdDonHang == id).ToListAsync();

            if (list_ctdh == null)
            {
                return BadRequest();
            }

            foreach (var ctdh in list_ctdh)
            {
                _donhang.ChiTietDonHang.Remove(ctdh);
                await _donhang.SaveChangesAsync();
            }

            _donhang.DonHang.Remove(dh);
            await _donhang.SaveChangesAsync();


            return Ok("Delete Success.");
        }

        //------------------------------------------------------

        //Kiểm tra id đơn hàng đã tồn tại chưa
        private bool DonHangExists(long id)
        {
            return _donhang.DonHang.Any(e => e.IdDonHang == id);
        }
       
    }
}
