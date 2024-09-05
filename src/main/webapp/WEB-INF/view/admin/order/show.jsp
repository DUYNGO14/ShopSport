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

                                                </li>
                                                <li class="breadcrumb-item active" aria-current="page">Page Show Order
                                                </li>
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
                                                    <th>ID</th>
                                                    <th>Full Name</th>
                                                    <th>Address</th>
                                                    <th>Phone Number</th>
                                                    <th>Date Order</th>
                                                    <th>Total Money</th>
                                                    <th>Status</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="order" items="${orders}">
                                                    <tr>
                                                        <th>${order.id}</th>
                                                        <td>${order.full_name}</td>
                                                        <td>${order.address}</td>
                                                        <td>${order.phone_number}</td>
                                                        <td>${order.date_order}</td>
                                                        <td>
                                                            <fmt:formatNumber type="number"
                                                                value="${order.total_money}" /> vnđ
                                                        </td>
                                                        <td>${order.status}</td>
                                                        <td>
                                                            <a href="/admin/order/view/${order.id}"
                                                                class="btn btn-success">View</a>
                                                            <a href="/admin/order/update/${order.id}"
                                                                class="btn btn-warning  mx-2">Update</a>
                                                            <a href="/admin/order/delete/${order.id}"
                                                                class="btn btn-danger">Delete</a>
                                                        </td>
                                                    </tr>

                                                </c:forEach>

                                            </tbody>
                                        </table>
                                    </div>
                                    <nav aria-label="Page navigation example">
                                        <ul class="pagination justify-content-center">
                                            <li class="page-item">
                                                <a class="${1 eq currentPage ? 'disabled page-link' : 'page-link'}"
                                                    href="/admin/order=${currentPage - 1}" aria-label="Previous">
                                                    <span aria-hidden="true">&laquo;</span>
                                                </a>
                                            </li>
                                            <c:forEach begin="0" end="${totalPages - 1}" varStatus="loop">
                                                <li class="page-item">
                                                    <a class="${(loop.index + 1) eq currentPage ? 'active page-link' : 'page-link'}"
                                                        href="/admin/order?page=${loop.index + 1}">
                                                        ${loop.index + 1}
                                                    </a>
                                                </li>
                                            </c:forEach>
                                            <li class="page-item">
                                                <a class="${totalPages eq currentPage ? 'disabled page-link' : 'page-link'}"
                                                    href="/admin/order?page=${currentPage + 1}" aria-label="Next">
                                                    <span aria-hidden="true">&raquo;</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </nav>
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