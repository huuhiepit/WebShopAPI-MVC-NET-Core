﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace WebShopData.Models
{
    public partial class Size
    {
        public Size()
        {
            ChiTietSanPham = new HashSet<ChiTietSanPham>();
        }

        public long IdSize { get; set; }
        public string TenSize { get; set; }

        public virtual ICollection<ChiTietSanPham> ChiTietSanPham { get; set; }
    }
}