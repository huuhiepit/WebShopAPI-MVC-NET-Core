// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace WebShopData.Models
{
    public partial class ViewLichSuMuaHang
    {
        public long IdKhachHang { get; set; }
        public long IdDonHang { get; set; }
        public long IdCtsp { get; set; }
        public string TenSp { get; set; }
        public string TenTheLoai { get; set; }
        public string TenSize { get; set; }
        public string TenMauSac { get; set; }
        public long Gia { get; set; }
        public int SoLuong { get; set; }
        public DateTime NgayDatHang { get; set; }
        public bool TrangThai { get; set; }
        public string ImageUrl { get; set; }
    }
}