<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Blog Page</title>
                <!-- <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" /> -->
                <jsp:include page="../layout_client/head.jsp" />
            </head>

            <body>
                <jsp:include page="../layout_client/header.jsp" />
                <section id="page-header" class="blog-header"
                    style="background-image: url(/images/client/img/banner/banner2.png);;">
                </section>
                <section id="blog">
                    <div class="blog-box">
                        <div class="blog-img">
                            <img src="/images/client/img/banner/banner1.png" alt="">
                        </div>
                        <div class="blog-details">
                            <h4>ĐẶT IN ÁO LIÊN HỆ NGAY</h4>
                            <p>
                                Khách hàng có nhu cầu IN TÊN SỐ, đặt đội hoặc mua số lượng lớn từ 7 bộ vui lòng inbox để
                                SHOP hỗ trợ với giá tốt nhất cùng nhiều ưu đãi quà tặng đặc biệt</p>
                            <a href="#">CONTINUE READING</a>
                        </div>
                        <h1>13/01</h1>
                    </div>
                    <div class="blog-box">
                        <div class="blog-img">
                            <img src="/images/client/img/banner/banner2.png" alt="">
                        </div>
                        <div class="blog-details">
                            <h4>Hỗ trợ /Tư vấn chi tiết</h4>
                            <p>Hỗ trợ, tư vấn ngay qua messenger FB hoặc qua SĐT: 0528503503</p>
                            <a href="#">Liên hệ ngay!</a>
                        </div>
                        <h1>19/04</h1>
                    </div>
                    <div class="blog-box">
                        <div class="blog-img">
                            <img src="/images/client/img/banner/banner3.png" alt="">
                        </div>
                        <div class="blog-details">
                            <h4>Lorem, ipsum dolor sit ame</h4>
                            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Soluta, autem dignissimos
                                excepturi quaerat
                                ullam cupiditate, doloribus voluptate odit adipisci tenetur facere aut numquam.</p>
                            <a href="#">CONTINUE READING</a>
                        </div>
                        <h1>18/05</h1>
                    </div>
                </section>
                <section id="pagination" class="section-p1">
                    <a href="#">1</a>
                    <a href="#">2</a>
                    <a href="#"><i class="fa-solid fa-arrow-right"></i></a>
                </section>
                <jsp:include page="../layout_client/newsletter.jsp" />
                <jsp:include page="../layout_client/footer.jsp" />
                <script src="/js/client/script.js"></script>
            </body>

            </html>