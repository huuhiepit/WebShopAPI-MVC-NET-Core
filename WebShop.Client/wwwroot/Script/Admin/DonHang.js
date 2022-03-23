var url = "https://localhost:7001/api/DonHang";

$(document).ready(function () {
    LoadDonHang(false);

});

//GET đơn hàng theo trạng thái
function LoadDonHang(trangthai) {
    $.ajax({
        url: url + '/trangthai/' + trangthai,
        type: "GET",
        success: function (data) {
            var str = "";
            $.each(data, function (i, dh) {
                str += "<tr class='dh-item-" + dh.idDonHang + "'>";
                str += "<td>" + (i + 1) + "</td>";
                str += "<td>" + dh.idDonHang + "</td>";
                str += "<td>" + dh.idKhachHang + "</td>";
                str += "<td>" + moment(dh.ngayDatHang).format('DD-MM-YYYY'); + "</td>";
                str += "<td>" + dh.hovaTen + "</td>";
                str += "<td>" + dh.sdt + "</td>";
                str += "<td>" + dh.diaChi + "</td>";
                str += "<td>" + formatCash(dh.tongTien + '') + "đ</td>";
                if (dh.trangThai == true) {
                    str += "<td>Đã duyệt đơn</td>";
                }
                else {
                    str += "<td><a onclick='handleDoiTrangThaiDH(" + dh.idDonHang + ")' class=''>Duyệt đơn</a></td>";
                }
                str += "<td><a onclick='ViewDonHang(" + dh.idDonHang + ")' class=''>Xem chi tiết đơn hàng</a></td>";
                str += "<td>";
                str += "<a onclick='DeleteDonHang(" + dh.idDonHang + ")' class=''><i class='fa-solid fa-trash-can' style='color: red;'></i></a>";
                str += "</td>";
                str += "</tr>";
            });

            $('#load_Data_DonHang').html(str);

            $('#dataTableDonHang').DataTable();
        }
    })
        
}

//Duyệt đơn hàng
function handleDoiTrangThaiDH(id) {
    if (confirm("Bạn có muốn duyệt đơn hàng có mã id là " + id + " này không?")) {
        var TrangThaiObj = {};
        TrangThaiObj.idDonHang = id;

        $.ajax({
            url: url + '/doitrangthai/' + id,
            method: 'PUT',
            dataType: 'json',
            contentType: 'application/json',
            data: JSON.stringify(TrangThaiObj),
            success: function () {
            },
            error: function () {
                $.notify("Duyệt đơn hàng thành công", { className: "success", position: "top center" });
                LoadDonHang(false);
            }
        });
    }
}

//Xóa đơn hàng
function DeleteDonHang(id) {

    if (confirm("Bạn có muốn xóa đơn hàng có mã: " + id + " này không?")) {
        $.ajax({
            url: url + '/' + id,
            method: "DELETE",
            contentType: 'application/json',
            success: function () {
                var dhItem = document.querySelector('.dh-item-' + id);
                if (dhItem) {
                    dhItem.remove();
                }
                $.notify("Xóa đơn hàng thành công", { className: "success", position: "top center" });
            },
            error: function (error) {
                $.notify("Xóa đơn hàng thất bại. Lỗi:" + error.responseText, { className: "error", position: "top center" });
            }
        });
    }
}

function ViewDonHang(id) {

    $('#ViewDonHangModal').modal('show');

    $('#title-ctdh').html('Chi tiết đơn hàng của mã đơn hàng: ' + id);

    $.ajax({
        url: 'https://localhost:7001/api/CTDonHang/' + id,
        type: "GET",
        success: function (data) {
            var str = ``;
            $.each(data, function (i, ctdh) {
 
                str += `
                <tr class="ctdh-item-`+ ctdh.idCtdh +`">
                    <td>`+ (i + 1) +`</td>
                    <td>
                        <img src="../img/products/`+ ctdh.imageUrl +`" style="width: 50px;">
                    </td>
                    <td>`+ ctdh.tenSp +`</td>
                    <td>`+ ctdh.tenSize +`</td>
                    <td>`+ ctdh.tenMauSac +`</td>
                    <td>`+ ctdh.soLuong + `</td>
                    <td>`+ formatCash(ctdh.gia + '') +`₫</td>
                    <td>
                        <a onclick="DeleteCTDH(`+ ctdh.idCtdh +`)" class=""><i class="fa-solid fa-trash-can" style="color: red;"></i></a>
                    </td>
                </tr>
                `;
            });

            $('#list-View-DonHang').html(str);

            $('#dataTableViewCTDH').DataTable();
        }
    })
}

function DeleteCTDH(idctdh) {
    if (confirm("Bạn có muốn xóa chi tiết đơn hàng có mã:" + idctdh +" này không")) {
        $.ajax({
            url: 'https://localhost:7001/api/CTDonHang/' + idctdh,
            method: 'DELETE',
            contentType: 'application/json',
            success: function () {
                var ctdhItem = document.querySelector('.ctdh-item-' + idctdh);
                if (ctdhItem) {
                    ctdhItem.remove();
                }
                $.notify("Xóa đơn hàng thành công", { className: "success", position: "top center" });
            },
            error: function (error) {
                $.notify("Xóa đơn hàng thất bại. Lỗi: " + error.responseText, { className: "error", position: "top center" });
            }
        });
    }
}


function TrangThaiChanged(obj) {
    var value = obj.value;
    if (value === 'False') {
        LoadDonHang(false);
    }
    else {
        LoadDonHang(true);
    }
}
