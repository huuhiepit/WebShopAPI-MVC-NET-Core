var url = "https://localhost:7001/api/mausac";

$(document).ready(function () {
    LoadDataColor();
    Clear();
    handleCreateColor();
});

//GET Size MauSac All

function LoadDataColor() {
    $.ajax({
        url: url,
        type: 'GET',
        success: function (data) {
            var str = "";
            $.each(data, function (i, mau) {
                str += "<tr class='mau-item-" + mau.idMauSac + "'>";
                    str += "<td>" + (i + 1) + "</td>";
                    str += "<td>" + mau.tenMauSac + "</td>";
                    str += "<td>";
                    str += "<a onclick='handleUpdateColor(" + mau.idMauSac + ")' class=''><i class='fa-solid fa-pen-to-square' style='color: blue;'></i></a>";
                    str += "</td>";
                    str += "<td>";
                    str += "<a onclick='handleDeleteColor(" + mau.idMauSac + ")' class=''><i class='fa-solid fa-trash-can' style='color: red;'></i></a>";
                    str += "</td>";
                str += "</tr>";
            });

            $('#list_Data_Colors').html(str);
            $('#dataTableColor').DataTable();
        }
    });
}

//Create MauSac

function CreateColor() {
    var createMauSacObj = {};
    createMauSacObj.tenMauSac = $('input[name="tenMauSac"]').val();
    $.ajax({
        url: url,
        method: "POST",
        dataType: "json",
        contentType: "application/json",
        data: JSON.stringify(createMauSacObj),
        success: function () {
            $.notify("Thêm mới thành công", { className: "success", position: "top center" });
            $('#createColorModal').modal('hide');
            LoadDataColor();
        },
        error: function (error) {
            $.notify("Thêm mới thất bại. Lỗi: " + error.responseText, { className: "error", position: "top center" });
        }
    });
}

function handleCreateColor() {
    var createBtn = document.querySelector("#createColor");

    createBtn.onclick = function () {
        CreateColor();
        Clear();
    }
}

//Update MauSac
function handleUpdateColor(id) {
    $('#updateColorModal').modal('show');
    $.ajax({
        url: url + '/' + id,
        type: 'GET',
        success: function (data) {
            $('input[name="txtTenMauSac"]').val(data.tenMauSac);
        },
        error: function (error) {
            $.notify("Lỗi: " + error.responseText, { className: "error", position: "top center" });
        }
    });

    var updateBtn = document.querySelector("#updateColor");

    updateBtn.onclick = function () {
        var updateColorObj = {};
        updateColorObj.idMauSac = id;
        updateColorObj.tenMauSac = $('input[name="txtTenMauSac"]').val();
        $.ajax({
            url: url + '/' + id,
            method: "PUT",
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify(updateColorObj),
            success: function () {
                $.notify("Sửa thành công", { className: "success", position: "top center" });
                $('#updateColorModal').modal('hide');
                LoadDataColor();
            },
            error: function (error) {
                $.notify("Sửa thất bại. Lỗi: " + error.responseText, { className: "error", position: "top center" });
            }
        });
    };
}

//Delete MauSac
function handleDeleteColor(id) {

    $.ajax({
        url: url + '/' + id,
        type: 'GET',
        success: function (data) {
            var str = 'Bạn có chắc chắn muốn xóa màu: "' + data.tenMauSac + '" này không?';
            $('#message_delete').html(str);
        },
        error: function (error) {
            $.notify("Xóa thất bại. Lỗi: " + error.responseText, { className: "error", position: "top center" });
        }
    });

    $('#deleteColorModal').modal('show');

    var deleteBtn = document.querySelector('#deleteColor');

    deleteBtn.onclick = function () {
        $.ajax({
            url: url + "/" + id,
            type: 'DELETE',
            contentType: 'application/json',
            success: function () {
                var mauItem = document.querySelector('.mau-item-' + id);
                if (mauItem) {
                    mauItem.remove();
                }
                $('#deleteColorModal').modal('hide');
                $.notify("Xóa thành công.", { className: "success", position: "top center" });

            },
            error: function (error) {
                $.notify("Xóa thất bại. " + error.responseText, { className: "error", position: "top center" });
            }
        });
    };
}

function Clear() {
    $('input[name="tenMauSac"]').val('');
}

