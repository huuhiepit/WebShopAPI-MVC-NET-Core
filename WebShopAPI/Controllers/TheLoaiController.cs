using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using WebShopData.Models;
using WebShopData.Data;
using Microsoft.EntityFrameworkCore;
using System.Linq;

namespace WebShopAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TheLoaiController : ControllerBase
    {
        private readonly WebshopdbContext _theloai;

        public TheLoaiController(WebshopdbContext theloai)
        {
            _theloai = theloai;
        }

        //Lấy danh sách thể loại theo tiêu chi giảm dần iD
        [HttpGet]
        public async Task<ActionResult<IEnumerable<TheLoai>>> GetAll()
        {
            return Ok(await _theloai.TheLoai.OrderByDescending(tl => tl.IdTheLoai).ToListAsync());
        }

        //Lấy 1 thể loại
        [HttpGet("{id}")]
        public async Task<ActionResult<TheLoai>> GetTheLoai(long id)
        {
            var theloai = await _theloai.TheLoai.FindAsync(id);
            if(theloai == null)
            {
                return BadRequest("Không tìm thấy thể loại.");
            }
            return Ok(theloai);
        }

        //Tạo mới một thể loại
        [HttpPost]
        public async Task<IActionResult> CreateTheLoai([FromBody] TheLoai theloai)
        {
            if (TheLoaiNameExists(theloai.TenTheLoai))
            {
                return BadRequest("Thể loại đã tồn tại.");
            }
            _theloai.TheLoai.Add(theloai);
            await _theloai.SaveChangesAsync();

            return Ok(theloai);
        }

        //Sửa thể loại
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateTheLoai(long id, TheLoai theLoai)
        {
            _theloai.ChangeTracker.QueryTrackingBehavior = QueryTrackingBehavior.NoTracking;
            if (id != theLoai.IdTheLoai)
            {
                return NotFound("Không tìm thấy thể loại");
            }

            var tl = await _theloai.TheLoai.FindAsync(id);

            if (tl != null && tl.TenTheLoai == theLoai.TenTheLoai)
            {
                return Ok(theLoai);
            }

            if (TheLoaiNameExists(theLoai.TenTheLoai))
            {
                return BadRequest("Hello world");
            }

            _theloai.Entry(theLoai).State = EntityState.Modified;

            try
            {
                await _theloai.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!TheLoaiExists(id))
                {
                    return NotFound("Mã thể loại đã tồn tại");
                }
                else
                {
                    throw;
                }
            }

            return Ok(theLoai);
        }
        
        //Xóa thể loại
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteTheLoai(long id)
        {
            var theloai = await _theloai.TheLoai.FindAsync(id);

            if(theloai == null)
            {
                return BadRequest("Không tìm thấy thể loại.");
            }

            _theloai.TheLoai.Remove(theloai);
            await _theloai.SaveChangesAsync();

            return Ok("Delete thành công!!!");
        }
        
        //-------------------------------------------------------------
        private bool TheLoaiNameExists(string name)
        {
            return _theloai.TheLoai.Any(n => n.TenTheLoai == name);
        }

        private bool TheLoaiExists(long id)
        {
            return _theloai.TheLoai.Any(e => e.IdTheLoai == id);
        }
    }
}
