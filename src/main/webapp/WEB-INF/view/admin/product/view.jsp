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
                                            <li class="breadcrumb-item"><a href="/admin/product">Product</a>
                                            </li>
                                            <li class="breadcrumb-item active" aria-current="page">Detail Product
                                            </li>
                                        </ol>
                                    </nav>
                                </h4>
                                <!-- <jsp:include page="../layout/content.jsp" /> -->
                                <!-- Table Element -->
                                <div class="card border-0">
                                    <div class="card-header">
                                        <h5 class="card-title">
                                            Basic Table
                                        </h5>
                                        <h6 class="card-subtitle text-muted">
                                    </div>
                                    <div class="card-body">
                                        <div class="card mb-3" style="max-width: 100%;">
                                            <div class="row g-0">
                                                <div class="col-md-5 col-12">
                                                    <c:if test="${product.image==null}"> <img
                                                            src="/images/avatar/defaule.png"
                                                            class="img-fluid rounded-start" alt="..."></c:if>
                                                    <c:if test="${product.image!=null}"><img
                                                            src="/images/product/${product.image}"
                                                            class="img-fluid rounded-start" alt="..."></c:if>
                                                </div>
                                                <!-- <div class="col-md-2 col-12">
                                                    <ul class="list-group list-group-flush">
                                                        <c:forEach var="image" items="${listimage}">
                                                            <li class="list-group-item" style="m"><img
                                                                    src="/images/product/${image}" alt=""></li>
                                                        </c:forEach>
                                                    </ul>
                                                </div> -->

                                                <div class="col-md-5 col-12">
                                                    <div class="card-body">
                                                        <ul class="list-group list-group-flush">
                                                            <li class="list-group-item">ID: ${product.id}</li>
                                                            <li class="list-group-item">Name Product: ${product.name}
                                                            </li>
                                                            <li class="list-group-item">Description:
                                                                ${product.description}</li>
                                                            <li class="list-group-item">Quantity: ${product.quantity}
                                                            </li>
                                                            <li class="list-group-item">Price: ${product.price}</li>
                                                            <li class="list-group-item">Material: ${product.material}
                                                            </li>
                                                            <li class="list-group-item">Category:
                                                                ${product.category.name}</li>
                                                        </ul>
                                                    </div>
                                                </div>

                                            </div>
                                            <a href="/admin/product" class="btn btn-success mt-3">Back</a>

                                        </div>
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