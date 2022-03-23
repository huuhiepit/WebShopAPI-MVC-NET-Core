$(document).ready(() => {
    
});


//Danh sách lịch sử mua hàng
function LichSuMuaHang(id) {
    $.ajax({
        url: "https://localhost:7001/api/KhachHang/xemlichsumuahang/" + id,
        type: "GET",
        success: (data) => {
            var str = ``;
            $.each(data, (i, item) => {
                str += `
                    <tr class="history-body">
                        <td>`+ (i + 1) + `</td>
                        <td><img src="../img/products/`+ item.imageUrl + `" alt="" class=""></td>
                        <td>`+ item.tenSp + `</td>
                        <td>`+ item.tenSize + `</td>
                        <td>Màu `+ item.tenMauSac + `</td>
                        <td>`+ formatCash(item.gia + '') + `₫</td>
                        <td>`+ formatCash(item.soLuong + '') + `</td>
                        <td>`+ formatCash((item.gia * item.soLuong) + '') + `₫</td>
                        <td>`+ moment(item.ngayDatHang).format('DD-MM-YYYY') + `</td>`;
                if (item.trangThai == true) {
                    str += `<td>Đã thanh toán</td>
                    </tr>`;
                } else {
                    str += `<td>Đang chờ xử lý</td>
                    </tr>`;
                } 
            })

            $('#list_LSMH').html(str);
        }
    })
}

if (sessionStorage.getItem("userCustomer") != null) {
    $.ajax({
        url: "https://localhost:7001/api/khachhang/thongtin/" + username,
        type: "GET",
        success: function (khachhang) {
            LichSuMuaHang(khachhang.idKhachHang);
        }
    })
}