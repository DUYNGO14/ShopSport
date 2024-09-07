<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta http-equiv="X-UA-Compatible" content="IE=edge">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Thanh toán</title>
                    <!-- <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" /> -->
                    <jsp:include page="../layout_client/head.jsp" />
                    <script src="https://esgoo.net/scripts/jquery.js"></script>
                    <script>
                        $(document).ready(function () {
                            //Lấy tỉnh thành
                            $.getJSON('https://esgoo.net/api-tinhthanh/1/0.htm', function (data_tinh) {
                                if (data_tinh.error == 0) {
                                    $.each(data_tinh.data, function (key_tinh, val_tinh) {
                                        $("#tinh").append('<option value="' + val_tinh.id + '">' + val_tinh.full_name + '</option>');
                                    });
                                    $("#tinh").change(function (e) {
                                        var idtinh = $(this).val();
                                        //Lấy quận huyện
                                        $.getJSON('https://esgoo.net/api-tinhthanh/2/' + idtinh + '.htm', function (data_quan) {
                                            if (data_quan.error == 0) {
                                                $("#quan").html('<option value="0">Quận Huyện</option>');
                                                $("#phuong").html('<option value="0">Phường Xã</option>');
                                                $.each(data_quan.data, function (key_quan, val_quan) {
                                                    $("#quan").append('<option value="' + val_quan.id + '">' + val_quan.full_name + '</option>');
                                                });
                                                //Lấy phường xã  
                                                $("#quan").change(function (e) {
                                                    var idquan = $(this).val();
                                                    $.getJSON('https://esgoo.net/api-tinhthanh/3/' + idquan + '.htm', function (data_phuong) {
                                                        if (data_phuong.error == 0) {
                                                            $("#phuong").html('<option value="0">Phường Xã</option>');
                                                            $.each(data_phuong.data, function (key_phuong, val_phuong) {
                                                                $("#phuong").append('<option value="' + val_phuong.id + '">' + val_phuong.full_name + '</option>');
                                                            });
                                                        }
                                                    });
                                                });

                                            }
                                        });
                                    });

                                }
                            });
                        });	    
                    </script>
                </head>

                <body>
                    <jsp:include page="../layout_client/header.jsp" />
                    <section id="page-header" class="about-header"
                        style="background-image: url(/images/client/img/about/banner.png);">
                        <h2>#Check Out</h2>
                        <p>RLorem ipsum dolor sit amet consectetur!</p>
                    </section>
                    <section id="cart" class="section-p1">
                        <table width="100%">
                            <thead>
                                <tr>
                                    <td scope="col">Selection</td>
                                    <td scope="col">Image</td>
                                    <td scope="col">Product</td>
                                    <td scope="col">Size</td>
                                    <td scope="col">Price</td>
                                    <td scope="col">Quantity</td>
                                    <td scope="col">Subtotal</td>
                                    <td scope="col">Remove</td>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${lstProduct}" var="cartDetail" varStatus="status">
                                    <tr>
                                        <td><input type="checkbox"></td>
                                        <td><img src="/images/product/${cartDetail.product.image}" alt=""></td>
                                        <td> <a href="/sproduct/${cartDetail.product.id}"
                                                target="_blank">${cartDetail.product.name}</a></td>
                                        <td>${cartDetail.size}</td>
                                        <td>
                                            <fmt:formatNumber type="number" value="${cartDetail.price}" /> đ
                                        </td>

                                        <td>
                                            ${cartDetail.quantity}
                                        </td>
                                        <td>
                                            <p data-cart-detail-id="${cartDetail.id}">
                                                <fmt:formatNumber type="number"
                                                    value="${cartDetail.price * cartDetail.quantity}" /> đ
                                            </p>

                                        </td>
                                        <td>
                                            <form method="post" action="/delete-cart-product/${cartDetail.id}">
                                                <input type="hidden" name="${_csrf.parameterName}"
                                                    value="${_csrf.token}" />
                                                <button class="btn btn-md rounded-circle bg-light border">
                                                    <i class="fa-solid fa-trash"></i>
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </section>
                    <c:if test="${not empty lstProduct}">
                        <section id="cart-add" class="section-p1">
                            <div id="coupon">
                                <h3>Apply Coupon</h3>
                                <form:form class="row g-3" method="post" action="/place-order" modelAttribute="newOrder"
                                    enctype="multipart/form-data">
                                    <c:set var="errorFullName">
                                        <form:errors path="receive_FullName" cssClass="invalid-feedback" />
                                    </c:set>
                                    <c:set var="errorAddress">
                                        <form:errors path="receive_Address" cssClass="invalid-feedback" />
                                    </c:set>
                                    <c:set var="errorPhoneNumber">
                                        <form:errors path="receive_PhoneNumber" cssClass="invalid-feedback" />
                                    </c:set>
                                    <div class="col-12 mb-3">
                                        <label for="exampleInputEmail1" class="form-label">Name:</label>
                                        <form:input type="text"
                                            class="form-control ${not empty errorFullName ? 'is-invalid' : ''}"
                                            id="exampleInputEmail1" aria-describedby="emailHelp"
                                            path="receive_FullName" />
                                        ${errorFullName}
                                    </div>
                                    <div class="col-12 mb-3">
                                        <label for="exampleInputPassword1" class="form-label">Address:</label>
                                        <form:input type="text"
                                            class="form-control ${not empty errorAddress ? 'is-invalid' : ''}"
                                            id="exampleInputPassword1" path="receive_Address" />
                                        ${errorAddress}
                                    </div>
                                    <div class="col-12">
                                        <div class="row">
                                            <div class="col-md-4 col-12 mx-auto mb-3">
                                                <form:select class="form-select" id="tinh" title="Chọn Tỉnh Thành"
                                                    path="tinhThanh">
                                                    <option value="0">Tỉnh Thành</option>
                                                </form:select>
                                            </div>
                                            <div class="col-md-4 col-12 mx-auto mb-3">
                                                <form:select class="form-select" id="quan" title="Chọn Quận Huyện"
                                                    path="quanHuyen">
                                                    <option value="0">Quận Huyện</option>
                                                </form:select>
                                            </div>
                                            <div class="col-md-4 col-12 mx-auto mb-3">
                                                <form:select class="form-select" id="phuong" title="Chọn Phường Xã"
                                                    path="phuongXa">
                                                    <option value="0">Phường Xã</option>
                                                </form:select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 mb-3">
                                        <label for="exampleInputPassword1" class="form-label">Phone Number:</label>
                                        <form:input type="text"
                                            class="form-control ${not empty errorPhoneNumber ? 'is-invalid' : ''}"
                                            id="exampleInputPassword1" path="receive_PhoneNumber" />
                                        ${errorPhoneNumber}
                                    </div>
                                    <div class="col-12 mb-3">
                                        <button type="submit" class="btn btn-primary ">Order Now</button>
                                    </div>
                                </form:form>
                                <div class="mb-3 text-success fw-bold">
                                    <i class="fas fa-arrow-left"></i>
                                    <a href="/cart" class="text-decoration-none text-success ">Quay lại giỏ hàng</a>
                                </div>
                            </div>
                            <div id="subtotal">
                                <h3>Cart Total</h3>
                                <table>
                                    <tr>
                                        <td>Cart Subtotal</td>
                                        <td>
                                            <p data-cart-total-price="${totalPrice}">
                                                <fmt:formatNumber type="number" value="${totalPrice}" /> đ
                                            </p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Shipping</td>
                                        <td>Free</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Total</strong></td>
                                        <td>
                                            <p data-cart-total-price="${totalPrice}">
                                                <fmt:formatNumber type="number" value="${totalPrice}" /> đ
                                            </p>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </section>
                    </c:if>
                    <jsp:include page="../layout_client/footer.jsp" />
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                    <script src="/js/client/script.js"></script>
                    <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"
                    integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g=="
                    crossorigin="anonymous" referrerpolicy="no-referrer"></script> -->
                </body>

                </html>