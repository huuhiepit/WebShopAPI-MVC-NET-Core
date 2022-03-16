var url = "https://localhost:7001/api/ctsanpham";
var id = getUrlVars(window.location.href)['id'];

$(document).ready(function () {
    LoadDataCTSP(id);
    GetSelectColors();
    GetSelectSizes();
    handleCreateCtSanPham();
    Clear();
});

//Load dữ liệu chi tiết sản phẩm
function LoadDataCTSP(id) {
    $.ajax({
        url: url + '/view/' + id,
        type: 'GET',
        success: function (data) {
            var str = '';

            $.each(data, function (i, item) {
                str += `<tr id="ctsp-item-` + item.idCtsp + `">
                            <td>` + (i + 1) + `</td>
                            <td>
                                <img src="/img/products/` + item.imageUrl + `" style="width: 65px">
                            </td>
                            <td>` + item.tenSp + `</td>
                            <td>` + item.tenMauSac + `</td>
                            <td>` + item.tenSize + `</td>
                            <td>` + formatCash(item.soLuong + '') + `</td>
                            <td>
                                <a onclick=handleUpdateCtSanPham(`+ item.idCtsp + `) class=""><i class="fa-solid fa-pen-to-square" style="color: blue;"></i></a>
                            </td>
                            <td>
                                <a onclick=DeleteCtSanPham(`+ item.idCtsp + `) class=""><i class="fa-solid fa-trash-can" style="color: red;"></i></a>
                            </td>
                        </tr>`;
            });
            GetTenSP(id);
            $('#list_data_CTSP').html(str);

            $('#dataTableCTSP').DataTable();

        }
    });
}

//Xử lý tạo 1 chi tiết
function handleCreateCtSanPham() {

    var createBtn = document.querySelector("#createCTSP");

    createBtn.onclick = function () {

        var ctSanPhamObj = {};
        ctSanPhamObj.idSanPham = id;
        ctSanPhamObj.idMauSac = $("select[name='txtIdColor']").val();
        ctSanPhamObj.idSize = $("select[name='txtIdSize']").val();
        ctSanPhamObj.soLuong = $("input[name='txtSoLuong']").val();
        ctSanPhamObj.imageUrl = $("input[name='txtTenAnh']")[0].files[0].name;
        
        $.ajax({
            url: url,
            method: "POST",
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify(ctSanPhamObj),
            success: function () {
                $.notify("Thêm mới thành công", { className: "success", position: "top center" });
                UploadImg('txtTenAnh');
                $('#createCTSPModal').modal('hide');
            },
            error: function () {
                $.notify("Thêm mới thất bại", { className: "error", position: "top center" });
            }
        });
    };
}

//Xử lý sửa 1 chi tiết
function handleUpdateCtSanPham(idctsp) {
    $('#updateCTSPModal').modal('show');

    $.ajax({
        url: url + '/' + idctsp,
        type: "GET",
        success: function (data) {
            $("select[name='txtIdColorU']").val(data.idMauSac);
            $("select[name='txtIdSizeU']").val(data.idSize);
            $("input[name='txtSoLuongU']").val(data.soLuong);
            $("input[name='txtAnhU']").val(data.imageUrl);
        }   
    });

    var updateBtn = document.querySelector('#updateCTSP');

    updateBtn.onclick = function () {
        var ctSanPhamObj = {};

        ctSanPhamObj.idCtsp = idctsp;
        ctSanPhamObj.idSanPham = id;
        ctSanPhamObj.idMauSac = $("select[name='txtIdColorU']").val();
        ctSanPhamObj.idSize = $("select[name='txtIdSizeU']").val();
        ctSanPhamObj.soLuong = $("input[name='txtSoLuongU']").val();
        if ($('input[name="txtTenAnhU"]').val() == '') {
            ctSanPhamObj.imageUrl = $("input[name='txtAnhU']").val();
        }
        else {
            ctSanPhamObj.imageUrl = $('input[name="txtTenAnhU"]')[0].files[0].name;
        }

        $.ajax({
            url: url + '/' + idctsp,
            type: "PUT",
            dataType: 'json',
            contentType: 'application/json',
            data: JSON.stringify(ctSanPhamObj),
            success: function () {
                $.notify("Sửa thành công", { className: "success", position: "top center" });
                $('#updateCTSPModal').modal('hide');
                if ($("input[name='txtTenAnhU']").val() != '') {
                    UploadImg("txtTenAnhU");
                } else {
                    LoadDataCTSP(id);
                }
               
            },
            error: function () {
                $.notify("Sửa thất bại", { className: "error", position: "top center" });
            }
        });

    };
}

//Xóa 1 chi tiết
function DeleteCtSanPham(idctsp) {

    if (confirm("Bạn có muốn xóa chi tiết sản phẩm có mã: " + idctsp + " này không?")) {
        $.ajax({
            url: url + '/' + idctsp,
            type: "DELETE",
            success: function () {
                var itemCTSP = document.querySelector('#ctsp-item-' + idctsp);
                if (itemCTSP) {
                    itemCTSP.remove();
                }
                $.notify("Xóa thành công.", { className: "success", position: "top center" });
                $('#deleteCTSPModal').modal('hide');
            },
            error: function () {
                $.notify("Xóa thất bại. ", { className: "error", position: "top center" });
            }
        });
    }
}


//Hàm hỗ trợ
function GetSelectSizes() {
    $.ajax({
        url: "https://localhost:7001/api/size",
        type: 'GET',
        success: function (data) {
            var option = '<option value="">Chọn size</option>';
            $.each(data, function (i, size) {
                option += '<option value="' + size.idSize + '">' + size.tenSize + '</option>';
            });

            $("#SelectSizes").html(option);
            $("#SelectSizesU").html(option);
        }
    });
}

function GetSelectColors() {
    $.ajax({
        url: "https://localhost:7001/api/mausac",
        type: 'GET',
        success: function (data) {
            var option = '<option value="">Chọn màu sắc</option>';
            $.each(data, function (i, color) {
                option += '<option value="' + color.idMauSac + '">' + color.tenMauSac + '</option>';
            });

            $("#SelectColors").html(option);
            $("#SelectColorsU").html(option);
        }
    });
}

function Clear() {
    $("select[name='txtIdSize'").val('');
    $("select[name='txtIdColor'").val('');
    $("input[name='txtTenAnh']").val('');
    $("input[name='txtSoLuong']").val('');
}

function UploadImg(img) {

    var data = new FormData();
    var file = $('input[name="' + img + '"]')[0].files[0];

    data.append("file", file)

    $.ajax({
        url: "https://localhost:7001/api/sanpham/UploadImage",
        method: "POST",
        data: data,
        contentType: false,
        processData: false,
        success: function (data) {
            location.reload();
        },
    });
}

function getUrlVars(url) {
    var vars = {};
    var parts = url.replace(/[?&]+([^=&]+)=([^&]*)/gi, function (m, key, value) {
        vars[key] = value;
    });
    return vars;
}

//Lấy tên sản phẩm
function GetTenSP(id) {
    $.ajax({
        url: 'https://localhost:7001/api/SanPham/' + id,
        type: 'GET',
        success: function (data) {
            $("#name_CTSP").html("Quản lý chi tiết sản phẩm: " + data.tenSp);
            $("input[name='txtSanPham']").val(data.tenSp);
        }
    });
}