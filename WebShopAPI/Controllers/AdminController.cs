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
    public class AdminController : ControllerBase
    {
        private readonly WebshopdbContext _admin;

        public AdminController(WebshopdbContext admin)
        {
            _admin = admin;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Admin>>> GetAll()
        {
            return Ok(await _admin.Admin.OrderByDescending(ad => ad.NgayTao).ToListAsync());
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Admin>> GetAdmin(long id)
        {
            var ad = await _admin.Admin.FindAsync(id);
                                                                                                                                                                                                                                                                                  
            if (ad == null)
            {
                return BadRequest("Không tìm thấy nhân viên trong cơ sở dữ liệu.");
            }

            return Ok(ad);
        }

        // Lấy trạng thái của tài khoản theo username
        [HttpGet("getTrangThai/{username}")]
        public async Task<ActionResult<bool>> GetTrangThai(string username)
        {
            var admin = await _admin.Admin.Where(ad => ad.UserName == username).FirstOrDefaultAsync();
            if(admin == null)
            {
                return BadRequest("Tài khoản admin không chưa tồn tại");
            }
            
            return Ok(new {chucVu = admin.ChucVu, hovaTen = admin.HovaTen});
        }

        [HttpPost]
        public async Task<IActionResult> CreateAdmin([FromBody] Admin ad)
        {
            if (AdminNameExists(ad.UserName))
            {
                return BadRequest("User Name đã tồn tại.");
            }
            _admin.Admin.Add(ad);
            await _admin.SaveChangesAsync();
            return Ok(ad);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateAdmin(long id, Admin ad)
        {
            if (id != ad.IdAdmin)
            {
                return BadRequest("Không tìm thấy nhân viên.");
            }

            _admin.Entry(ad).State = EntityState.Modified;

            try
            {
                await _admin.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {

                if (AdminNameExists(ad.UserName))
                {
                    return BadRequest("User Name đã tồn tại");
                }
                else
                {
                    throw;
                }
            }

            return Ok(ad);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteAdmin(long id)
        {
            var ad = await _admin.Admin.FindAsync(id);
            if (ad == null)
            {
                return BadRequest("Không tìm thấy admin.");
            }

            _admin.Admin.Remove(ad);
            await _admin.SaveChangesAsync();

            return Ok("Delete thành công");
        }             

        //Register Admin
        [HttpPost("Register")]
        public async Task<ActionResult<Admin>> Register([FromBody] Admin admin)
        {
            if (AdminNameExists(admin.UserName))
            {
                return BadRequest("User Name đã tồn tại");
            }

            admin.PassWord = GetMD5(admin.PassWord);
            _admin.Admin.Add(admin);
            await _admin.SaveChangesAsync();

            return Ok(admin);
        }

        //Login Admin
        [HttpPost("Login/{username}&{password}")]
        public async Task<ActionResult<Admin>> Login(string username, string password)
        {
            if (AdminNameExists(username))
            {

                var hash_password = GetMD5(password);
                var admin = await _admin.Admin.Where(ad => ad.UserName.Equals(username) && ad.PassWord.Equals(hash_password)).ToListAsync();
                if (admin != null && admin.Count() > 0)
                {
                    return Ok(admin);
                }
                else
                {
                    return BadRequest("Vui lòng kiểm tra lại tài khoản và mật khẩu.");
                }
            }
            else
            {
                return BadRequest("Tài khoản chưa tồn tại.");
            }
        }

        //----------------------------------------------------------------------------------

        private bool AdminNameExists(string name)
        {
            return _admin.Admin.Any(n => n.UserName == name);
        }

        private bool AdminExists(long id)
        {
            return _admin.Admin.Any(e => e.IdAdmin == id);
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
 
 