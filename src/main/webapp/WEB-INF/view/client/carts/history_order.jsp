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
                </head>

                <body>
                    <jsp:include page="../layout_client/header.jsp" />
                    <section id="page-header" class="about-header"
                        style="background-image: url(/images/client/img/about/banner.png);">
                        <h2>#History Order</h2>
                        <p>RLorem ipsum dolor sit amet consectetur!</p>
                    </section>
                    <section class="section-p1">
                        <c:if test="${empty orders}">
                            <p class="text-center"><i class="fa-solid fa-cart-plus  fs-1"></i></p>
                            <p class="text-center  fs-5 fw-bold">Không có đơn hàng nào đã tạo!</br><a
                                    href="/home"><button type="button" class="btn btn-danger">Mua sắm
                                        nào</button></a> </p>
                        </c:if>
                        <c:if test="${!empty orders}">
                            <c:forEach var="order" items="${orders}">
                                <table width="100%" class="table table-bordered fw-normal" style="font-size: 14px;">
                                    <thead>
                                        <tr>
                                            <td>Image</td>
                                            <td>Product</td>
                                            <td>Size</td>
                                            <td>Price</td>
                                            <td>Quantity</td>
                                            <td>Subtotal</td>
                                            <!-- <td>Status</td> -->
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="orderDetail" items="${order.listOrder}">
                                            <tr>
                                                <td><img src="/images/product/${orderDetail.product.image}" alt=""
                                                        style="max-width: 100px; max-height: 120px;">
                                                </td>
                                                <td>${orderDetail.product.name}</td>
                                                <td>M</td>
                                                <td>
                                                    <fmt:formatNumber type="number" value="${orderDetail.price}" /> vnđ
                                                </td>
                                                <td>${orderDetail.quantity}</td>
                                                <td>
                                                    <fmt:formatNumber type="number"
                                                        value="${orderDetail.quantity * orderDetail.price}" />
                                                    vnđ
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <td colspan="6" class="text-end">
                                            <p>Total money:
                                                <fmt:formatNumber type="number" value=" ${order.total_money}" />
                                                vnđ
                                            </p>
                                            <p>
                                                <c:if test="${order.status == 'PENDING'}">Chờ xác nhận đơn hàng |
                                                    <span class="text-primary">${order.status}</span>
                                                </c:if>
                                                <c:if test="${order.status == 'SHIPPING'}">Đơn hàng đang được vận chuyển
                                                    | <span class="text-warning">${order.status}</span></c:if>
                                                <c:if test="${order.status == 'COMPLETE'}">Giao hàng thành công |
                                                    <span class="text-success"> ${order.status}</span>
                                                </c:if>
                                                <c:if test="${order.status == 'CANCELLED'}">Giao hàng không thành công |
                                                    <span class="text-danger"> ${order.status} </span>
                                                </c:if>
                                            </p>
                                        </td>
                                        <hr>
                                    </tbody>
                                </table>
                            </c:forEach>
                        </c:if>
                    </section>
                    <jsp:include page="../layout_client/footer.jsp" />
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                    <script src="/js/client/script.js"></script>
                    <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"
                    integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g=="
                    crossorigin="anonymous" referrerpolicy="no-referrer"></script> -->
                </body>

                </html>