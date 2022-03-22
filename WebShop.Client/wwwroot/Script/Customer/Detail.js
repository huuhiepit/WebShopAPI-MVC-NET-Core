var url = 'https://localhost:7001/api/home';
const tensp = getParameterByName("sanpham");

$(document).ready(function () {
    DetailSanPham(tensp);
});

function SanPhamLienQuan(idloai) {
    $.ajax({
        url: url + '/splienquan/' + idloai,
        type: "GET",
        success: function (data) {
            var str = ``;

            $.each(data, function (i, sp) {
                str += `<a href="/Home/Detail/?sanpham=` + sp.tenSp + `" class="product-related-item">
                            <img src="/img/products/`+ sp.image + `" alt="image.jpg">
                            <p>`+ sp.tenSp + `</p>`;
                if (sp.giamGia == 0) {
                    str += `<div class="product_item-price" style="margin-bottom: 32px;">
                                <span class="product_item_price-current">` + formatCash(sp.giaBan + '') + `₫</span>
                            </div>`;
                } else {
                    str += `
                            <div class="product_item-price">
                                <span class="product_item_price-current">`+ formatCash(sp.giaBan - (sp.giaBan * sp.giamGia / 100) + '') + `₫</span>
                                <span class="product_item_price-old">` + formatCash(sp.giaBan + '') + `₫</span>
                            </div>
                            <div class="product_item-sale-off">
                                <span class="product_item-percent">Sale `+ sp.giamGia + `%</span>
                            </div>`;
                }
                str +=  `</a>`;
            });

            
            $('#product_list_lienquan').html(str);
        }
    })
}

