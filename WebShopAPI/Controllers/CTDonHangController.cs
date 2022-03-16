using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebShopData.Data;
using WebShopData.Models;


namespace WebShopAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CTDonHangController : ControllerBase
    {
        private readonly WebshopdbContext _ctdh;
        public CTDonHangController(WebshopdbContext ctdh)
        {
            _ctdh = ctdh;
        }

        //Xem chi tiết đơn hàng
        [HttpGet("{idDH}")]
        public async Task<ActionResult<IEnumerable<ViewCtdonHang>>> GetCTDH(long idDH)
        {
            return Ok(await _ctdh.ViewCtdonHang.Where(ctdh => ctdh.IdDonHang == idDH).ToListAsync());
        }


        //Thêm chi tiết đơn hàng
        [HttpPost]
        public async Task<IActionResult> CreateCTDH([FromBody] ChiTietDonHang ctdh)
        {
            if (CTDHExists(ctdh.IdCtdh))
            {
                return NotFound();
            }

            _ctdh.ChiTietDonHang.Add(ctdh);
            await _ctdh.SaveChangesAsync();

            return Ok(ctdh);
        }

        //Xóa chi tiết đơn hàng
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCTDH(long id)
        {
            var ctdh = await _ctdh.ChiTietDonHang.FindAsync(id);

            if (ctdh == null)
            {
                return BadRequest();
            }

            _ctdh.ChiTietDonHang.Remove(ctdh);
            await _ctdh.SaveChangesAsync();

            return Ok("Delete Success");
        }

        //-----------------------------------------------
        private bool CTDHExists(long id)
        {
            return _ctdh.ChiTietDonHang.Any(ctdh => ctdh.IdCtdh == id);
        }
    }
}
