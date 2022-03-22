const { error } = require("jquery");

var url = "https://localhost:7001/api/admin";
var date = new Date();
$(document).ready(function () {
    LoadDataAdmin();
    Clear();
});

//GET Admin All

function LoadDataAdmin() {
    $.ajax({
        url: url,
        type: 'GET',
        success: function (data) {
            var str = "";
            $.each(data, function (i, ad) {
                str += "<tr class='admin-item-" + ad.idAdmin + "'>";
                str += "<td>" + (i + 1) + "</td>";
                str += "<td>" + ad.hovaTen + "</td>";
                str += "<td>" + ad.diaChi + "</td>";
                str += "<td>" + ad.sdt + "</td>";
                str += "<td>" + ad.email + "</td>";
                str += "<td>" + ad.userName + "</td>";
                if (ad.chucVu == true) {
                    str += "<td>Quản lý</td>";
                }
                else {
                    str += "<td>Nhân viên</td>";
                }
                str += "<td>";
                str += "<a onclick='handleUpdateAdmin(" + ad.idAdmin +")' class=''><i class='fa-solid fa-pen-to-square' style='color: blue;'></i></a>";
                str += "</td>";
                str += "<td>";
                str += "<a onclick='DeleteAdmin(" + ad.idAdmin + ",`" + ad.hovaTen + "`)' class=''><i class='fa-solid fa-trash-can' style='color: red;'></i></a>";
                str += "</td>";
                str += "</tr>";
            });


            $('#load_Data_Admin').html(str);

            $('#dataTable-Admin').DataTable();
        }
    });
}

    //Update Admin
function handleUpdateAdmin(id) {

    $.ajax({
        url: url + '/' + id,
        type: 'GET',
        success: function (data) {

            $('input[name="txtHovaTen"]').val(data.hovaTen);

            $('input[name="txtDiaChi"]').val(data.diaChi);

            $('input[name="txtSdt"]').val(data.sdt);

            $('input[name="txtEmail"]').val(data.email);

            $('input[name="txtUserName"]').val(data.userName);

            $('input[name="txtPassWord"]').val(data.passWord);

            if (data.chucVu == true) {
                $('select[name="txtChucVu"]').val("Quản lý");
            } else $('select[name="txtChucVu"]').val("Nhân viên");
        },
        error: function (error) {
            $.notify("Lỗi: " + error.responseText, { className: "error", position: "top center" });
        }
    });

    $('#updateAdminModal').modal('show');

    var updateBtn = document.querySelector("#updateAdmin");

    updateBtn.onclick = function () {
        var updateAdminObj = {};
        updateAdminObj.idAdmin = id;
        updateAdminObj.hovaTen = $('input[name="txtHovaTen"]').val();
        updateAdminObj.diaChi = $('input[name="txtDiaChi"]').val();
        updateAdminObj.sdt = $('input[name="txtSdt"]').val();
        updateAdminObj.email = $('input[name="txtEmail"]').val();
        updateAdminObj.userName = $('input[name="txtUserName"]').val();
        updateAdminObj.passWord = $('input[name="txtPassWord"]').val();
        if ($('select[name="txtChucVu"]').val() == "Quản lý") {
            updateAdminObj.chucVu = true;
        } else updateAdminObj.chucVu = false;
        updateAdminObj.ngayTao = date;

        $.ajax({
            url: url + '/' + id,
            method: "PUT",
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify(updateAdminObj),
            success: function () {
                $.notify("Sửa thành công!", { className: "success", position: "top center" });
                $('#updateAdminModal').modal('hide');
                LoadDataAdmin();
            },
            error: function (error) {
                $.notify("Sửa thất bại!. Lỗi " + error.responseText, { className: "error", position: "top center" });
            }
        });
    }
}

//Delete Admin
function DeleteAdmin(id, name) {

    if (confirm('Bạn có chắc chắn muốn xóa nhân viên: ' + name + ' này không?')) {
        $.ajax({
            url: url + "/" + id,
            type: 'DELETE',
            contentType: 'application/json',
            success: function () {
                var adminItem = document.querySelector('.admin-item-' + id);
                if (adminItem) {
                    adminItem.remove();
                    LoadDataAdmin();
                }
                $('#deleteAdminModal').modal('hide');
                $.notify("Xóa tài khoản admin thành công. ", { className: "success", position: "top center" });

            },
            error: function () {
                $.notify("Xóa tài khoản admin thất bại. Lỗi: " + error.responseText, { className: "error", position: "top center" });
            }
        });
    }
}

function Clear() {
    $('input[name="txtHovaTen"]').val('');
    $('input[name="txtDiaChi"]').val('');
    $('input[name="txtSdt"]').val('');
    $('input[name="txtEmail"]').val('');
    $('input[name="txtUserName"]').val('');
    $('input[name="txtPassWord"]').val('');
    $('select[name="txtChucVu"]').val('');
}
