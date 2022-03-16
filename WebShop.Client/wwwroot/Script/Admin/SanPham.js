var url = "https://localhost:7001/api/sanpham";
var date = new Date();

$(document).ready(function () {
    LoadDataProducts();
    handleCreateSP();
    LoadListLoai();
    Clear();
});

//Get All Products

function LoadDataProducts() {
    $.ajax({
        url: url + '/view',
        type: "GET",
        success: function (data) {
            var str = '';

            $.each(data, function (i, product) {
                str += `
                     <tr class="sp-item-`+ product.idSanPham + `">
                        <td> `+ (i + 1) + `</td>
                        <td>
                            <img src="../img/products/`+ product.image + `" style="width: 65px">
                        </td>
                        <td>`+ product.tenSp + `</td>
                        <td>`+ product.tenTheLoai + `</td>`
                        if (product.soLuong == null) str += `<td>0</td >`;
                        else str += `<td>` + product.soLuong + `</td >`;

                str +=`  <td>` + formatCash(product.giaNhap  + '') +`₫</td>
                        <td>`+ formatCash(product.giaBan + '') + `₫</td>
                        <td>`+ product.giamGia + `</td>
                        <td>
                            <a href="CTsanpham/?id=`+ product.idSanPham + `" class=""><i class="fa-solid fa-eye" style="color: blue;"></i></a>
                        </td>
                        <td>
                            <a onclick="handleUpdateProduct(`+ product.idSanPham +`)" class=""><i class="fa-solid fa-pen-to-square" style="color: blue;"></i></a>
                        </td>
                        <td>
                            <a onclick="DeleteProduct(`+ product.idSanPham +`)" class=""><i class="fa-solid fa-trash-can" style="color: red;"></i></a>
                        </td>
                    </tr>`;
                

            });

            $('#list_Data_Products').html(str);

            $('#dataTableProducts').DataTable();
        }
    });
}

//Create a product

function CreateProduct() {
    var creatSPObj = {};

    creatSPObj.tenSp = $('input[name="txtSanPham"]').val();
    creatSPObj.idTheLoai = $("select[name='txtTheLoai']").val();
    creatSPObj.giamGia = $('input[name="txtGiamGia"]').val();
    creatSPObj.giaNhap = $('input[name="txtGiaNhap"]').val();
    creatSPObj.giaBan = $('input[name="txtGiaBan"]').val();
    creatSPObj.image = $('input[name="txtTenAnh"]')[0].files[0].name;
    creatSPObj.ngayTao = date;

    $.ajax({
        url: url,
        method: "POST",
        dataType: "JSON",
        contentType: "application/json",
        data: JSON.stringify(creatSPObj),
        success: function () {
            $.notify("Thêm mới một sản phẩm thành công", { className: "success", position: "top center" });
            $('#createSPModal').modal('hide');
            UploadImgProduct("txtTenAnh");
            location.reload();
        },
        error: function () {
            $.notify("Thêm mới một sản phẩm thất bại: ", { className: "error", position: "top center" });
        }

    });
}


function handleCreateSP() {

    var createSPBtn = document.querySelector("#createSP");;

    createSPBtn.onclick = function () {
        CreateProduct();
    };
}

//Update a product
function handleUpdateProduct(id) {


    $("#updateSPModal").modal('show');

    $.ajax({
        url: url + '/' + id,
        type: "GET",
        success: function (data) {
            $('input[name="txtSanPhamUpload"]').val(data.tenSp);
            $("select[name='txtTheLoaiUpload']").val(data.idTheLoai);
            $("input[name='txtGiamGiaUpload']").val(data.giamGia);
            $("input[name='txtGiaNhapUpload']").val(data.giaNhap);
            $("input[name='txtGiaBanUpload']").val(data.giaBan);
            $("input[name='txtAnhUpload']").val(data.image);
        }
    });

    var btnUpdate = document.querySelector("#updateSP");

    btnUpdate.onclick = function () {
        var updateProductObj = {};
        updateProductObj.idSanPham = id;
        updateProductObj.tenSp = $('input[name="txtSanPhamUpload"]').val();
        updateProductObj.idTheLoai = $("select[name='txtTheLoaiUpload']").val();
        if ($("input[name='txtTenAnhUpload']").val() == '') {
            updateProductObj.image = $("input[name='txtAnhUpload']").val();
        } else {
            updateProductObj.image = $('input[name="txtTenAnhUpload"]')[0].files[0].name;
        }
        updateProductObj.giaNhap = $("input[name='txtGiaNhapUpload']").val();
        updateProductObj.giaBan = $("input[name='txtGiaBanUpload']").val();
        updateProductObj.giamGia = $("input[name='txtGiamGiaUpload']").val();
        updateProductObj.ngayTao = date;

        $.ajax({
            url: url + '/' + id,
            method: "PUT",
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify(updateProductObj),
            success: function () {
                $.notify("Sửa sản phẩm thành công", { className: "success", position: "top center" });
                $('#updateSPModal').modal('hide');
                if ($("input[name='txtTenAnhUpload']").val() != '') {
                    UploadImgProduct("txtTenAnhUpload");                  
                }
                LoadDataProducts();
                Clear();
            },
            error: function () {
                $.notify("Sửa sản phẩm thất bại ", { className: "error", position: "top center" });
            }
        });
    };
}

//Delete a product

function DeleteProduct(id) {

    if (confirm("Bạn có muốn xóa sản phẩm: " + id + " này không?")) {
        $.ajax({
            url: url + "/" + id,
            type: 'DELETE',
            contentType: 'application/json',
            success: function () {
                var spItem = document.querySelector('.sp-item-' + id);
                if (spItem) {
                    spItem.remove();
                }
                $.notify("Xóa sản phẩm thành công", { className: "success", position: "top center" });

            },
            error: function (error) {
                $.notify("Xóa sản phẩm thất bại", { className: "error", position: "top center" });
            }
        });
    }

}


//Function cover products
function UploadImgProduct(img) {

    var data = new FormData();
    var file = $('input[name="' + img + '"]')[0].files[0];

    data.append("file", file)

    $.ajax({
        url: url + "/UploadImage",
        method: "POST",
        data: data,
        contentType: false,
        processData: false,
        success: function (data) {
            location.reload();
        },
    });
}

function LoadListLoai() {
    $.ajax({
        url: "https://localhost:7001/api/theloai",
        type: 'GET',
        success: function (data) {
            var option = '<option value="">Chọn thể loại</option>';

            $.each(data, function (i, loai) {
                option += '<option value="' + loai.idTheLoai + '">' + loai.tenTheLoai + '</option>';
            });

            $("#txtTheLoai").html(option);
            $("#txtTheLoaiUpload").html(option);
        }
    });
}

//Ghi số lượng sản phẩm
function GetSLProduct(id) {
    $.ajax({
        url: "https://localhost:7001/api/CTSanPham/SumProduct/" + id,
        type: 'GET',
        success: function (data) {
            return data;
        }
    });
}

//Clear thẻ input
function Clear() {
    $('input[name="txtSanPham"]').val('');
    $("select[name='txtTheLoai']").val('');
    $("input[name='txtGiamGia']").val('');
    $("input[name='txtGiaNhap']").val('');
    $("input[name='txtGiaBan']").val('');
    $("input[name='txtTenAnh']").val('');
}