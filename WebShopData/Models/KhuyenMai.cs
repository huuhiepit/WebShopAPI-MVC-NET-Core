﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace WebShopData.Models
{
    public partial class KhuyenMai
    {
        public long IdKhuyenMai { get; set; }
        [Required]
        public string TenKhuyenMai { get; set; }
        [Required]
        public DateTime NgayBatDau { get; set; }
        [Required]
        public DateTime NgayKetThuc { get; set; }
        [Required]
        public long GiamGia { get; set; }
    }
}