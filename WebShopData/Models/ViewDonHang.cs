﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace WebShopData.Models
{
    public partial class ViewDonHang
    {
        public long IdDonHang { get; set; }
        public long IdKhachHang { get; set; }
        public string HovaTen { get; set; }
        public DateTime NgayDatHang { get; set; }
        public string DiaChi { get; set; }
        public string Sdt { get; set; }
        public bool TrangThai { get; set; }
    }
}