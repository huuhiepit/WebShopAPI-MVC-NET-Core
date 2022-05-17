//Click product detail

function changeImage(img) {
    document.getElementById('product_detail-img').src = "/img/products/" + img;
}


//Scroll
$(document).ready(function () {
    $(window).scroll(function () {
        if ($(this).scrollTop()) {
            $('#backtop').fadeIn();
        } else {
            $('#backtop').fadeOut();
        }
    });
    $('#backtop').click(function () {
        $('html, body').animate({ scrollTop: 0 }, 1000);
    })
    CongTruSoLuong();
});

function formatCash(str) {
    return str.split('').reverse().reduce((prev, next, index) => {
        return ((index % 3) ? next : (next + ',')) + prev;
    });
}

function formatNumber(str) {
    return str.split(',').reverse().reduce((prev, next, index) => {
        return ((index % 3) ? next : (next)) + prev;
    });
}
//Page


function pagination(c, m) {
    var current = c,
        last = m,
        delta = 2,
        left = current - delta,
        right = current + delta + 1,
        range = [],
        rangeWithDots = [],
        l;

    for (let i = 1; i <= last; i++) {
        if (i == 1 || i == last || i >= left && i < right) {
            range.push(i);
        }
    }

    for (let i of range) {
        if (l) {
            if (i - l === 2) {
                rangeWithDots.push(l + 1);
            } else if (i - l !== 1) {
                rangeWithDots.push('...');
            }
        }
        rangeWithDots.push(i);
        l = i;
    }

    return rangeWithDots;
}

//Get var Url
function getUrlVars(url) {
    var vars = {};
    var parts = url.replace(/[?&]+([^=&]+)=([^&]*)/gi, function (m, key, value) {
        vars[key] = value;
    });
    return vars;
}

function getParameterByName(name, url = window.location.href) {
    name = name.replace(/[\[\]]/g, '\\$&');
    var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, ' '));
}


//------------------Product--------------------------
const bigImg = document.querySelector(".product_detail-item-img img")
const smallImg = document.querySelectorAll(".product_detail-list-img img")
smallImg.forEach(function (imgItem, X) {
    imgItem.addEventListener("click", function () {
        bigImg.src = imgItem.src
    })
})
//-----------------bottom----------------------------
const mota = document.querySelector(".mota")
const baoquan = document.querySelector(".baoquan")
const thamkhao = document.querySelector(".thamkhao")
if (baoquan) {
    baoquan.addEventListener("click", function () {
        document.querySelector(".product-detail-bottom-content-mota").style.display = "none"
        document.querySelector(".product-detail-bottom-content-baoquan").style.display = "block"
        document.querySelector(".product-detail-bottom-content-thamkhao").style.display = "none"
        ProductBottomActive(baoquan, mota, thamkhao);
    })
}

if (mota) {
    mota.addEventListener("click", function () {
        document.querySelector(".product-detail-bottom-content-baoquan").style.display = "none"
        document.querySelector(".product-detail-bottom-content-mota").style.display = "block"
        document.querySelector(".product-detail-bottom-content-thamkhao").style.display = "none"
        ProductBottomActive(mota, baoquan, thamkhao);
    })
}

if (thamkhao) {
    thamkhao.addEventListener("click", function () {
        document.querySelector(".product-detail-bottom-content-baoquan").style.display = "none"
        document.querySelector(".product-detail-bottom-content-thamkhao").style.display = "block"
        document.querySelector(".product-detail-bottom-content-mota").style.display = "none"
        ProductBottomActive(thamkhao, mota, baoquan);
    })
}

const butTon = document.querySelector(".product-detail-bottom-top")
if (butTon) {
    butTon.addEventListener("click", function () {
        document.querySelector(".product-detail-bottom-content-form").classList.toggle(("activeB"))
    })
}

function ProductBottomActive(active, name, name2) {
    active.classList.add("product-bottom-active")
    name.classList.remove("product-bottom-active")
    name2.classList.remove("product-bottom-active")
}

//----------------------Action------------------------------------
let detail = document.querySelectorAll('.product_item-action-btn');
let p = document.querySelector('.product_item');
for (let i = 0; i < detail.length; i++) {
    detail[i].addEventListener('click', () => {
        detailP();
    });

}
//-----------------------------------------------------------
function CongTruSoLuong() {
    const spTru = document.getElementsByClassName('sp-tru');
    const spCong = document.getElementsByClassName('sp-cong');

    for (let i = 0; i < spTru.length; i++) {
        spTru[i].addEventListener("click", () => {
            CalcSoLuong("#sp-soluong-" + i, "tru")
        })
    }
    for (let i = 0; i < spCong.length; i++) {
        spCong[i].addEventListener("click", () => {
            CalcSoLuong("#sp-soluong-" + i, "cong")
        })
    }

    function CalcSoLuong(name, calc) {
        if (calc == "tru") {
            var spSoLuong = document.querySelector(name + "").value;
            if (spSoLuong > 1) spSoLuong--;
            document.querySelector(name + "").value = spSoLuong;
        }
        if (calc == "cong") {
            var spSoLuong = document.querySelector(name + "").value;
            spSoLuong++;
            document.querySelector(name + "").value = spSoLuong;
        }
    }
}
function isNumberKey(evt) {
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}

