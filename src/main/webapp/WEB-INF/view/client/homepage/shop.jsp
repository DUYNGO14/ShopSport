<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Shop</title>
                <!-- <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" /> -->
                <jsp:include page="../layout_client/head.jsp" />
            </head>

            <body>
                <jsp:include page="../layout_client/header.jsp" />
                <section id="page-header" style="background-image: url(/images/client/img/about/banner.png);">
                    <h2>#Shop</h2>
                    <p>Save more with coupons & up to 70% off!</p>
                </section>

                <section id="product1" class="section-p1">
                    <h2>Sản phẩm</h2>
                    <p>Áo tuyển quốc gia - Áo câu lạc bộ</p>
                    <div class="row g-4">
                        <div class="col-lg-2 col-12">
                            <div class="row g-4">
                                <div class="col-lg-12 col-md-6" id="categoryFilter">
                                    <div class="mb-3">
                                        <h4>Danh mục</h4>
                                        <ul class="list-unstyled categorie">
                                            <li>
                                                <div class="d-flex justify-content-start">
                                                    <input type="checkbox" class="me-2 form-check-input"
                                                        id="Categories-1" name="Categories-1" value="Club">
                                                    <label for="Categories-1">Câu lạc bộ</label>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="d-flex justify-content-start">
                                                    <input type="checkbox" class="me-2 form-check-input"
                                                        id="Categories-2" name="Categories-2" value="National">
                                                    <label for="Categories-2">Đội tuyển quốc gia</label>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-lg-12 col-md-6" id="factoryFilter">
                                    <div class="mb-3">
                                        <h4>Hãng sản xuất</h4>
                                        <ul class="list-unstyled categorie">
                                            <li>
                                                <div class="d-flex justify-content-start">
                                                    <input type="checkbox" class="me-2  form-check-input"
                                                        id="Categories-1" name="Categories-1" value="Adidas">
                                                    <label for="Categories-1">Adidas</label>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="d-flex justify-content-start">
                                                    <input type="checkbox" class="me-2  form-check-input"
                                                        id="Categories-2" name="Categories-2" value="Nike">
                                                    <label for="Categories-2">Nike</label>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="d-flex justify-content-start">
                                                    <input type="checkbox" class="me-2  form-check-input"
                                                        id="Categories-2" name="Categories-2" value="Puma">
                                                    <label for="Categories-2">Puma</label>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="d-flex justify-content-start">
                                                    <input type="checkbox" class="me-2  form-check-input"
                                                        id="Categories-2" name="Categories-2" value="Umbro">
                                                    <label for="Categories-2">Umbro</label>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>

                                </div>
                                <div class="col-lg-12 col-md-6" id="sortFilter">
                                    <div class="mb-3">
                                        <h4 class="d-flex justify-content-start ">Sắp xếp giá tiền</h4>
                                        <ul class="list-unstyled fruite-categorie">
                                            <li>
                                                <div class="d-flex justify-content-start ">
                                                    <input type="radio" class="me-2  form-check-input" id="sort-1"
                                                        name="radio-sort" value="gia-tang-dan">
                                                    <label for="Categories-1"> Sắp xếp tăng dần</label>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="d-flex justify-content-start ">
                                                    <input type="radio" class="me-2  form-check-input" id="sort-2"
                                                        name="radio-sort" value="gia-giam-dan">
                                                    <label for="Categories-1"> Sắp xếp giảm dần</label>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="d-flex justify-content-start">
                                                    <input type="radio" class="me-2  form-check-input" id="sort-3"
                                                        name="radio-sort" value="khong-sap-xep" checked>
                                                    <label for="Categories-1">Không sắp xếp</label>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-12">

                                    <button type="button" id="btnFilter" class="btn btn-outline-success"> Lọc Sản
                                        Phẩm</button>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-10 col-12 pro-container d-flex justify-content-start">
                            <c:if test="${empty lstProduct}">
                                <div>
                                    <p class="text-center fs-2 fw-bold">Không tìm thấy sản phẩm nào.</p>
                                </div>
                            </c:if>
                            <c:if test="${!empty lstProduct}">
                                <c:forEach items="${lstProduct}" var="product">
                                    <div class="pro mx-2">
                                        <img src="/images/product/${product.image}" alt=""
                                            onclick="window.location.href='/sproduct/${product.id}'">
                                        <div class="des">
                                            <span>${product.factory}</span>
                                            <h5>${product.name}</h5>
                                            <div class="star">
                                                <i class="fa-solid fa-star"></i>
                                                <i class="fa-solid fa-star"></i>
                                                <i class="fa-solid fa-star"></i>
                                                <i class="fa-solid fa-star"></i>
                                                <i class="fa-solid fa-star"></i>
                                            </div>
                                            <h4>
                                                <fmt:formatNumber type="number" value="${product.price}" /> đ
                                            </h4>
                                        </div>
                                        <form action="/cart/${product.id}" method="post">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                            <button><i class="fa-solid fa-bag-shopping cart"></i></button>
                                        </form>
                                    </div>
                                </c:forEach>
                            </c:if>
                        </div>
                    </div>
                </section>
                <c:if test="${!empty lstProduct}">
                    <nav aria-label="Page navigation example">
                        <ul class="pagination justify-content-center">
                            <li class=" ${1 eq currentPage ? 'disabled page-item' : 'page-item'}">
                                <a class="page-link" href="/shop?page=${currentPage - 1}${queryString}"
                                    aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                            <c:forEach begin="0" end="${totalPages - 1}" varStatus="loop">
                                <li class="page-item">
                                    <a class="${(loop.index + 1) eq currentPage ? 'active page-link' : 'page-link'}"
                                        href="/shop?page=${loop.index + 1}${queryString}">
                                        ${loop.index + 1}
                                    </a>
                                </li>
                            </c:forEach>
                            <li class=" ${totalPages eq currentPage ? 'disabled page-item' : 'page-item'}">
                                <a class="page-link" href="/shop?page=${currentPage + 1}${queryString}"
                                    aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
                <jsp:include page="../layout_client/newsletter.jsp" />
                <jsp:include page="../layout_client/footer.jsp" />

                <script src="/js/client/script.js"></script>
            </body>

            </html>