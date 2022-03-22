var url = "https://localhost:7001/api/khuyenmai";

$(document).ready(function () {
    LoadDataKhuyenMai();
    Clear();
    handleCreateKhuyenMai();
});

//GET KhuyenMai All

function LoadDataKhuyenMai() {
    $.ajax({
        url: url,
        type: 'GET',
        success: function (data) {
            var str = "";
            $.each(data, function (i, km) {

                str += "<tr class='khuyenmai-item-" + km.idKhuyenMai + "'>";
                    str += "<td>" + (i + 1) + "</td>";
                    str += "<td>" + km.tenKhuyenMai + "</td>";
                    str += "<td>" + km.giamGia + "</td>";
                    str += "<td>" + moment(km.ngayBatDau).format('DD-MM-YYYY') + "</td>";
                    str += "<td>" + moment(km.ngayKetThuc).format('DD-MM-YYYY') + "</td>";
                    str += "<td>";
                    str += "<a onclick='handleUpdateKhuyenMai(" + km.idKhuyenMai + ")' class=''><i class='fa-solid fa-pen-to-square' style='color: blue;'></i></a>";
                    str += "</td>";
                    str += "<td>";
                    str += "<a onclick='handleDeleteKhuyenMai(" + km.idKhuyenMai + ")' class=''><i class='fa-solid fa-trash-can' style='color: red;'></i></a>";
                    str += "</td>";
                str += "</tr>";
            });

            $('#list_Data_KhuyenMai').html(str);
            $('#dataTableKhuyenMai').DataTable();
        }
    });
}

//Create KhuyenMai

function CreateKhuyenMai() {

    var createKhuyenMaiObj = {};
    createKhuyenMaiObj.tenKhuyenMai = $('input[name="tenKhuyenMai"]').val();
    createKhuyenMaiObj.ngayBatDau = $('input[name="ngayBatDau"]').val();
    createKhuyenMaiObj.ngayKetThuc = $('input[name="ngayKetThuc"]').val();
    createKhuyenMaiObj.giamGia = $('input[name="giamGia"]').val();

    $.ajax({
        url: url,
        method: "POST",
        dataType: "json",
        contentType: "application/json",
        data: JSON.stringify(createKhuyenMaiObj),
        success: function () {

            $.notify("Thêm mới khuyến mãi thành công", { className: "success", position: "top center" });
            $('#createKhuyenMaiModal').modal('hide');
            LoadDataKhuyenMai();

        },
        error: function (error) {
            $.notify("Thêm mới khuyến mãi thất bại. Lỗi: " + error.responseText, { className: "error", position: "top center" });
        }
    });
}

function handleCreateKhuyenMai() {
    var createBtn = document.querySelector("#createKhuyenMai");

    createBtn.onclick = function () {
        CreateKhuyenMai();
        Clear();
    }
}

//Update KhuyenMai
function handleUpdateKhuyenMai(id) {


    $('#updateKhuyenMaiModal').modal('show');

    $.ajax({
        url: url + '/' + id,
        type: 'GET',
        success: function (data) {

            $('input[name="txtTenKhuyenMai"]').val(data.tenKhuyenMai);      
            $('input[name="txtNgayBatDau"]').val(moment(data.ngayBatDau).format('YYYY-MM-DD'));
            $('input[name="txtNgayKetThuc"]').val(moment(data.ngayKetThuc).format('YYYY-MM-DD'));
            $('input[name="txtGiamGia"]').val(data.giamGia);
        },
        error: function () {
        }
    });

    var updateBtn = document.querySelector("#updateKhuyenMai");

    updateBtn.onclick = function () {

        var updateKhuyenMaiObj = {};
        updateKhuyenMaiObj.idKhuyenMai = id;
        updateKhuyenMaiObj.tenKhuyenMai = $('input[name="txtTenKhuyenMai"]').val();
        updateKhuyenMaiObj.ngayBatDau = $('input[name="txtNgayBatDau"]').val();
        updateKhuyenMaiObj.ngayKetThuc = $('input[name="txtNgayKetThuc"]').val();
        updateKhuyenMaiObj.giamGia = $('input[name="txtGiamGia"]').val();

        $.ajax({
            url: url + '/' + id,
            method: "PUT",
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify(updateKhuyenMaiObj),
            success: function () {
                $.notify("Sửa khuyến mãi thành công", { className: "success", position: "top center" });
                $('#updateKhuyenMaiModal').modal('hide');
                LoadDataKhuyenMai();

            },
            error: function (error) {
                $.notify("Sửa khuyến mãi thất bại. Lỗi: " + error.responseText, { className: "error", position: "top center" });
            }
        });
    };
}

//Delete KhuyenMai
function handleDeleteKhuyenMai(id) {

    $.ajax({
        url: url + '/' + id,
        type: 'GET',
        success: function (data) {
            console.log(data.tenKhuyenMai);
            var str = 'Bạn chắc chắn muốn xóa sự kiện khuyến mãi: "' + data.tenKhuyenMai + '" này không?';
            $('#message_delete').html(str);
        },
        error: function () {
        }
    });

    $('#deleteKhuyenMaiModal').modal('show');

    var deleteBtn = document.querySelector('#deleteKhuyenMai');

    deleteBtn.onclick = function () {
        $.ajax({
            url: url + "/" + id,
            type: 'DELETE',
            contentType: 'application/json',
            success: function () {
                var kmItem = document.querySelector('.khuyenmai-item-' + id);
                if (kmItem) {
                    kmItem.remove();
                }
                $('#deleteKhuyenMaiModal').modal('hide');
                $.notify("Xóa thành công", { className: "success", position: "top center" });

            },
            error: function (error) {
                $.notify("Xóa thất bại. Lỗi: " + error.responseText, { className: "error", position: "top center" });
            }
        });
    };

}

function Clear() {
    $('input[name="tenKhuyenMai"]').val('');
    $('input[name="txtNgayBatDau"]').val('');
    $('input[name="txtNgayKetThuc"]').val('');
    $('input[name="txtGiamGia"]').val('');
}