$(document).ready(function () {
    GetProductCart();
    CongTruSoLuong();

})
//Checked
const checkAll = document.querySelector("#checkAll");

if (checkAll) {
    checkAll.addEventListener("click", () => {
        check(checkAll.checked)
    })
}

function check(action) {
    const checkItem = document.getElementsByClassName("checkItem");

    for (let i = 0; i < checkItem.length; i++) {
        checkItem[i].checked = action
    }
}

//Lấy thông tin sản phẩm trong giỏ hàng ra hiển thị
function GetProductCart() {
    var giohang = JSON.parse(localStorage.getItem('giohang')).products;
    var str = ``;
    for (let i = 0; i < giohang.length; i++) {
        str += `
            <div class="cart_item cart_item-`+ giohang[i].idCTSP +`">
                <div class="cart_item-checkbox mr-12" title="Chọn">
                    <input class="checkItem" value=`+ giohang[i].idCTSP +` type="checkbox">
                </div>
                <div class="cart_item-img mr-12" title="Ảnh sản phẩm"><img src="../img/products/`+ giohang[i].image +`" alt="sanpham.jpg" class="cart_item-img-link" ></div>
                <div class="cart_item-title mr-12">
                    <span title="Tên sản phẩm">Tên sản phẩm: `+ giohang[i].tenSanPham +`</span>
                    <span title="Size">Kích cỡ: `+ giohang[i].tenSize +`</span>
                    <span title="Màu sắc">Màu sắc: `+ giohang[i].tenMauSac +`</span>
                </div>
                <div class="cart_item-quantity">
                    <span class="sp-tru">-</span>
                    <input id="sp-soluong-`+ i +`"  type="text" value="`+ giohang[i].SoLuongMua +`" min="1" title="Số lượng mua" onKeyPress="return isNumberKey(event)">
                    <span class="sp-cong">+</span>
                </div>
                <span class="cart_item-price mr-12 ml-64" title="Giá sản phẩm" >`+ formatCash(giohang[i].Gia + '') +`₫</span>
                <span class="cart_item-price mr-12 ml-64" title="Tổng tiền" id="tong_gia-sp-`+ i +`">`+ formatCash(giohang[i].TongTien + '') +`₫</span>
                <a class="cart_item-save ml-64" onclick="SuaSoLuongMua(`+ i + `, ` + giohang[i].idCTSP +`)" title="Cập nhật giỏ hàng"><i class="fa-solid fa-pen-to-square"></i></a>
            </div>
        `;
    }
    $('#list_cart').html(str);
    $('#sum-price').html(formatCash(TongTienGioHang(giohang) + '') + '₫');
    
}

// Tổng tiền của cả giỏ hàng
function TongTienGioHang(giohang) {
    var tongtien = 0;
    for (let i = 0; i < giohang.length; i++) {
        tongtien += giohang[i].TongTien
    }
    return tongtien;
}

//Sửa số lượng mua giỏ hàng
function SuaSoLuongMua(i, id) {
    var soluongmua = document.querySelector("#sp-soluong-" + i).value;
    var cartItem = JSON.parse(localStorage.getItem("giohang"));
    if (soluongmua && soluongmua > 0) {
        for (let j = 0; j < cartItem.products.length; j++) {
            if (cartItem.products[j].idCTSP == id) {
                cartItem.products[j].SoLuongMua = soluongmua;
                cartItem.products[j].TongTien = soluongmua * cartItem.products[j].Gia;
                $('#tong_gia-sp-' + i).html(formatCash(cartItem.products[j].TongTien + '') + '₫');
                
            }
        }

        localStorage.setItem("giohang", JSON.stringify(cartItem));

        $('#sum-price').html(formatCash(TongTienGioHang(cartItem.products) + '') + '₫');
        $.notify("Cập nhật giỏ hàng thành công. ", { className: "success", position: "top center" });
    } else {
        $.notify("Số lượng mua sản phẩm phải lớn hơn 0. ", { className: "warn", position: "top center" });
    }
    
    
    
}


//Xóa sản phẩm khỏi giỏ hàng
var deleteBtn = document.querySelector("#delete_cart");

if (deleteBtn) {
    deleteBtn.addEventListener("click", () => {
        RemoveProductCart();
    })
}

function RemoveProductCart() {
    var checkItem = document.getElementsByClassName("checkItem");
    var cartItem = JSON.parse(localStorage.getItem("giohang"));

    for (let i = 0; i < checkItem.length; i++) {
        
        if (checkItem[i].checked == true) {

            for (let j = 0; j < cartItem.products.length; j++) {
                if (checkItem[i].value == cartItem.products[j].idCTSP) {
                    cartItem.products.splice(j, 1);
                    cartItem.soluong -= 1;
                    j--;
                }
            }
         
            var deleteItem = document.querySelector('.cart_item-' + checkItem[i].value);
            if (deleteItem) {
                deleteItem.remove();
            }

            i--;

            localStorage.setItem("giohang", JSON.stringify(cartItem));
        }
    }

    $('#count').html(cartItem.soluong);

    if (cartItem.soluong == 0) {
        location.href = '/Home';
    }

}


//Add Cart Modal
const modal = document.querySelector('.js-modal')
const modalClose = document.querySelector('.js-modal-close')
 
modalClose.addEventListener('click', () => {
    modal.classList.remove('open');
});

//Thanh toán

function ThanhToan() {
    if (sessionStorage.getItem('userCustomer') != null) {
        var giohang = JSON.parse(localStorage.getItem('giohang')).products;
        $("#tongtien").html("Số tiền thanh toán: " + formatCash(TongTienGioHang(giohang) + '') + '₫');
        modal.classList.add('open');
        handleDonHang();
    } else {
        $.notify("Khách hàng vui lòng đăng nhập trước khi thanh toán.", { className: "warn", position: "top center" });
        
    }
}
function handleDonHang() {
    var btnThanhToan = document.querySelector("#buy-payment");
    btnThanhToan.addEventListener('click', () => {
        if ($('input[name="txtDiaChi"').val() != '' && $('input[name="txtSDT"').val() != '') {
            var giohang = JSON.parse(localStorage.getItem('giohang')).products;
            $.ajax({
                url: "https://localhost:7001/api/khachhang/thongtin/" + username,
                type: "GET",
                success: function (khachhang) {
                    var date = new Date();
                    var donhangObj = {};
                    donhangObj.idKhachHang = khachhang.idKhachHang;
                    donhangObj.ngayDatHang = date;
                    donhangObj.diaChi = $('input[name="txtDiaChi"').val();
                    donhangObj.sdt = $('input[name="txtSDT"').val();
                    donhangObj.tongTien = TongTienGioHang(giohang);
                    donhangObj.trangThai = false;
                    CreateDonHang(donhangObj);
                }
            })
        } else {
            $.notify("Xin vui lòng không để trống các ô thông tin ", { className: "warn", position: "top center" });
        }
        
    });
    
}

//Tạo mới đơn hàng
function CreateDonHang(donhang) {
    $.ajax({
        url: "https://localhost:7001/api/DonHang",
        method: "POST",
        dataType: "json",
        contentType: "application/json",
        data: JSON.stringify(donhang),
        success: function (data) {
            var giohang = JSON.parse(localStorage.getItem('giohang')).products;

            for (let i = 0; i < giohang.length; i++) {
                var chitietdhObj = {};
                chitietdhObj.idDonHang = data.idDonHang;
                chitietdhObj.idCtsp = giohang[i].idCTSP;
                chitietdhObj.gia = giohang[i].Gia;
                chitietdhObj.soLuong = giohang[i].SoLuongMua;
                CreateChiTietDonHang(chitietdhObj);
                console.log(chitietdhObj);
            }
            let productsCart = {
                "products": [],
                "soluong": 0
            };
            localStorage.setItem("giohang", JSON.stringify(productsCart));
            $("#count").html(0)
            location.href = '/Home';
            $.notify("Cảm ơn bạn đã mua và ủng hộ shop chúng tôi. ", { className: "success", position: "top center" });
        },
        error: function (error) {
            $.notify("Lỗi: " + error.responseText, { className: "error", position: "top center" });
        }

    })
}

//Thêm chi tiết đơn hàng vào đơn hàng
function CreateChiTietDonHang(chitietdonhang) {
    $.ajax({
        url: "https://localhost:7001/api/CTDonHang",
        method: "POST",
        dataType: "json",
        contentType: "application/json",
        data: JSON.stringify(chitietdonhang),
        success: function (data) {
            
        },
        error: function (error) {
            $.notify("Lỗi: " + error.responseText, { className: "error", position: "top center" });
        }
    })
}