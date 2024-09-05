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
                    $(document).ready(() => {
                        const listImageFile = $("#listImageFile");
                        const sl = listImageFile.length();
                        listImageFile.change(function (e) {
                            const imgURL = URL.createObjectURL(e.target.files[0]);
                            $("#listImagePreview").attr("src", imgURL);
                            $("#listImagePreview").css({ "display": "block" });
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
                                                <li class="breadcrumb-item"><a href="/admin/product">Product</a>
                                                </li>
                                                <li class="breadcrumb-item active" aria-current="page">Create Product
                                                </li>
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
                                                <h3 class="fw-bold mt-3 text-center">Create new product</h3>
                                                <hr />
                                                <form:form class="row g-3" method="post" action="/admin/product/create"
                                                    modelAttribute="newProduct" enctype="multipart/form-data">
                                                    <c:set var="errorName">
                                                        <form:errors path="name" cssClass="invalid-feedback" />
                                                    </c:set>
                                                    <c:set var="errorPrice">
                                                        <form:errors path="price" cssClass="invalid-feedback" />
                                                    </c:set>
                                                    <c:set var="errorDescription">
                                                        <form:errors path="description" cssClass="invalid-feedback" />
                                                    </c:set>
                                                    <c:set var="errorQuantity">
                                                        <form:errors path="quantity" cssClass="invalid-feedback" />
                                                    </c:set>
                                                    <c:set var="errorMaterial">
                                                        <form:errors path="material" cssClass="invalid-feedback" />
                                                    </c:set>
                                                    <div class="col-md-6 col-12">
                                                        <label for="inputName" class="form-label">Name
                                                            Product:</label>
                                                        <form:input type="text"
                                                            class="form-control ${not empty errorName ? 'is-invalid' : ''}"
                                                            id="inputName" path="name" />
                                                        ${errorName}
                                                    </div>
                                                    <div class="col-md-6 col-12">
                                                        <label for="inputPrice" class="form-label">Price:
                                                        </label>
                                                        <form:input type="number"
                                                            class="form-control ${not empty errorPrice ? 'is-invalid' : ''}"
                                                            id="inputPrice" path="price" />
                                                        ${errorPrice}
                                                    </div>
                                                    <div class="col-md-6 col-12">

                                                        <label for="inputQuantity" class="form-label">Quantity:</label>
                                                        <form:input type="number"
                                                            class="form-control ${not empty errorQuantity ? 'is-invalid' : ''} "
                                                            id="inputQuantity" path="quantity" />
                                                        ${errorQuantity}
                                                    </div>
                                                    <div class="col-md-6 col-12">
                                                        <label for="inputDescription"
                                                            class="form-label">Description:</label>
                                                        <form:input type="text"
                                                            class="form-control ${not empty errorQuantity ? 'is-invalid' : ''} "
                                                            id="inputDescription" path="description" />
                                                        ${errorDescription}
                                                    </div>
                                                    <div class="col-md-6 col-12">
                                                        <label for="inpuMaterial" class="form-label">Material:</label>
                                                        <form:select id="inputState" class="form-select"
                                                            path="material">
                                                            <form:option value="Vải thái cao cấp">Vải thái cao cấp
                                                            </form:option>
                                                            <form:option value="Vải thun lạnh"> Vải thun lạnh
                                                            </form:option>
                                                        </form:select>
                                                        ${errorMaterial}
                                                    </div>
                                                    <div class="col-md-6 col-12">
                                                        <label class="form-label">Factory:</label>
                                                        <form:select class="form-select" path="factory">
                                                            <form:option value="ADIDAS">ADIDAS</form:option>
                                                            <form:option value="NIKE">NIKE</form:option>
                                                            <form:option value="PUMA">PUMA</form:option>
                                                            <form:option value="UMBRO">UMBRO</form:option>
                                                        </form:select>
                                                    </div>
                                                    <div class="col-md-6 col-12">
                                                        <label for="inputState" class="form-label">Category:</label>
                                                        <form:select id="inputState" class="form-select"
                                                            path="category.name">
                                                            <option value="select">Select :</option>
                                                            <c:forEach items="${lstCategory}" var="category">
                                                                <form:option value="${category.name}">${category.name}
                                                                </form:option>
                                                            </c:forEach>
                                                            <!-- <form:option value="Club">Club</form:option>
                                                            <form:option value="National">National</form:option> -->
                                                        </form:select>
                                                    </div>
                                                    <div class="col-md-6 col-12">
                                                        <label for="inputDiscount" class="form-label">Discount:</label>
                                                        <form:input type="number" class="form-control "
                                                            id="inputDiscount" path="discount" />
                                                    </div>
                                                    <div class="col-md-6 col-12">
                                                        <label for="avatarFile" class="form-label">Avatar</label>
                                                        <input class="form-control" type="file" id="avatarFile"
                                                            accept=".png, .jpg, .jpeg .webp" name="avatarProduct" />
                                                    </div>
                                                    <div class="col-12 mb-3">
                                                        <img style="max-height: 200px; max-width: 200px; display: none;"
                                                            alt="avatar preview" id="avatarPreview" />
                                                    </div>
                                                    <div class="col-md-6 col-12">
                                                        <label for="avatarFile" class="form-label">Product description
                                                            images:</label>
                                                        <input class="form-control" type="file" id="listImageFile"
                                                            accept=".png, .jpg, .jpeg .webp" name="listImageProduct"
                                                            multiple />
                                                    </div>
                                                    <div class="col-12 mb-3 d-inline">
                                                        <img style="max-height: 200px; max-width: 200px; display: none;"
                                                            alt="avatar image_preview" id="listImagePreview" />
                                                    </div>
                                                    <div class="col-12 mb-3">
                                                        <button type="submit"
                                                            class="btn btn-outline-primary">Create</button>
                                                        <a href="/admin/product"
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