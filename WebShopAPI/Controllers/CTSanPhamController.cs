using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebShopData.Data;
using WebShopData.Models;
using System.Linq;

namespace WebShopAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CTSanPhamController : ControllerBase
    {
        private readonly WebshopdbContext _ctSanPham;

        public CTSanPhamController(WebshopdbContext ctSanPham)
        {
            _ctSanPham = ctSanPham;
        }

        //Lấy all chi tiết sản phẩm
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ChiTietSanPham>>> GetAll()
        {
            return Ok(await _ctSanPham.ChiTietSanPham.ToListAsync());
        }

        //Lấy 1 chi tiết
        [HttpGet("{id}")]
        public async Task<ActionResult<ChiTietSanPham>> GetCTSanPham(long id)
        {
            var ctsp = await _ctSanPham.ChiTietSanPham.FindAsync(id);
            if(ctsp == null)
            {
                return NotFound("Không tìm thấy chi tiết sản phẩm");
            }
            return Ok(ctsp);
        }
        
        //Xem chi tiết của một sản phẩm
        [HttpGet]
        [Route("View/{id}")]
        public async Task<ActionResult<IEnumerable<ViewCtsanPham>>> GetVCTSanPham(long id)
        {
            var ctsanpham = await _ctSanPham.ViewCtsanPham.Where(c => c.IdSanPham == id).ToListAsync();
            return Ok(ctsanpham);
        }

        //Đếm số lượng của 1 sản phẩm
        [HttpGet]
        [Route("SumProduct/{id}")]
        public long GetSumProduct(long id)
        {
            var ctsp = _ctSanPham.ViewCtsanPham.Where(c => c.IdSanPham == id);
            long sum = 0;
            foreach (var sp in ctsp)
            {
                sum += sp.SoLuong;
            }
            return sum;
        }
        
        //Tạo 1 chi tiết
        [HttpPost]
        public async Task<IActionResult> CreateCTSP([FromBody] ChiTietSanPham ctsp)
        {
            if(CTSPExits(ctsp.IdSanPham, ctsp.IdSize, ctsp.IdMauSac))
            {
                return NotFound("Chi tiết sản phẩm đã tồn tại");
            }

            _ctSanPham.ChiTietSanPham.Add(ctsp);
            await _ctSanPham.SaveChangesAsync();

            return Ok(ctsp);
        }

        //Sửa 1 chi tiết
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateCTSP(long id, ChiTietSanPham ctsp)
        {
            if (id != ctsp.IdCtsp)
            {
                return BadRequest("Không tìm thấy mã chi tiết sản phẩm");
            }

            _ctSanPham.Entry(ctsp).State = EntityState.Modified;

            try
            {
                var ctSanPham = await _ctSanPham.ChiTietSanPham.FindAsync(id);

                if (ctSanPham != null && ctSanPham.ImageUrl != ctsp.ImageUrl)
                {
                    var pathDelete = Path.Combine("C:/Users/hiepnh/Desktop/doantn/WebShopAPI-MVC-NET-Core/WebShop.Client/wwwroot", "img/products", ctsp.ImageUrl);
                    if (System.IO.File.Exists(pathDelete))
                    {
                        System.IO.File.Delete(pathDelete);
                    }     
                }
                await _ctSanPham.SaveChangesAsync();   
            }
            catch (DbUpdateConcurrencyException)
            {
                if (CTSPExits(ctsp.IdSanPham, ctsp.IdSize, ctsp.IdMauSac))
                {
                    return BadRequest("Chi tiết sản phẩm đã tồn tại");
                }
                else
                {
                    throw;
                }
            }

            return Ok(ctsp);

        }

        //Xóa 1 chi tiết
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCTSP(long id)
        {
            var ctsp = await _ctSanPham.ChiTietSanPham.FindAsync(id);

            if (ctsp == null)
            {
                return BadRequest();
            }
            var pathDelete = Path.Combine("C:/Users/hiepnh/Desktop/doantn/WebShopAPI-MVC-NET-Core/WebShop.Client/wwwroot", "img/products", ctsp.ImageUrl);
            if (System.IO.File.Exists(pathDelete))
            {
                System.IO.File.Delete(pathDelete);
            }

            _ctSanPham.ChiTietSanPham.Remove(ctsp);
            await _ctSanPham.SaveChangesAsync();

            return Ok("Delete Success!!!!");
        }

        private bool CTSPExits(long IdSp, long Idsize, long IdColor)
        {
            var list_ctsp = _ctSanPham.ViewCtsanPham.Where(ct => ct.IdSanPham == IdSp).ToList();
            if (list_ctsp == null) return false;
            else
            {
                foreach(var ct in list_ctsp)
                {
                    if (ct.IdSize == Idsize && ct.IdMauSac == IdColor) return true;
               }
                return false;
            }
        }
    }
}
