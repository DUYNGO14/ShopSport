<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Shop sport</title>
                <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" />
                <jsp:include page="../layout_client/head.jsp" />
            </head>

            <body>
                <jsp:include page="../layout_client/header.jsp" />
                <section id="prodetails" class="section-p1">
                    <div class="single-pro-image">
                        <img src="/images/product/${product.image}" width="100%" id="MainImg" alt="">
                        <div class="small-img-group mt-3">
                            <div class="small-img-col">
                                <img src="/images/product/${product.image}" width="100%" height="150px"
                                    class="small-img" alt="">
                            </div>
                            <c:forEach var="image" items="${product.listImage.split(';')}">
                                <div class="small-img-col">
                                    <img src="/images/product/${image}" width="100%" height="150px" class="small-img"
                                        alt="">
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="single-pro-details">
                        <h5><a href="/home">Home</a>/${product.category.name}/<span
                                style="color:red">${product.name}</span></h5>
                        <h4>${product.name}</h4>
                        <c:if test="${product.factory==null}">
                            <span>Hãng sản xuất : đang cập nhật </span>
                        </c:if>
                        <c:if test="${product.factory!=null}">
                            <span>Hãng sản xuất : ${product.factory} </span>
                        </c:if>

                        <h2>
                            <fmt:formatNumber type="number" value="${product.price}" /> đ
                        </h2>
                        <select name="size" id="mySelect">
                            <option value="X">X</option>
                            <option value="M">M</option>
                            <option value="L">L</option>
                            <option value="XL">XL</option>
                            <option value="XXL">XXL</option>
                        </select>
                        <div class="input-group quantity">
                            <div class="input-group-btn">
                                <button class="btn btn-sm btn-minus rounded-circle bg-success border me-3">
                                    <i class="fa fa-minus"></i>
                                </button>
                            </div>
                            <input type="text" class="form-control form-control-sm text-center border-1"
                                style="max-width: 100px;" value="1" data-cart-detail-index="0">
                            <div class="input-group-btn">
                                <button class="btn btn-sm btn-plus rounded-circle bg-success border">
                                    <i class="fa fa-plus"></i>
                                </button>
                            </div>
                        </div>
                        <form action="/add-product-from-view-detail" method="post" modelAttribute="product">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <div style="display: none;">
                                <div>
                                    <label>Id:</label>
                                    <input class="form-control" type="text" value="${product.id}"
                                        path="lstCartDetail[${status.index}].id" name="id" />
                                </div>
                                <div>
                                    <label>Quantity:</label>
                                    <input class="form-control" type="text" value="1" path="lstCartDetail[0].quantity"
                                        id="lstCartDetail0.quantity" name="quantity" />
                                </div>
                                <div>
                                    <label>Size:</label>
                                    <input class="form-control" type="text" value="M" path="lstCartDetail[0].size"
                                        id="lstCartDetail0.size" name="size" />
                                </div>
                            </div>
                            <button class="normal my-3"><i class="fa fa-shopping-bag me-2"></i>
                                Add to cart
                            </button>
                        </form>
                        <h4>Product Details</h4>
                        ${product.description}
                        <span>Material: ${product.material}</span>
                    </div>
                </section>
                <section class="section-p1">
                    <div class="alert alert-info" role="alert">
                        <button class="btn btn-primary" type="button" data-bs-toggle="collapse"
                            data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
                            Đánh giá sản phẩm
                        </button>
                    </div>
                    <div class="collapse" id="collapseExample">
                        <div class="card card-body">
                            <c:choose>
                                <c:when test=" ${size!=0}">
                                    <c:forEach var="feedback" items="${lstFeedback}">
                                        <button type="button" class="btn btn-dark position-relative">
                                            ${feedback.user.full_name} <svg width="1em" height="1em" viewBox="0 0 16 16"
                                                class="position-absolute top-100 start-50 translate-middle mt-1 bi bi-caret-down-fill"
                                                fill="#212529" xmlns="http://www.w3.org/2000/svg">
                                                <path
                                                    d="M7.247 11.14L2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z" />
                                            </svg>
                                        </button>
                                        <p>${feedback.content}</p>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <span>Hiện tại sản phẩm chưa có đánh giá nào, bạn hãy trở thành người đầu tiên đánh
                                        giá
                                        cho sản phẩm này</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </section>
                <section id="about-header" class="section-p1">
                    <img src="/images/client/img/about/bangsize.png" alt="">
                    <div>
                        <h3>Cam kết</h3>
                        <p>
                            - Chất lượng ĐỈNH CAO<br />

                            - Ảnh chụp sản phẩm THẬT 100%<br />

                            - Hàng ĐẸP CHUẨN size<br />

                            - MIỄN PHÍ ĐỔI HÀNG, HOÀN TIỀN 100% sản phẩm nếu có lỗi do nhà sản xuất</p>
                        <h3>HƯỚNG DẪN GIẶT ỦI, BẢO QUẢN CHO ÁO ĐÁ BÓNG </h3>
                        <p>
                            - Nên giặt bằng tay<br />

                            - Không nên ngâm đồ quá lâu trong dung dịch có độ tẩy cao<br />

                            - Không nên để xà phòng, hóa chất trực tiếp lên sản phẩm có hình in<br />

                            - Không nên phơi áo trực tiếp dưới nắng gắt<br />

                            - Là, ủi áo ở nhiệt độ trung bình</p>

                        <br></br>
                        <marquee loop="-1" width="100%" behavior="70%" direction="">Chất lượng là cái ghế vì nó không
                            phải bàn.Mua sản phẩm thể hiên đam mê,thể hiện tình yêu với đội bóng.
                        </marquee>
                    </div>
                </section>
                <section id="product1" class="section-p1">
                    <h2>Featured Products</h2>
                    <p>Summer Collection New Morden Design</p>
                    <div class="pro-container">
                        <c:forEach items="${lstProduct}" var="product">
                            <div class="pro">
                                <img src="/images/product/${product.image}" alt=""
                                    onclick="window.location.href='/sproduct/${product.id}'">
                                <div class="des">
                                    <span>adidas</span>
                                    <h5>${product.name}</h5>
                                    <div class="star">
                                        <i class="fa-solid fa-star"></i>
                                        <i class="fa-solid fa-star"></i>
                                        <i class="fa-solid fa-star"></i>
                                        <i class="fa-solid fa-star"></i>
                                        <i class="fa-solid fa-star"></i>
                                    </div>
                                    <h4>
                                        <fmt:formatNumber type="number" value="${product.price}" /> đ
                                    </h4>
                                </div>
                                <form action="/cart/${product.id}" method="post">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <button><i class="fa-solid fa-bag-shopping cart"></i></button>
                                </form>
                            </div>
                        </c:forEach>

                    </div>
                </section>

                <jsp:include page="../layout_client/newsletter.jsp" />
                <jsp:include page="../layout_client/footer.jsp" />
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                <script>
                    var MainImg = document.getElementById('MainImg');
                    var smallImg = document.getElementsByClassName("small-img");
                    smallImg[0].onclick = function () {
                        MainImg.src = smallImg[0].src;
                    }
                    for (let i = 0; i < 10; i++) {
                        smallImg[i].onclick = function () {
                            MainImg.src = smallImg[i].src;
                        }
                    }
                </script>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                <script src="/js/client/script.js"></script>
            </body>

            </html>