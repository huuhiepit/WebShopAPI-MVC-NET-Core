$(document).ready(function () {
    ListItemNavbar();
 
});

//Kiểm tra giỏ hàng đã có chưa?
if (localStorage.getItem("giohang") == null) {
    let productsCart = {
        "products": [],
        "soluong": 0   
    };
    localStorage.setItem("giohang", JSON.stringify(productsCart));
    $("#count").html(0)
} else {
    $("#count").html(JSON.parse(localStorage.getItem("giohang")).soluong)
}

//Danh mục loại sản phẩm
function ListItemNavbar() {
    $.ajax({
        url: "https://localhost:7001/api/theloai",
        type: 'GET',
        success: function (data) {
            str = ``;
            $.each(data, function (i, item) {
                str += `
                        <li class="header__navbar-item">
                            <a href="/?theloai=` + item.tenTheLoai + `&page=1" class="header__swtich-menu-item-link-category-li">` + item.tenTheLoai + `</a>
                        </li>
                      `;
            });
            $('#navbar-header').html(str);
        }
    });
}


//Xem chi tiết sản phẩm theo tên sản phẩm
function DetailSanPham(name) {
    $.ajax({
        url: url + "/xemchitiet/" + name,
        type: 'GET',
        success: function (data) {
            var list = data.list_ctsp;
            var sanpham = data.sanpham;
            var str_listImg = `<img onclick="changeImage('` + sanpham.image + `')" src="/img/products/` + sanpham.image + `" alt="image.jpg">`;
            var str_listSize = ``;
            var str_listMauSac = ``;

            $('#product_link').attr('href', '/Home/Detail/?sanpham=' + sanpham.tenSp);
            $('#product_link').html(sanpham.tenSp);
            $('#product_name').html(sanpham.tenSp);

            var str_price = `Giá tiền:`;
            if (sanpham.giamGia > 0) {
                str_price += `
                        <span class="product_detail_price-current">`+ formatCash(sanpham.giaBan - (sanpham.giaBan * sanpham.giamGia / 100) + '') + `</span>
                        <span class="product_detail_price-old">` + formatCash(sanpham.giaBan + '') + `₫</span>
                        <span class="product_detail_sale">Giảm sốc `+ sanpham.giamGia + `%</span>  `;
            } else {
                str_price += `<span class="product_detail_price-current">` + formatCash(sanpham.giaBan + '') + `</span>`
            }
            $('#product_price').html(str_price);


            $('#product_detail-img').attr('src', '/img/products/' + sanpham.image);

            $.each(list, function (i, sp) {
                str_listImg += `<img onclick="changeImage('` + sp.imageUrl + `')" src="/img/products/` + sp.imageUrl + `" alt="image.jpg">`

                //Xét tên size hoặc tên màu sắc có bị trùng lặp không?
                if (list[i + 1] != null) {
                    if (list[i].tenSize != list[i + 1].tenSize) {
                        str_listSize += `<input class="checkbox-size" name="size" id="size-` + sp.idSize + `" type="radio" value="` + sp.tenSize + `">
                                        <label class="checkbox-size" for="size-` + sp.idSize + `"><span>` + sp.tenSize + `</span></label>`;
                    }
                    if (list[i].tenMauSac != list[i + 1].tenMauSac) {
                        str_listMauSac += `<input class="checkbox-color" name="color" id="color-` + sp.idMauSac + `" type="radio" value="` + sp.tenMauSac + `">
                                        <label class="checkbox-color" for="color-` + sp.idMauSac + `">
                                            <img onclick="changeImage('` + sp.imageUrl + `')" src="/img/products/` + sp.imageUrl + `" alt="image.jpg" title="Màu ` + sp.tenMauSac + `">
                                        </label>`;

                    }
                } else {
                    str_listSize += `<input class="checkbox-size" name="size" id="size-` + sp.idSize + `" type="radio" value="` + sp.tenSize + `">
                                    <label class="checkbox-size" for="size-` + sp.idSize + `"><span>` + sp.tenSize + `</span></label>`;
                    str_listMauSac += `<input class="checkbox-color" name="color" id="color-` + sp.idMauSac + `" type="radio" value="` + sp.tenMauSac + `">
                                        <label class="checkbox-color" for="color-` + sp.idMauSac + `">
                                            <img onclick="changeImage('` + sp.imageUrl + `')" src="/img/products/` + sp.imageUrl + `" alt="image.jpg" title="Màu ` + sp.tenMauSac + `">
                                        </label>`;
                }


            });

            var str_action = `
                    <a onclick="AddCart('`+name+`')">Thêm vào giỏ hàng</a>
                    <a href="#">Mua ngay</a>`;

            $("#sp-soluong-0").val(1);
            $('#product_list-img').html(str_listImg);
            $('#product_list-size').html(str_listSize);
            $('#product_list-mausac').html(str_listMauSac);
            $('#action_cart').html(str_action);
            const SPlienquan = document.getElementById("product_list_lienquan");
            if (SPlienquan) {
                SanPhamLienQuan(sanpham.idTheLoai);
            }

        }
    });
}


//Add Cart

function AddCart(name) {

    if (SizeChecked() != undefined && ColorChecked() != undefined) {
        $.ajax({
            url: url + "/xemchitiet/" + name,
            type: "GET",
            success: (data) => {
                var productCartObj = {};
                var list_ctsp = data.list_ctsp;
                var sanpham = data.sanpham;
                const Gia = formatNumber(document.getElementsByClassName("product_detail_price-current")[0].textContent);
                const SoLuongMua = document.getElementsByName("soluongMua")[0].value;

                const tongtien = Gia * SoLuongMua;
                $.each(list_ctsp, function (i, item) {
                    if (item.tenSize == SizeChecked() && item.tenMauSac == ColorChecked()) {
                        productCartObj.idCTSP = item.idCtsp;
                        productCartObj.image = item.imageUrl;

                    }
                });

                productCartObj.tenSanPham = name;
                productCartObj.tenSize = SizeChecked();
                productCartObj.tenMauSac = ColorChecked();
                productCartObj.Gia = Gia;
                productCartObj.SoLuongMua = SoLuongMua;
                productCartObj.TongTien = Gia * SoLuongMua;

                setItems(productCartObj);
            }
        })
        
    } else {
        $.notify("Xin vui lòng chọn size và màu sắc sản phẩm. ", { className: "error", position: "top center" });
    } 
}

//Hàm thêm sản phẩm vào giỏ hàng
function setItems(product) {
    var cartItems = JSON.parse(localStorage.getItem('giohang'));

    if (cartItems != null) {
        if (CheckProductCart(product.idCTSP) == true) {
            $.notify("Sản phẩm đã có trong giỏ hàng. ", { className: "info", position: "top center" });
        } else {
            cartItems.products.push(product);
            cartItems.soluong += 1;
            $("#count").html(cartItems.soluong)
            $.notify("Thêm sản phẩm vào giỏ hàng thành công. ", { className: "success", position: "top center" });
        }
    }
    localStorage.setItem("giohang", JSON.stringify(cartItems));
}

//Hàm kiểm tra sản phẩm đã có trong giỏ hàng chưa?
function CheckProductCart(idCTSP) {
    const giohang = JSON.parse(localStorage.getItem('giohang')).products;
    for (let i = 0; i < giohang.length; i++) {
        if (giohang[i].idCTSP == idCTSP) {
            return true;
        }
    }
    return false;
}


//--------------------------------------------------------
function SizeChecked() {
    const sizeCheck = document.getElementsByName("size");

    for (let i = 0; i < sizeCheck.length; i++) {
        if (sizeCheck[i].checked == true) {
            return sizeCheck[i].value;
        }
    }
}
function ColorChecked() {
    const colorCheck = document.getElementsByName("color");

    for (let i = 0; i < colorCheck.length; i++) {
        if (colorCheck[i].checked == true) {
            return colorCheck[i].value;
        }
    }
}



if (sessionStorage.getItem("userCustomer") != null) {
    var username = sessionStorage.getItem("userCustomer");
    $.ajax({
        url: "https://localhost:7001/api/khachhang/thongtin/" + username,
        type: "GET",
        success: function (khachhang) {
            var str = `<p class="header__navbar-item-link" >                   
                    <span class="header__navbar-span"><i class="header__navbar-icon fa-solid fa-circle-user"></i> Xin chào: `+ khachhang.hovaTen +`</span>
                </p>`;
            $("#Account").html(str);
            $('input[name="txtHovaTen"').val(khachhang.hovaTen);
        }  
    })
    
} else {
    var str = `<a href="/Home/Login" class="header__navbar-item-link" >              
                <span class="header__navbar-span"><i class="fa-solid fa-circle-user"></i> Tài khoản</span>
            </a>`;

    $("#Account").html(str);
}
