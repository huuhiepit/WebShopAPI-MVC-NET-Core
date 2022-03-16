using Microsoft.AspNetCore.Mvc;
using WebShopData.Models;
using WebShopData.Data;
using Microsoft.EntityFrameworkCore;
// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace WebShopAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SanPhamController : ControllerBase
    {
        private readonly WebshopdbContext _sanpham;

        public SanPhamController(WebshopdbContext sanpham)
        {
            _sanpham = sanpham;
        }

        //Lấy all sản phẩm theo thứ tự ngày giảm dần (Data sản phẩm)
        [HttpGet]
        public async Task<ActionResult<IEnumerable<SanPham>>> GetAll()
        {
            return Ok(await _sanpham.SanPham.OrderByDescending(sp => sp.NgayTao).ToListAsync());
        }

        //Lấy 1 sẩn phẩm
        [HttpGet("{id}")]
        public async Task<ActionResult<SanPham>> GetSanPham(long id)
        {
            var sanpham = await _sanpham.SanPham.FindAsync(id);

            if(sanpham == null)
            {
                return NotFound();
            }

            return Ok(sanpham);
        }

        //Hiển thị sản phẩm theo thứ tự ngày giảm dần
        [HttpGet]
        [Route("view")]
        public async Task<ActionResult<IEnumerable<ViewSanPham>>> ViewSanPham()
        {
            return Ok(await _sanpham.ViewSanPham.OrderByDescending(sp => sp.NgayTao).ToListAsync());
        }

        //Tạo mới sản phẩm
        [HttpPost]
        public async Task<IActionResult> CreateSanPham([FromBody] SanPham sanpham)
        {
            if (SanPhamExists(sanpham.TenSp))
            {
                return NotFound();
            }
            _sanpham.SanPham.Add(sanpham);
            await _sanpham.SaveChangesAsync();

            return Ok(sanpham);
        }

        //Upload ảnh sản phẩm
        [HttpPost("UploadImage")]
        public async Task<IActionResult> UploadImgae(IFormFile file)
        {
            try
            {
                var path = Path.Combine("C:/Users/hiepnh/Desktop/doantn/WebShopAPI-MVC-NET-Core/WebShop.Client/wwwroot", "img/products", file.FileName);
                var stream = new FileStream(path, FileMode.Create);

                await file.CopyToAsync(stream);

                return Ok(new { lengt = file.Length, name = file.FileName });
            }
            catch
            {
                return BadRequest();
            }
        }

        //Sửa sản phẩm
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateSanPham(long id, SanPham sanpham)
        {
            if(id != sanpham.IdSanPham)
            {
                return NotFound();
            }

            _sanpham.Entry(sanpham).State = EntityState.Modified;

            try
            {
                var sp = await _sanpham.SanPham.FindAsync(id);

                if (sp != null && sp.Image != sanpham.Image)
                {
                    var pathDelete = Path.Combine("C:/Users/hiepnh/Desktop/doantn/WebShopAPI-MVC-NET-Core/WebShop.Client/wwwroot", "img/products", sp.Image);
                    if (System.IO.File.Exists(pathDelete))
                    {
                        System.IO.File.Delete(pathDelete);
                    }
                }

                await _sanpham.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (SanPhamExists(sanpham.TenSp))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return Ok(sanpham);
        }

        //Xóa sản phẩm
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteSanPham(long id)
        {
            
         
            var list_ctsp = await _sanpham.ChiTietSanPham.Where(c => c.IdSanPham == id).ToListAsync();
            if(list_ctsp != null)
            {
                foreach (var ctsp in list_ctsp)
                {
                    deleteImage(ctsp.ImageUrl);
                    _sanpham.ChiTietSanPham.Remove(ctsp);
                    await _sanpham.SaveChangesAsync();
                }

            }

            var sanpham = await _sanpham.SanPham.FindAsync(id);

            if (sanpham == null)
            {
                return NotFound();
            }

            deleteImage(sanpham.Image);

            _sanpham.SanPham.Remove(sanpham);

            await _sanpham.SaveChangesAsync();


            return Ok("Delete Success!");
        }

        //-------------------------------------------------------

        private bool SanPhamExists(string name)
        {
            return _sanpham.SanPham.Any(e => e.TenSp == name);
        }
        private void deleteImage(string nameImg)
        {
            var pathDelete = Path.Combine("C:/Users/hiepnh/Desktop/doantn/WebShopAPI-MVC-NET-Core/WebShop.Client/wwwroot", "img/products", nameImg);
            if (System.IO.File.Exists(pathDelete))
            {
                System.IO.File.Delete(pathDelete);
            }
        }
    }
}
