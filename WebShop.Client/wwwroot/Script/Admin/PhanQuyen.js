// Phan quyen

$(document).ready(function () {
    PhanQuyen();
});

function PhanQuyen() {
    if (sessionStorage.getItem("userAdmin") == null) {
        location.href = "/Admin/Login";
    } else {
        var user = sessionStorage.getItem("userAdmin");
        $.ajax({
            url: "https://localhost:7001/api/Admin/getTrangThai/" + user,
            type: "GET",
            success: function (data) {
                if (data.chucVu == true)
                    PhanQuyenAdmin();
                else PhanQuyenNhanVien();
                $('#login-name').html("Admin: " + data.hovaTen);
            }
        })
    }
}


function PhanQuyenNhanVien() {
    if (sessionStorage.getItem("userAdmin") == null) {
        location.href = "/Admin/Login";
    } else {
        $("#login-admin").css("display", "none");
        $("#register-admin").css("display", "none");
        $("#nhanvien-admin").css("display", "none");
    }
}

function PhanQuyenAdmin() {
    if (sessionStorage.getItem("userAdmin") == null) {
        location.href = "/Admin/Login";
    } else $("#login-admin").css("display", "none");
}
