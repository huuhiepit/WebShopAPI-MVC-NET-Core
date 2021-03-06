// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace WebShopData.Models
{
    public partial class KhachHang
    {
        public KhachHang()
        {
            DonHang = new HashSet<DonHang>();
        }

        public long IdKhachHang { get; set; }
        [Required]
        public string HovaTen { get; set; }
        [Required]
        public DateTime NgaySinh { get; set; }
        [Required]
        public string DiaChi { get; set; }
        [Required][Phone]
        public string Sdt { get; set; }
        [Required][EmailAddress]
        public string Email { get; set; }
        [Required]
        public string UserName { get; set; }
        [Required]
        public string PassWord { get; set; }
        public DateTime NgayTao { get; set; }

        public virtual ICollection<DonHang> DonHang { get; set; }
    }
}