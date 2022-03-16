using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using WebShopData.Data;
using WebShopData.Models;

namespace WebShopAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HomeController : ControllerBase
    {
        private readonly WebshopdbContext _context;

        public HomeController(WebshopdbContext context)
        {
            _context = context;
        }

        // Lấy danh sách sản phẩm
        [HttpGet]
        [Route("listSanPham")]
        public async Task<ActionResult<ViewSanPham>> GetListSanPham()
        {
            var listSp = await _context.ViewSanPham.OrderByDescending(sp => sp.NgayTao).ToListAsync();
            if(listSp.Count() == 0)
            {
                return BadRequest();
            }
            return Ok(listSp);
        }

        //Tìm kiếm tương đối theo tên sản phẩm và loại sản phẩm
        [HttpGet]
        [Route("Search/{key}&{pageNumber}")]
        public async Task<ActionResult<ViewSanPham>> Search(string key, int pageNumber)
        {
            int pageSize = 16;
            var search = await _context.ViewSanPham.Where(sp => sp.TenSp.Contains(key) || 
            sp.TenTheLoai.Contains(key)).ToListAsync();
            var searchPage = search.Skip(pageSize * (pageNumber - 1)).Take(pageSize);
            if (search == null)
            {
                return BadRequest("Không tìm thấy sản phẩm nào");
            }
            return Ok(new { listPage = searchPage, pageMax = pageMax(search.Count()) });
        }

        //Lấy danh sách sản phẩm theo thể loại
        [HttpGet]
        [Route("SearchLoai/{nameloai}&{pageNumber}")]
        public async Task<ActionResult<ViewSanPham>> SearchLoai(string nameloai, int pageNumber)
        {
            int pageSize = 16;
            var sp_loai = await _context.ViewSanPham.Where(sp => sp.TenTheLoai.Equals(nameloai)).ToListAsync();
            var spPage_loai = sp_loai.Skip(pageSize * (pageNumber - 1)).Take(pageSize);
            if (sp_loai == null)
            {
                return BadRequest("Không có sản phẩm nào có trong loại");
            }
            return Ok(new { listPage = spPage_loai, pageMax = pageMax(sp_loai.Count()) });
        }


        //Phân trang sản phẩm hiển thị: 16 sản phẩm
        [HttpGet]
        [Route("Page/{pageNumber}")]
        public async Task<ActionResult<ViewSanPham>> PageSanPham(int pageNumber)
        {
            var list_sp = await _context.ViewSanPham.OrderByDescending(sp => sp.NgayTao).ToListAsync();

            int pageSize = 16;
            var listPage = list_sp.Skip(pageSize * (pageNumber - 1)).Take(pageSize);
            if(listPage == null)
            {
                return BadRequest();
            }

            return Ok(new { listPage = listPage, pageMax = pageMax(list_sp.Count()), count = (list_sp.Count()%16)});
        }

        private long pageMax(long n)
        {
            long pageMax;
            if (n % 16 == 0)
            {
                pageMax = n / 16;
            }
            else
            {
                pageMax = (n / 16) + 1;
            }
            return pageMax;
        }
    }
}
