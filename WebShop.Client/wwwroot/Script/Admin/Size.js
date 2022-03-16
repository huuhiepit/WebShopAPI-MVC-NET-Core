var url = "https://localhost:7001/api/size";

$(document).ready(function () {
    LoadDataSize();
    Clear();
    handleCreateSize();
});

function LoadDataSize() {
    
    $.ajax({
        url: url,
        type: 'GET',
        success: function (data) {

            var str = '';
            $.each(data, function (i, size) {
                str += "<tr class='size-item-" + size.idSize + "'>";
                str += "<td>" + (i + 1) + "</td>";
                str += "<td>" + size.tenSize + "</td>";
                str += "<td>";
                str += "<a onclick='handleUpdateSize(" + size.idSize + ")' class=''><i class='fa-solid fa-pen-to-square' style='color: blue;'></i></a>";
                str += "</td>";
                str += "<td>";
                str += "<a onclick='handleDeleteSize(" + size.idSize + ")' class=''><i class='fa-solid fa-trash-can' style='color: red;'></i></a>";
                str += "</td>";
                str += "</tr>";
            });

            $('#list_data_Size').html(str);
            $('#dataTableSize').DataTable();
        }
    });
}

//Create Size

function CreateSize() {
    var createSizeObj = {};
    createSizeObj.tenSize = $('input[name="tenSize"]').val();
    $.ajax({
        url: url,
        method: "POST",
        dataType: "json",
        contentType: "application/json",
        data: JSON.stringify(createSizeObj),
        success: function () {
            $.notify("Thêm mới size thành công", { className: "success", position: "top center" });
            $('#createSizeModal').modal('hide');
            LoadDataSize();
        },
        error: function (response) {
            $.notify("Thêm mới size thất bại: " + error.TenSize, { className: "error", position: "top center" });
        }
    });
}

function handleCreateSize() {
    var createBtn = document.querySelector("#createSize");

    createBtn.onclick = function () {
        CreateSize();
        Clear();
    }
}

//Update Size
function handleUpdateSize(id) {
    $('#updateSizeModal').modal('show');
    $.ajax({
        url: url + '/' + id,
        type: 'GET',
        success: function (data) {
            $('input[name="txtTenSize"]').val(data.tenSize);
        },
        error: function (error) {
            alert(error);
        }
    });

    var updateBtn = document.querySelector("#updateSize");

    updateBtn.onclick = function () {
        var updateSizeObj = {};
        updateSizeObj.idSize = id;
        updateSizeObj.tenSize = $('input[name="txtTenSize"]').val();
        $.ajax({
            url: url + '/' + id,
            method: "PUT",
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify(updateSizeObj),
            success: function () {
                $.notify("Sửa size thành công", { className: "success", position: "top center" });
                $('#updateSizeModal').modal('hide');
                LoadDataSize();
            },
            error: function (error) {
                $.notify("Sửa size thất bại: " + error, { className: "error", position: "top center" });
            }
        });
    };
}


//Delete Size
function handleDeleteSize(id) {

    $.ajax({
        url: url + '/' + id,
        type: 'GET',
        success: function (data) {
            var str = 'Liệu bạn có muốn xóa size ' + data.tenSize + ' này không?';
            $('#message_delete').html(str);
        },
        error: function (error) {
            alert(error);
        }
    });

    $('#deleteSizeModal').modal('show');

    var deleteBtn = document.querySelector('#deleteSize');

    deleteBtn.onclick = function () {
        $.ajax({
            url: url + "/" + id,
            type: 'DELETE',
            contentType: 'application/json',
            success: function () {
                var sizeItem = document.querySelector('.size-item-' + id);
                if (sizeItem) {
                    sizeItem.remove();
                }
                $('#deleteSizeModal').modal('hide');
                $.notify("Xóa size thành công", { className: "success", position: "top center" });

            },
            error: function (error) {
                $.notify("Xóa size thất bại: " + error, { className: "error", position: "top center" });
            }
        });
    };
}

function Clear() {
    $('input[name="tenSize"]').val('');
}
