﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace WebShopData.Models
{
    public partial class TheLoai
    {
        public TheLoai()
        {
            SanPham = new HashSet<SanPham>();
        }

        public long IdTheLoai { get; set; }
        [Required]
        public string TenTheLoai { get; set; }

        public virtual ICollection<SanPham> SanPham { get; set; }
    }
}