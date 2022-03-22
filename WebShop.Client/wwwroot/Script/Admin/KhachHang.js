var url = "https://localhost:7001/api/khachhang";

$(document).ready(function () {
    LoadDataKhachHang();
    //handleCreateKhachHang();
    //Reset();
});

//GET KhachHang All

function LoadDataKhachHang() {
    $.ajax({
        url: url,
        type: 'GET',
        success: function (data) {
            var str = "";
            $.each(data, function (i, kh) {
                str += "<tr class='khachhang-item-" + kh.idKhachHang + "'>";
                str += "<td>" + (i + 1) + "</td>";
                str += "<td>" + kh.hovaTen + "</td>";
                str += "<td>" + moment(kh.ngaySinh).format('DD-MM-YYYY') + "</td>";
                str += "<td>" + kh.diaChi + "</td>";
                str += "<td>" + kh.sdt + "</td>";
                str += "<td>" + kh.email + "</td>";
                str += "<td>" + kh.userName + "</td>";
                str += "<td><a onclick='LichSuMuaHang(" + kh.idKhachHang + ")' class=''><i class='fa-solid fa-eye' style='color: green;'></i></a></td>";
                str += "<td><a onclick='DeleteKhachHang(" + kh.idKhachHang + ", `" + kh.userName + "`)' class=''><i class='fa-solid fa-trash-can' style='color: red;'></i></a></td>";
                str += "</tr>";
            });
            $('#load_Data_KhachHang').html(str);

            $('#dataTableKhachHang').DataTable();
        }
    });
}

function LichSuMuaHang(id) {
    $('#LichSuMuaHangModal').modal('show');
    $.ajax({
        url: url + '/lichsumuahang/' + id,
        type: 'GET',
        success: function (data) {
            var str = ``;
            $.each(data, function (i, ls) {
                str += `
                    <tr>
                        <td>` + (i + 1) + `</td>
                        <td><img src="../img/products/` + ls.imageUrl + `" style="width: 50px;"</td>
                        <td>` + ls.tenSp + `</td>
                        <td>` + ls.tenTheLoai + `</td>
                        <td>` + ls.tenSize + `</td>
                        <td>` + ls.tenMauSac + `</td>
                        <td>` + ls.gia + `</td>
                        <td>` + ls.soLuong + `</td>
                        <td>` + ls.ngayDatHang + `</td>
                    </tr>`;
            });

            $('#list-View-LichSuMuaHang').html(str);
            $('#dataTableViewLichSu').DataTable();
        },
        error: function (error) {
            $.notify("Lỗi: " + error.responseText, { className: "error", position: "top center" });
        }
    });
}

//Xóa khách hàng
function DeleteKhachHang(id, name) {
    if (confirm("Bạn có muốn xóa tài khoản khách hàng có username là: " + name + " này không?")) {
        $.ajax({
            url: url + '/' + id,
            type: "DELETE",
            contentType: 'application/json',
            success: function () {
                var khItem = document.querySelector('.khachhang-item-' + id);
                if (khItem) {
                    khItem.remove();
                }
                $.notify("Xóa khách hàng thành công", { className: "success", position: "top center" });
            },
            error: function (error) {
                $.notify("Xóa khách hàng thất bại. Lỗi " + error.responseText, { className: "error", position: "top center" });
            }
        });
    }
}