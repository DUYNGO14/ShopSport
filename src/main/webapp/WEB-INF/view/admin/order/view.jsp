<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en" data-bs-theme="dark">

            <head>
                <meta charset="UTF-8">
                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Page Admin</title>
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css">
                <script src="https://kit.fontawesome.com/ae360af17e.js" crossorigin="anonymous"></script>
                <link rel="stylesheet" href="/admin/css/style1.css">
            </head>

            <body>
                <div class="wrapper">
                    <jsp:include page="../layout/slidebar.jsp" />
                    <div class="main">
                        <jsp:include page="../layout/header.jsp" />
                        <main class="content px-3 py-2">
                            <div class="container-fluid">
                                <div class="mb-3">
                                    <h4>
                                        <nav aria-label="breadcrumb">
                                            <ol class="breadcrumb">
                                                <li class="breadcrumb-item"><a href="/admin">Home</a></li>
                                                <li class="breadcrumb-item"><a href="/admin/order">Page Show Order</a>
                                                </li>
                                                <li class="breadcrumb-item active" aria-current="page">Order Detail</li>
                                            </ol>
                                        </nav>
                                    </h4>
                                </div>
                                <!-- <jsp:include page="../layout/content.jsp" /> -->
                                <!-- Table Element -->
                                <div class="card border-0">
                                    <div class="card-header">
                                        <h5 class="card-title">
                                            Table Order
                                        </h5>

                                    </div>
                                    <div class="card-body">
                                        <table class=" table table-bordered table-hover">
                                            <thead>
                                                <tr>
                                                    <th scope="col">Sản phẩm</th>
                                                    <th scope="col">Tên</th>
                                                    <th scope="col">Size</th>
                                                    <th scope="col">Giá cả</th>
                                                    <th scope="col">Số lượng</th>
                                                    <th scope="col">Thành tiền</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="orderDetail" items="${orderDetails}">
                                                    <tr>
                                                        <td><img src="/images/product/${orderDetail.product.image}"
                                                                alt="" style="max-width: 100px; max-height: 120px;">
                                                        </td>
                                                        <td>${orderDetail.product.name}</td>
                                                        <td>M</td>
                                                        <td>
                                                            <fmt:formatNumber type="number"
                                                                value="${orderDetail.price}" /> vnđ
                                                        </td>
                                                        <td>${orderDetail.quantity}</td>
                                                        <td>
                                                            <fmt:formatNumber type="number"
                                                                value="${orderDetail.quantity * orderDetail.price}" />
                                                            vnđ
                                                        </td>
                                                    </tr>
                                                </c:forEach>

                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </main>
                        <a href="#" class="theme-toggle">
                            <i class="fa-regular fa-moon"></i>
                            <i class="fa-regular fa-sun"></i>
                        </a>
                        <jsp:include page="../layout/footer.jsp" />
                    </div>
                </div>
                <script
                    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/js/bootstrap.bundle.min.js"></script>
                <script src="/admin/js/script.js"></script>
            </body>

            </html>