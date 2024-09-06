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
                    <title>Giỏ hàng</title>
                    <!-- <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" /> -->
                    <jsp:include page="../layout_client/head.jsp" />
                </head>

                <body>
                    <jsp:include page="../layout_client/header.jsp" />
                    <section id="page-header" class="about-header"
                        style="background-image: url(/images/client/img/about/banner.png);">
                        <h2>Giỏ hàng</h2>
                        <p>Mua sắm ngay nào!</p>
                    </section>
                    <section id="cart" class="section-p1">
                        <c:if test="${empty lstProduct}">
                            <p class="text-center"><i class="fa-solid fa-cart-plus  fs-1"></i></p>
                            <p class="text-center  fs-5 fw-bold">Không có sản phẩm nào trong giỏ hàng của bạn!</br><a
                                    href="/home"><button type="button" class="btn btn-danger">Mua sắm
                                        nào</button></a> </p>
                        </c:if>
                        <c:if test="${!empty lstProduct}">
                            <table width="100%" class="table">
                                <thead>
                                    <tr>
                                        <td scope="col">Selection</td>
                                        <td scope="col">Image</td>
                                        <td scope="col">Product</th>
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
                                            <td> <a href="/sproduct/${cartDetail.product.id}" class="text-wrap"
                                                    target="_blank">${cartDetail.product.name}</a>
                                            </td>
                                            <td>${cartDetail.size}</td>
                                            <td>
                                                <fmt:formatNumber type="number" value="${cartDetail.price}" /> đ
                                            </td>

                                            <td>
                                                <div class="input-group quantity" width="50%">
                                                    <div class="input-group-btn">
                                                        <button
                                                            class="btn btn-sm btn-minus rounded-circle bg-light border">
                                                            <i class="fa fa-minus"></i>
                                                        </button>
                                                    </div>
                                                    <input type="text"
                                                        class="form-control form-control-sm text-center border mx-3"
                                                        value="${cartDetail.quantity}"
                                                        data-cart-detail-id="${cartDetail.id}"
                                                        data-cart-detail-price="${cartDetail.price}"
                                                        data-cart-detail-index="${status.index}">
                                                    <div class="input-group-btn">
                                                        <button
                                                            class="btn btn-sm btn-plus rounded-circle bg-light border">
                                                            <i class="fa fa-plus"></i>
                                                        </button>
                                                    </div>
                                                </div>
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
                        </c:if>
                    </section>
                    <c:if test="${not empty lstProduct}">
                        <section id="cart-add" class="section-p1">
                            <div id="coupon">
                                <h3>Apply Coupon</h3>
                                <form action="">
                                    <input type="text" placeholder="Enter Your Coupon">
                                    <button class="normal">Apply</button>
                                </form>
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
                                <form:form action="/confirm-checkout" method="post" modelAttribute="cart">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <div style="display: none;">
                                        <c:forEach var="cartDetail" items="${cart.lstCartDetail}" varStatus="status">
                                            <div>
                                                <div>
                                                    <label>Id:</label>
                                                    <form:input class="form-control" type="text"
                                                        value="${cartDetail.id}"
                                                        path="lstCartDetail[${status.index}].id" />
                                                </div>
                                                <div>
                                                    <label>Quantity:</label>
                                                    <form:input class="form-control" type="text"
                                                        value="${cartDetail.quantity}"
                                                        path="lstCartDetail[${status.index}].quantity" />
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <button type="submit" class="normal mb-3">Procced to Checkout</button>
                                </form:form>
                            </div>
                        </section>
                    </c:if>
                    <jsp:include page="../layout_client/feature.jsp" />
                    <jsp:include page="../layout_client/footer.jsp" />
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                    <script src="/js/client/script.js"></script>

                </body>

                </html>