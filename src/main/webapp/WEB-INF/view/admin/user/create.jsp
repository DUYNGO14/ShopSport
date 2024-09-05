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
                <script>
                    $(document).ready(() => {
                        const avatarFile = $("#avatarFile");
                        avatarFile.change(function (e) {
                            const imgURL = URL.createObjectURL(e.target.files[0]);
                            $("#avatarPreview").attr("src", imgURL);
                            $("#avatarPreview").css({ "display": "block" });
                        });
                    });
                </script>
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
                                                <li class="breadcrumb-item active" aria-current="page">Create User</li>
                                            </ol>
                                        </nav>
                                    </h4>
                                </div>
                                <!-- <jsp:include page="../layout/content.jsp" /> -->
                                <!-- Table Element -->
                                <div class="card border-0">
                                    <!-- <div class="card-header">
                                        <h5 class="card-title fw-bold">
                                            Create
                                        </h5>
                                        <h6 class="card-subtitle text-muted">
                                            Thêm nhân viên mới vào hệ thống của shop!!!
                                        </h6>
                                    </div> -->
                                    <div>
                                        <div class="row mx-auto">
                                            <div class="col-md-6 col-12 mx-auto ">
                                                <h3 class="fw-bold mt-3 text-center">Create new user</h3>
                                                <hr />
                                                <form:form class="row g-3" method="post" action="/admin/user/create"
                                                    modelAttribute="newUser" enctype="multipart/form-data">
                                                    <div class="col-md-6 col-12">
                                                        <c:set var="errorFullName">
                                                            <form:errors path="full_name" cssClass="invalid-feedback" />
                                                        </c:set>
                                                        <label for="inputEmail4" class="form-label">Full
                                                            name</label>
                                                        <form:input type="text"
                                                            class="form-control ${not empty errorFullName ? 'is-invalid' : ''}"
                                                            id="inputfullname" path="full_name" />
                                                        ${errorFullName}
                                                    </div>
                                                    <div class="col-md-6 col-12">
                                                        <c:set var="errorPhoneNumber">
                                                            <form:errors path="phone_number"
                                                                cssClass="invalid-feedback" />
                                                        </c:set>
                                                        <label for="inputPassword4" class="form-label">Phone
                                                            Number</label>
                                                        <form:input type="text"
                                                            class="form-control ${not empty errorPhoneNumber ? 'is-invalid' : ''}"
                                                            id="inputPhonenumber" path="phone_number" />
                                                        ${errorPhoneNumber}
                                                    </div>
                                                    <div class="col-md-6 col-12">
                                                        <c:set var="errorEmail">
                                                            <form:errors path="email" cssClass="invalid-feedback" />
                                                        </c:set>
                                                        <label for="inputEmail4" class="form-label">Email</label>
                                                        <form:input type="email"
                                                            class="form-control ${not empty errorEmail ? 'is-invalid' : ''} "
                                                            id="inputEmail4" path="email" />
                                                        ${errorEmail}
                                                    </div>
                                                    <div class="col-md-6 col-12">
                                                        <c:set var="errorPassword">
                                                            <form:errors path="password" cssClass="invalid-feedback" />
                                                        </c:set>
                                                        <label for="inputPassword4" class="form-label">Password</label>
                                                        <form:input type="password"
                                                            class="form-control ${not empty errorPassword ? 'is-invalid' : ''}"
                                                            id="inputPassword4" path="password" />
                                                        ${errorPassword}
                                                        <!-- <div class="form-check">
                                                            <input class="form-check-input" type="checkbox" value=""
                                                                id="flexCheckDefault">
                                                            <label class="form-check-label" for="flexCheckDefault">
                                                                Hiện mật khẩu
                                                            </label>
                                                        </div> -->
                                                    </div>

                                                    <div class="col-12">
                                                        <label for="inputAddress2" class="form-label">Address</label>
                                                        <form:input type="text" class="form-control" id="inputAddress2"
                                                            placeholder="Apartment, studio, or floor" path="address" />
                                                    </div>
                                                    <div class="col-md-6 col-12">
                                                        <c:set var="errorUsername">
                                                            <form:errors path="user_name" cssClass="invalid-feedback" />
                                                        </c:set>
                                                        <label for="inputCity" class="form-label">Username</label>
                                                        <form:input type="text"
                                                            class="form-control ${not empty errorUsername ? 'is-invalid' : ''}"
                                                            id="inpuUsername" path="user_name" />
                                                        ${errorUsername}
                                                    </div>
                                                    <div class="col-md-6 col-12">
                                                        <label for="inputState" class="form-label">Role</label>
                                                        <form:select id="inputState" class="form-select"
                                                            path="role.name">
                                                            <c:forEach items="${lstRole}" var="role">
                                                                <form:option value="${role.name}">${role.name}
                                                                </form:option>
                                                            </c:forEach>
                                                            <!-- <form:option value="Admin">Admin</form:option>
                                                            <form:option value="User">User</form:option> -->
                                                        </form:select>
                                                    </div>
                                                    <div class="col-md-6 col-12">
                                                        <label for="inputCity" class="form-label">Avatar</label>
                                                        <input class="form-control" type="file" id="avatarFile"
                                                            accept=".png, .jpg, .jpeg" name="avatarUser" />
                                                    </div>
                                                    <div class="col-12 mb-3">
                                                        <img style="max-height: 200px; max-width: 200px; display: none; border-radius: 50px;"
                                                            alt="avatar preview" id="avatarPreview" />
                                                    </div>
                                                    <div class="col-12 mb-3">
                                                        <button type="submit" class="btn btn-primary">Create</button>
                                                        <a href="/admin/user"
                                                            class="btn btn-outline-secondary">Cancel</a>
                                                    </div>
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