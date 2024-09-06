<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
                <link rel="stylesheet" href="/css/client/style_login.css">
                <!-- <link rel="stylesheet" href="/client/css/style.css"> -->
                <title>Login Page</title>
            </head>

            <body>

                <section id="header" style="margin-bottom: 10px;">
                    <a href="/"><img src="img/logo.png" class="logo" alt=""></a>
                </section>

                <div class="container" id="container">

                    <div class="form-container sign-in">
                        <form method="post" action="/login" class="row">
                            <h1>Đăng nhập</h1>
                            <div class="social-icons">
                                <a href="#" class="icon"><i class="fa-brands fa-google-plus-g"></i></a>
                                <a href="#" class="icon"><i class="fa-brands fa-facebook-f"></i></a>
                            </div>
                            <span>or</span>
                            <input type="text" placeholder="Username" name="username" />
                            <input type="password" placeholder="Password" name="password" />
                            <!-- <div style="display: block;">
                                <input type="checkbox" name="remember-me">
                                <label>Remember-me</label>
                            </div> -->

                            <c:if test="${param.error != null}">
                                <div style="color: red; font-size: 12px; ">Invalid username or password.
                                </div>
                            </c:if>
                            <c:if test="${param.logout != null}">
                                <div style="color: rgb(0, 255, 106); font-size: 12px; ">Logout sucusses!.
                                </div>
                            </c:if>

                            <a href="#">Forget Your Password?</a>

                            <button type="submit">Đăng nhập</button>
                            <div>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            </div>
                        </form>
                    </div>
                    <div class="toggle-container">
                        <div class="toggle">
                            <div class="toggle-panel toggle-right">
                                <h1>Hello, Friend!</h1>

                                <a href="/register"><button class="hidden" id="register1">Đăng kí</button></a>
                                <a href="/home"><button class="hidden" id="login1">Trang chủ</button></a>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="/js/client/script_login.js"></script>
            </body>

            </html>