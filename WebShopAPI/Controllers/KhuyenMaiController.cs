using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebShopData.Data;
using WebShopData.Models;

namespace WebShopAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class KhuyenMaiController : ControllerBase
    {
        public readonly WebshopdbContext _khuyenmai;

        public KhuyenMaiController(WebshopdbContext khuyenmai)
        {
            _khuyenmai = khuyenmai;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<KhuyenMai>>> GetAll()
        {
            return Ok(await _khuyenmai.KhuyenMai.ToArrayAsync());
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<KhuyenMai>> GetKhuyenMai(long id)
        {
            var khuyenmai = await _khuyenmai.KhuyenMai.FindAsync(id);
            if (khuyenmai == null)
            {
                return NotFound("Khuyến mãi không tồn tại");
            }

            return Ok(khuyenmai);
        }

        [HttpPost]
        public async Task<IActionResult> CreateKhuyenMai([FromBody] KhuyenMai khuyenmai)
        {
            if (KhuyenMaiExists(khuyenmai.TenKhuyenMai))
            {
                return NotFound("Khuyến mãi đã tồn tại");
            }
            _khuyenmai.KhuyenMai.Add(khuyenmai);
            await _khuyenmai.SaveChangesAsync();

            return Ok(khuyenmai);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateKhuyenMai(long id, KhuyenMai khuyenmai)
        {
            if (id != khuyenmai.IdKhuyenMai)
            {
                return NotFound("Khuyến mãi không tồn tại");
            }
            _khuyenmai.Entry(khuyenmai).State = EntityState.Modified;
            try
            {
                await _khuyenmai.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!KhuyenMaiExists(id))
                {
                    return NotFound("Mã khuyến mãi đã tồn tại");
                }
                else
                {
                    throw;
                }
            }
            return Ok(khuyenmai);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteKhuyenMai(long id)
        {
            var khuyenmai = await _khuyenmai.KhuyenMai.FindAsync(id);

            if(khuyenmai == null)
            {
                return NotFound("Khuyến mãi không tồn tại");
            }
            _khuyenmai.KhuyenMai.Remove(khuyenmai);
            await _khuyenmai.SaveChangesAsync();

            return Ok("Xóa khuyến mãi thành công");
        }

        private bool KhuyenMaiExists(long id)
        {
            return _khuyenmai.KhuyenMai.Any(n => n.IdKhuyenMai == id);
        }
        private bool KhuyenMaiExists(string name)
        {
            return _khuyenmai.KhuyenMai.Any(n => n.TenKhuyenMai == name);
        }
    }
}
