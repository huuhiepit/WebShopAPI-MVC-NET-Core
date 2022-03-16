using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebShopData.Data;
using WebShopData.Models;

namespace WebShopAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MauSacController : ControllerBase
    {
        private readonly WebshopdbContext _color;

        public MauSacController(WebshopdbContext color)
        {
            _color = color;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<MauSac>>> GetAll()
        {
            return Ok(await _color.MauSac.ToListAsync()); 
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<MauSac>> GetMauSac(long id)
        {
            var mausac = await _color.MauSac.FindAsync(id);
            if(mausac == null)
            {
                return BadRequest("Màu sắc không tồn tại.");
            }
            return Ok(mausac);
        }

        [HttpPost]
        public async Task<IActionResult> CreateMauSac([FromBody] MauSac mausac)
        {
            if (MauSacNameExists(mausac.TenMauSac))
            {
                return BadRequest("Màu sắc đã tồn tại.");
            }
            _color.MauSac.Add(mausac);
            await _color.SaveChangesAsync();

            return Ok(mausac);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateMauSac(long id, MauSac mausac)
        {
            _color.ChangeTracker.QueryTrackingBehavior = QueryTrackingBehavior.NoTracking;
            if (id != mausac.IdMauSac)
            {
                return BadRequest();
            }

            var cl = await _color.MauSac.FindAsync(id);

            if (cl != null && cl.TenMauSac == mausac.TenMauSac)
            {
                return Ok(mausac);
            }

            if (MauSacNameExists(mausac.TenMauSac))
            {
                return BadRequest("Màu sắc đã tồn tại.");
            }

            _color.Entry(mausac).State = EntityState.Modified;

            try
            {
                await _color.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!MauSacIdExists(id))
                {
                    return BadRequest("Update Lỗi");
                }  
                else
                {
                    throw;
                }
            }
            return Ok(mausac);
        }
        
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteMauSac(long id)
        {
            var mausac = await _color.MauSac.FindAsync(id);

            if(mausac == null)
            {
                return BadRequest("Không tìm thấy màu sắc.");
            }
            _color.MauSac.Remove(mausac);
            await _color.SaveChangesAsync();

            return Ok("Delete thành công!");
        }
        private bool MauSacIdExists(long id)
        {
            return _color.MauSac.Any(e => e.IdMauSac == id);
        }

        private bool MauSacNameExists(string name)
        {
            return _color.MauSac.Any(n => n.TenMauSac == name);
        }
    }
}
