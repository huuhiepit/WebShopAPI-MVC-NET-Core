var url = "https://localhost:7001/api/theloai";

$(document).ready(function () {
    LoadDataLoai();
    handleCreateLoai();
    Clear();
});

//Get All The loai

function LoadDataLoai() {
    $.ajax({
        url: url,
        type: 'GET',
        success: function (data) {
            var str = "";
            $.each(data, function (i, loai) {
                str += '<tr class="loai-item-' + loai.idTheLoai + '">';
                str +=  '<td>' + (i + 1) + '</td>';
                str +=  '<td>' + loai.tenTheLoai + '</td>';
                str +=  '<td>';
                str +=  '<a onclick="handleUpdateLoai(' + loai.idTheLoai + ')" class=""><i class="fa-solid fa-pen-to-square" style="color: blue;"></i></a>';
                str +=  '</td>';
                str +=  '<td>';
                str +=  '<a onclick="handleDeleteLoai(' + loai.idTheLoai + ')" class=""><i class="fa-solid fa-trash-can" style="color: red;"></i></a>';
                str +=  '</td>';
                str += '</tr>';
            });

            $('#list_data_Loai').html(str);
            $('#dataTableLoai').DataTable();
        }
    });
}

//Create the loai

function CreateLoai() {
    var createLoaiObj = {};
    createLoaiObj.tenTheLoai = $('input[name="tenLoai"]').val();
    $.ajax({
        url: url,
        method: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        data: JSON.stringify(createLoaiObj),
        success: function () {
            $('#createLoaiModal').modal('hide');
            $.notify("Thêm thể loại sản phẩm thành công", { className: "success", position: "top center" });
            LoadDataLoai();
        },
        error: function () {
            
            $.notify("Thêm thể loại sản phẩm thất bại.", { className: "error", position: "top center" });
        }
    });
    
}

function handleCreateLoai() {
    var createBtn = document.querySelector("#createLoai");

    createBtn.onclick = function () {
        CreateLoai();
        Clear();
        LoadDataLoai();
    }
}
// Update Loai

function handleUpdateLoai(id) {

    $.ajax({
        url: url + '/' + id,
        type: 'GET',
        success: function (data) {
            $('input[name="txtLoai"]').val(data.tenTheLoai);
        },
        error: function (error) {
            alert(error);
        }
    });

    $('#updateLoaiModal').modal('show');

    var updateBtn = document.querySelector('#updateLoai');

    updateBtn.onclick = function () {

        var updateLoaiObj = {};
        updateLoaiObj.idTheLoai = id;
        updateLoaiObj.tenTheLoai = $('input[name="txtLoai"]').val();

        $.ajax({
            url: url + '/' + id,
            method: "PUT",
            dataType: 'json',
            contentType: 'application/json',
            data: JSON.stringify(updateLoaiObj),
            success: function () {
                $.notify("Sửa tên thể loại thành công", { className: "success", position: "top center" });
                $('#updateLoaiModal').modal('hide');
                LoadDataLoai();
            },
            error: function () {
                $.notify("Sửa tên thể loại thất bại. ", { className: "success", position: "top center" })
            }
        });
    };
}

// Delete Loai

function handleDeleteLoai(id) {
    $.ajax({
        url: url + '/' + id,
        type: 'GET',
        success: function (data) {
            var str = "Bạn có muốn xóa thể loại: '" + data.tenTheLoai + "' này không?";
            $('#message_delete').html(str);
        },
        error: function (error) {
            alert(error);
        }
    });

    $('#deleteLoaiModal').modal('show');
    var deleteBtn = document.querySelector('#deteleLoai');

    deleteBtn.onclick = function () {
        $.ajax({
            url: url + '/' + id,
            type: 'DELETE',
            contentType: 'application/json',
            success: function () {

                var loaiItem = document.querySelector('.loai-item-' + id)
                if (loaiItem) {
                    loaiItem.remove();
                }
                $('#deleteLoaiModal').modal('hide');
                $.notify("Xóa thể loại thành công", { className: "success", position: "top center" });
            },
            error: function () {
                $.notify("Xóa thể loại thất bại.", { className: "error", position: "top center" });
            }
        });
    };
}

function Clear() {
    $('input[name="tenLoai"]').val('');
}