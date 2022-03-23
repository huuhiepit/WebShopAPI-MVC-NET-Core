
function handleDoanhThu() {
    var dateStart = $("input[name='dateStart']").val();
    var dateEnd = $("input[name='dateEnd']").val();

    ThongKeDoanhThu(dateStart, dateEnd);
}

function ThongKeDoanhThu(date1, date2) {
    $.ajax({
        url: "https://localhost:7001/api/ThongKe/doanhthu/" + date1 + '&' + date2,
        type: "GET",
        success: (data) => {
            var doanhthu = 0;
            var str = ``;
            $.each(data, (i, item) => {
                str += `
                    <tr>
                        <td>`+(i+1)+`</td>
                        <td>`+ item.idDonHang +`</td>
                        <td>`+ moment(item.ngayDatHang).format('DD-MM-YYYY') +`</td>
                        <td>`+ formatCash(item.tongTien + '') +`₫</td>
                    </tr>`;
                doanhthu += item.tongTien;
            })

            $("#load_data_DoanhThu").html(str);
            $('#dataTableDoanhThu').DataTable();
            $('#doanhThu').html("Tổng doanh thu: " + formatCash(doanhthu + '') + '₫');
        },
        error: (error) => {
            $.notify("Lỗi: " + error.responseText, { className: "error", position: "top center" });
        }

    })
}