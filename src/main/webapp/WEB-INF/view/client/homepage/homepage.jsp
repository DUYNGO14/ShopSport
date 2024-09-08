<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Trang chủ-Shop Sport</title>

                <!-- <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" /> -->
                <jsp:include page="../layout_client/head.jsp" />

            </head>

            <body>
                <jsp:include page="../layout_client/header.jsp" />
                <jsp:include page="../layout_client/banner.jsp" />

                <section id="product1" class="section-p1">
                    <h2>Home</h2>
                    <p>Summer Collection New Morden Design</p>
                    <div class="pro-container">
                        <c:forEach items="${lstProduct}" var="product">
                            <div class="pro">
                                <img src="/images/product/${product.image}" alt=""
                                    onclick="window.location.href='/sproduct/${product.id}'">
                                <div class="des">
                                    <span>adidas</span>
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

                    </div>
                </section>
                <jsp:include page="../layout_client/sm_banner.jsp" />
                <jsp:include page="../layout_client/newsletter.jsp" />
                <jsp:include page="../layout_client/footer.jsp" />
                <script src="/js/client/script.js"></script>
            </body>

            </html>