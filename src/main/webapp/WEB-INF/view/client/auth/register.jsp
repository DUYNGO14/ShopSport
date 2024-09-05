<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <!-- <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css"> -->
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
                    <link rel="stylesheet" href="/css/client/style_login.css">
                    <!-- <link rel="stylesheet" href="/client/css/style.css"> -->
                    <title>Register Page</title>
                </head>

                <body>

                    <section id="header" style="margin-bottom: 10px;">
                        <a href="/"><img src="img/logo.png" class="logo" alt=""></a>
                    </section>

                    <div class="container active" id="container">
                        <div class="form-container sign-up">
                            <form:form method="post" action="/register" modelAttribute="newUser" class="row"
                                enctype="multipart/form-data">
                                <c:set var="errorEmail">
                                    <form:errors path="email" cssClass="invalid-feedback" />
                                </c:set>
                                <c:set var="errorConfirmPassword">
                                    <form:errors path="confirmPassword" cssClass="invalid-feedback" />
                                </c:set>
                                <c:set var="errorPassword">
                                    <form:errors path="password" cssClass="invalid-feedback" />
                                </c:set>
                                <c:set var="errorPhoneNumber">
                                    <form:errors path="phone_number" cssClass="invalid-feedback" />
                                </c:set>
                                <c:set var="errorFullName">
                                    <form:errors path="full_name" cssClass="invalid-feedback" />
                                </c:set>
                                <c:set var="errorUserName">
                                    <form:errors path="user_name" cssClass="invalid-feedback" />
                                </c:set>
                                <h1>Create Account</h1>
                                <!-- <div class="social-icons">
                                <a href="#" class="icon"><i class="fa-brands fa-google-plus-g"></i></a>
                                <a href="#" class="icon"><i class="fa-brands fa-facebook-f"></i></a>
                            </div> -->
                                <!-- <span>or use your email for registeration</span> -->
                                <form:input type="text" placeholder="Full Name" path="full_name" />
                                ${errorFullName}
                                <form:input type="text" placeholder="User Name" path="user_name" />
                                ${errorUserName}
                                <form:input type="email" placeholder="Email" path="email" />
                                ${errorEmail}
                                <form:input type="text" placeholder="Phone number" path="phone_number" />
                                ${phone_number}
                                <form:input type="password" placeholder="Password" path="password" />
                                ${errorPassword}
                                <form:input type="password" placeholder="confirmPassword" path="confirmPassword" />
                                ${errorConfirmPassword}
                                <button type="submit">Sign Up</button>
                            </form:form>
                        </div>z
                        <div class="toggle-container">
                            <div class="toggle">
                                <div class="toggle-panel toggle-left">
                                    <h1>Welcome Back!</h1>
                                    <p>Enter your personal details to use all of site features</p>
                                    <a href="/login"><button class="hidden" id="login1">Log In</button></a>
                                </div>

                            </div>
                        </div>
                    </div>

                    <script src="js/client/script_login.js"></script>
                </body>

                </html>