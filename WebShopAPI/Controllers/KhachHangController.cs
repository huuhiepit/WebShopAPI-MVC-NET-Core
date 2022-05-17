using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Cryptography;
using System.Text;
using WebShopData.Data;
using WebShopData.Models;

namespace WebShopAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class KhachHangController : ControllerBase
    {
        private readonly WebshopdbContext _khachhang;

        public KhachHangController(WebshopdbContext khachhang)
        {
            _khachhang = khachhang;
        }

        // Lấy danh sách khách hàng theo tiêu chí ngày tạo giảm dần
        [HttpGet]
        public async Task<ActionResult<IEnumerable<KhachHang>>> GetAll()
        {
            return Ok(await _khachhang.KhachHang.OrderByDescending(kh => kh.NgayTao).ToListAsync());
        }

        // Lấy thông tin một khách hàng
        [HttpGet("{id}")]
        public async Task<ActionResult<KhachHang>> GetKhachHang(long id)
        {
            var kh = await _khachhang.KhachHang.FindAsync(id);

            if (kh == null)
            {
                return BadRequest("Không tìm thấy khách hàng.");
            }

            return Ok(kh);
        }
        // Lấy thông tin một khách hàng dựa trên username
        [HttpGet("thongtin/{username}")]
        public async Task<ActionResult<KhachHang>> GetKhachHangUserName(string username)
        {
            var kh = await _khachhang.KhachHang.Where(kh => kh.UserName.Equals(username)).FirstOrDefaultAsync();

            if (kh == null)
            {
                return BadRequest("Không tìm thấy khách hàng.");
            }

            return Ok(kh);
        }

        // Lấy thông tin lịch sử mua hàng của một khách hàng
        [HttpGet("lichsumuahang/{id}")]
        public async Task<ActionResult<IEnumerable<ViewLichSuMuaHang>>> GetLichSuMuaHang(long id)
        {
            var lichsu = await _khachhang.ViewLichSuMuaHang.Where(ls => ls.IdKhachHang == id && ls.TrangThai == true).OrderByDescending(ls => ls.NgayDatHang).ToListAsync();

            if(lichsu == null)
            {
                return BadRequest("Khách hàng chưa có lịch sử mua hàng nào");
            }

            return Ok(lichsu);
        }

        // Lấy thông tin lịch sử mua hàng của một khách hàng
        [HttpGet("xemlichsumuahang/{id}")]
        public async Task<ActionResult<IEnumerable<ViewLichSuMuaHang>>> XemLichSuMuaHang(long id)
        {
            var lichsu = await _khachhang.ViewLichSuMuaHang.Where(ls => ls.IdKhachHang == id).OrderByDescending(ls => ls.NgayDatHang).ToListAsync();

            if (lichsu == null)
            {
                return BadRequest("Khách hàng chưa có lịch sử mua hàng nào");
            }

            return Ok(lichsu);
        }

        //Register khách hàng
        [HttpPost("Register")]
        public async Task<ActionResult<KhachHang>> Register([FromBody] KhachHang khachhang)
        {
            if (KhachHangUserNameExists(khachhang.UserName))
            {
                return BadRequest();
            }

            khachhang.PassWord = GetMD5(khachhang.PassWord);
            _khachhang.KhachHang.Add(khachhang);
            await _khachhang.SaveChangesAsync();

            return Ok(khachhang);
        }


        //Login khách hàng

        [HttpPost("Login/{user}&{pass}")]
        public async Task<ActionResult<KhachHang>> Login(string user, string pass)
        {
            if (KhachHangUserNameExists(user))
            {

                var hash_password = GetMD5(pass);

                var kh = await _khachhang.KhachHang.Where(kh => kh.UserName.Equals(user) && kh.PassWord.Equals(hash_password)).ToListAsync();

                if (kh != null && kh.Count() > 0)
                {
                    return Ok(kh);
                }
                else
                {
                    return BadRequest("Đăng nhập thất bại, vui lòng kiểm tra lại tài khoản và mật khẩu.");
                }
            }
            else
            {
                return BadRequest("Tên tài khoản không tồn tại.");
            }
        }





        //Sửa thông tin khách hàng
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateKhachHang(long id, KhachHang kh)
        {
            if (id != kh.IdKhachHang)
            {
                return BadRequest("Không tìm thấy khách hàng.");
            }

            if (KhachHangUserNameExists(kh.UserName))
            {
                return BadRequest("User name đã tồn tại.");
            }

            _khachhang.Entry(kh).State = EntityState.Modified;

            try
            {
                await _khachhang.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!KhachHangExists(id))
                {
                    return BadRequest("Update lỗi.");
                }
                else
                {
                    throw;
                }
            }

            return Ok(kh);
        }

        // Xóa khách hàng
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteKhachHang(long id)
        {
            var kh = await _khachhang.KhachHang.FindAsync(id);
            if (kh == null)
            {
                return BadRequest("Không tìm thấy khách hàng.");
            }

            _khachhang.KhachHang.Remove(kh);
            await _khachhang.SaveChangesAsync();

            return Ok("Delete thành công.");
        }


        private bool KhachHangExists(long id)
        {
            return _khachhang.KhachHang.Any(e => e.IdKhachHang == id);
        }

        private bool KhachHangUserNameExists(string name)
        {
            return _khachhang.KhachHang.Any(n => n.UserName == name);
        }

        //Create a string MD5
        public static string GetMD5(string str)
        {
            MD5 md5 = new MD5CryptoServiceProvider();
            byte[] fromData = Encoding.UTF8.GetBytes(str);
            byte[] targetData = md5.ComputeHash(fromData);
            string byte2String = null;

            for (int i = 0; i < targetData.Length; i++)
            {
                byte2String += targetData[i].ToString("x2");

            }
            return byte2String;
        }
    }
}
