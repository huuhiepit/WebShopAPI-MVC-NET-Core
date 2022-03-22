using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebShopData.Data;
using WebShopData.Models;

namespace WebShopAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SizeController : ControllerBase
    {
        private readonly WebshopdbContext _size;

        public SizeController(WebshopdbContext size)
        {
            _size = size;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Size>>> GetAll()
        {
            return Ok(await _size.Size.OrderByDescending(s => s.IdSize).ToListAsync());
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Size>> GetSize(long id)
        {
            var size = await _size.Size.FindAsync(id);

            if (size == null)
            {
                return BadRequest("Size không tồn tại.");
            }

            return Ok(size);
        }

        [HttpPost]
        public async Task<IActionResult> CreateSize([FromBody] Size size)
        {
            if (SizeNameExists(size.TenSize))
            {
                return NotFound("Size đã tồn tại");
            }
            _size.Size.Add(size);
            await _size.SaveChangesAsync();

            return Ok(size);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateSize(long id, Size size)
        {
            _size.ChangeTracker.QueryTrackingBehavior = QueryTrackingBehavior.NoTracking;
            if (id != size.IdSize)
            {
                return BadRequest("Size không tồn tại.");
            }

            var s = await _size.Size.FindAsync(id);

            if (s != null && s.TenSize == size.TenSize)
            {
                return Ok(size);
            }

            _size.Entry(size).State = EntityState.Modified;

            if (SizeNameExists(size.TenSize))
            {
                return BadRequest("Size đã tồn tại");
            }

            try
            {
                await _size.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!SizeExists(id))
                {
                    return BadRequest("Update lỗi");
                }
                else
                {
                    throw;
                }
            }

            return Ok(size);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteSize(long id)
        {
            var size = await _size.Size.FindAsync(id);
            if (size == null)
            {
                return BadRequest("Không tìm thấy Size.");
            }

            _size.Size.Remove(size);
            await _size.SaveChangesAsync();

            return Ok("Delete thành công.");
        }

        private bool SizeNameExists(string name)
        {
            return _size.Size.Any(n => n.TenSize == name);
        }
        private bool SizeExists(long id)
        {
            return _size.Size.Any(e => e.IdSize == id);
        }
    }
}
