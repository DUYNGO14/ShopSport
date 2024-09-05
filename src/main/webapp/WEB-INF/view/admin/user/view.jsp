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
                                <div class="mb-3">
                                    <h4>
                                        <nav aria-label="breadcrumb">
                                            <ol class="breadcrumb">
                                                <li class="breadcrumb-item"><a href="/admin">Home</a></li>
                                                <li class="breadcrumb-item"><a href="/admin/user">User</a>
                                                </li>
                                                <li class="breadcrumb-item active" aria-current="page">Detail User</li>
                                            </ol>
                                        </nav>
                                    </h4>
                                </div>
                                <!-- <jsp:include page="../layout/content.jsp" /> -->
                                <!-- Table Element -->
                                <div class="card border-0">
                                    <div class="card-header">
                                        <h5 class="card-title">
                                            Basic Table
                                        </h5>
                                        <h6 class="card-subtitle text-muted">
                                            Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptatum ducimus,
                                            necessitatibus reprehenderit itaque!
                                        </h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="card mb-3" style="max-width: 800px;">
                                            <div class="row g-0">
                                                <div class="col-md-6 col-12">
                                                    <c:if test="${user.avatar==null}"> <img
                                                            src="/images/avatar/defaule.png"
                                                            class="img-fluid rounded-start" alt="..."></c:if>
                                                    <c:if test="${user.avatar!=null}"><img
                                                            src="/images/avatar/${user.avatar}"
                                                            class="img-fluid rounded-start" alt="..."></c:if>
                                                </div>
                                                <div class="col-md-6 col-12">
                                                    <div class="card-body">
                                                        <ul class="list-group list-group-flush">
                                                            <li class="list-group-item">ID: ${user.id}</li>
                                                            <li class="list-group-item">FullName: ${user.full_name}</li>
                                                            <li class="list-group-item">Email: ${user.email}</li>
                                                            <li class="list-group-item">Phone Number:
                                                                ${user.phone_number}</li>
                                                            <li class="list-group-item">Address: ${user.address}</li>
                                                            <li class="list-group-item">Role: ${user.role.name}</li>
                                                        </ul>
                                                    </div>
                                                </div>

                                            </div>
                                            <a href="/admin/user" class="btn btn-success mt-3">Back</a>

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