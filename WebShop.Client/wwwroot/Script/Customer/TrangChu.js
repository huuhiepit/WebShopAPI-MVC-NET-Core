var url = 'https://localhost:7001/api/home';

const key = getParameterByName('search');
const loai = getParameterByName('theloai');
const pageNumber = getUrlVars(window.location.href)['page']


$(document).ready(function () {
    if (key) {
        Search(key, pageNumber);
    }
    if (loai) {
        SearchLoai(loai, pageNumber);
    }
    if (!key && !loai) {
        if (pageNumber) {
            GetListProductsPage(pageNumber);
        } else {
            GetListProductsPage(1);
        }
    }
});

//Get List PageNumber

function GetListProductsPage(pageNumber) {
    $.ajax({
        url: url + /page/ + pageNumber,
        type: "GET",
        success: function (data) {
            $('#title_theloai').html("Danh sách sản phẩm");
            ProductsItem(data.listPage);
            page(pageNumber, data.pageMax);
        },
        error: function () {
            $('#title_theloai').html("Chưa có sản phẩm nào!!!");
        }
    });

}


function page(number, maxPage) {
    var str = ``;
    if (number > 1) {
        str = `<li><a href="/?page=` + (number - 1) + `">«</a></li>`;
    }
    var array = pagination(number, maxPage);
    array.forEach(element => {
        if (element == number) {
            str += `<li><a class="active" href="/?page=` + element + `">` + element + `</a></li>`;
        } else {
            str += `<li><a href="/?page=` + element + `">` + element + `</a></li>`;
        }

    });
    if (number < maxPage) {
        number++;
        str += `<li><a href="/?page=` + number + `">»</a></li>`;
    }
    document.getElementById('pagination').innerHTML = str;
}


//Search

function Search(key, pageNumber) {
    $.ajax({
        url: url + '/search/' + key + '&' + pageNumber,
        type: 'GET',
        success: function (data) {
            $('#title_theloai').html("Danh sách sản phẩm tìm kiếm được");
            $('input[name="search"]').val(key);
            ProductsItem(data.listPage);
            pageSearch(key, pageNumber, data.pageMax);
        },
        error: function () {
            $('#title_theloai').html("Không tìm thấy sản phẩm nào!!!");
        }
    });
}


function pageSearch(key ,number, maxPage) {
    var str = ``;
    if (number > 1) {
        str = `<li><a href="/?search=` + key + `&page=` + (number - 1) + `">«</a></li>`;
    }
    var array = pagination(number, maxPage);
    
    array.forEach(element => {
        if (element == number) {
            str += `<li><a class="active" href="/?search=` + key + `&page=` + element + `">` + element + `</a></li>`;
        } else {
            str += `<li><a href="/?search=` + key + `&page=` + element + `" >` + element + `</a></li>`;
        }

    });
    if (number < maxPage) {
        number++;
        str += `<li><a href="/?search=` + key + `&page=` + number + `">»</a></li>`;
    }
    document.getElementById('pagination').innerHTML = str;
}

//Search Loai

function SearchLoai(name, pageNumber) {
    $.ajax({
        url: url + '/SearchLoai/' + name + '&' + pageNumber,
        type: 'GET',
        success: function (data) {
            $('#title_theloai').html(name);
            ProductsItem(data.listPage);
            pageSearchLoai(name, pageNumber, data.pageMax);
            //-----------------------------------
            var navHeaderActive = document.getElementsByClassName('header__swtich-menu-item-link-category-li');
            if (navHeaderActive) {
                for (let i = 0; i < navHeaderActive.length; i++) {
                    if (navHeaderActive[i].innerHTML == loai) {
                        navHeaderActive[i].style.color = "#007fdb";
                    }
                }
            }
        },
        error: function () {
            $('#title_theloai').html("Không có sản phẩm nào có trong loại!!!");
        }
    });
}

function pageSearchLoai(name, number, maxPage) {
    var str = ``;
    if (number > 1) {
        str = `<li><a href="/?loai=` + name + `&page=` + (number - 1) + `">«</a></li>`;
    }
    var array = pagination(number, maxPage);

    array.forEach(element => {
        if (element == number) {
            str += `<li><a class="active" href="/?loai=` + name + `&page=` + element + `">` + element + `</a></li>`;
        } else {
            str += `<li><a href="/?loai=` + name + `&page=` + element + `">` + element + `</a></li>`;
        }

    });
    if (number < maxPage) {
        number++;
        str += `<li><a href="/?loai=` + name + `&page=` + number + `">»</a></li>`;
    }
    document.getElementById('pagination').innerHTML = str;
}


function ProductsItem(data) {
    var str = ``;
                

    $.each(data, function (i, product) {
        str += `
                <div class="product_item product-item-`+ product.idSanPham + `">
                    <div class="product_item-img-wrapper">
                        <a href="/Home/Detail/?sanpham=`+ product.tenSp + `">
                            <img class="product_item-img" src="../img/products/`+ product.image + `" alt="product.jpg">
                        </a>
                    </div>
                    <div class="product_item-name">`+ product.tenSp + `</div>`;

        if (product.giamGia == 0) {
            str += `<div class="product_item-price" style="margin-bottom: 32px;">
                                <span class="product_item_price-current">` + formatCash(product.giaBan + '') + `₫</span>
                            </div>`;
        } else {
            str += `
                        <div class="product_item-price">
                            <span class="product_item_price-current">`+ formatCash(product.giaBan - (product.giaBan * product.giamGia / 100) + '') + `₫</span>
                            <span class="product_item_price-old">` + formatCash(product.giaBan + '') + `₫</span>
                        </div>
                        <div class="product_item-sale-off">
                            <span class="product_item-percent">Sale `+ product.giamGia + `%</span>
                        </div>`;
        }

        str += `
                    <div class="product_item-cart">
                        <div class="product_item-action-btn" onclick="OpenModelCart('`+ product.tenSp +`')">
                            <i class="fa-solid fa-cart-shopping"></i> Thêm vào giỏ hàng
                        </div>
                        <a href="/Home/Detail/?sanpham=`+ product.tenSp + `" class="product_item-action-btn product-item-separate">
                            <i class="fa-solid fa-eye"></i> Xem chi tiết
                        </a>
                    </div>
                </div>`;
    });

    $('#list_Products').html(str);
}

//Add Cart Modal
const modal = document.querySelector('.js-modal')
const modalClose = document.querySelector('.js-modal-close')

function OpenModelCart(name) {
    modal.classList.add('open');
    modalClose.addEventListener('click', () => {
        modal.classList.remove('open');
    });
    DetailSanPham(name);
}
