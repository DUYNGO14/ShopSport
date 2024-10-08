<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en" data-bs-theme="dark">

            <head>
                <meta charset="UTF-8">
                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Bootstrap Admin Dashboard</title>
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
                                <h4>
                                    <nav aria-label="breadcrumb">
                                        <ol class="breadcrumb">
                                            <li class="breadcrumb-item"><a href="/admin">Home</a></li>
                                            <li class="breadcrumb-item active" aria-current="page">Product
                                            </li>
                                        </ol>
                                    </nav>
                                </h4>
                                <!-- <jsp:include page="../layout/content.jsp" /> -->
                                <!-- Table Element -->
                                <div class="card border-0">
                                    <div class="card-header">
                                        <a href="/admin/product/create" class="btn btn-success">Create Product</a>
                                    </div>
                                    <div class="card-body">
                                        <table class=" table table-bordered table-hover">
                                            <thead>
                                                <tr>
                                                    <th class="col">ID</th>
                                                    <th class="col">Name Product</th>
                                                    <th class="col">Quantity</th>
                                                    <th class="col">Price</th>
                                                    <th class="col">Material</th>
                                                    <th class="col">Image</th>
                                                    <th class="col">IsDelete</th>
                                                    <th class="col">Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="product" items="${lstProduct}">
                                                    <tr>
                                                        <th>${product.id}</th>
                                                        <td>${product.name}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${product.quantity==0}"><span
                                                                        class="text-danger">Hết hàng!</span></c:when>
                                                                <c:when test="${product.quantity<=10}"><span
                                                                        class="text-danger">${product.quantity} (Sắp hết
                                                                        hàng!)</span>
                                                                </c:when>
                                                                <c:otherwise>${product.quantity}</c:otherwise>
                                                            </c:choose>

                                                        </td>
                                                        <td>${product.price}</td>
                                                        <td>${product.material}</td>
                                                        <td><img src="/images/product/${product.image}" alt=""
                                                                style="max-width: 100px; max-height: 120px;"></td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test=" ${product.deleted==true}"><span><i
                                                                            class="fa-solid fa-circle-check"
                                                                            style="color: #63E6BE;"></i></span>
                                                                </c:when>
                                                                <c:otherwise><i class="fa-solid fa-circle-check"
                                                                        style="color: #63E6BE;"></i></i>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <a href="/admin/product/${product.id}"
                                                                class="btn btn-success btn-sm"><i
                                                                    class="fa-regular fa-eye"></i></a>
                                                            <a href="/admin/product/update/${product.id}"
                                                                class="btn btn-warning  btn-sm mx-2"><i
                                                                    class="fa-solid fa-pen-to-square"></i></a>
                                                            <a href="/admin/product/delete/${product.id}"
                                                                class="btn btn-danger btn-sm"><i
                                                                    class="fa-solid fa-trash-can"></i></a>
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
                                                    href="/admin/product?page=${currentPage - 1}" aria-label="Previous">
                                                    <span aria-hidden="true">&laquo;</span>
                                                </a>
                                            </li>
                                            <c:forEach begin="0" end="${totalPages - 1}" varStatus="loop">
                                                <li class="page-item">
                                                    <a class="${(loop.index + 1) eq currentPage ? 'active page-link' : 'page-link'}"
                                                        href="/admin/product?page=${loop.index + 1}">
                                                        ${loop.index + 1}
                                                    </a>
                                                </li>
                                            </c:forEach>
                                            <li class="page-item">
                                                <a class="${totalPages eq currentPage ? 'disabled page-link' : 'page-link'}"
                                                    href="/admin/product?page=${currentPage + 1}" aria-label="Next">
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