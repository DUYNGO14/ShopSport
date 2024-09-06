<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

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
                                                <li class="breadcrumb-item"><a href="/admin/category">Category</a>
                                                </li>
                                                <li class="breadcrumb-item active" aria-current="page">Delete Category
                                                </li>
                                            </ol>
                                        </nav>
                                    </h4>
                                </div>

                                <div class="card border-0">

                                    <div>
                                        <div class="row mx-auto">
                                            <div class="col-md-6 col-12 mx-auto ">
                                                <h3 class="fw-bold mt-3 text-center">Delete Category</h3>
                                                <hr />
                                                <div class="d-flex justify-content-between">
                                                    <h3>Delete the user with id = ${id}</h3>
                                                </div>

                                                <hr />
                                                <div class="alert alert-danger">
                                                    Are you sure to delete this Category ?
                                                </div>
                                                <form:form method="post" action="/admin/category/delete"
                                                    modelAttribute="newCategory">
                                                    <div class="mb-3" style="display: none;">
                                                        <label class="form-label">Id:</label>
                                                        <form:input value="${id}" type="text" class="form-control"
                                                            path="id" />
                                                    </div>
                                                    <button class="btn btn-danger mb-3">Delete</button>
                                                </form:form>
                                            </div>

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