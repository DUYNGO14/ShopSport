<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <section id="header">
            <a href="/home"><img src="img/logo1.png" class="logo" alt=""></a>
            <form class="d-flex ml-4" method="get" action="/shop">
                <input class="form-control border me-1 border-bottom" type="text" placeholder="Search"
                    aria-label="Search" name="keySearch" value="${keySearch}">
                <button class="btn btn-outline-danger" type="submit"><i
                        class="fa-solid fa-magnifying-glass"></i></button>
            </form>
            <div class="navbarCollapse">
                <ul id="navbar">
                    <li><a class="navbar-link active" href="/home">Home</a></li>
                    <li><a class="navbar-link" href="/shop">Shop</a></li>
                    <li><a class="navbar-link" href="/blog">Blog</a></li>
                    <li><a class="navbar-link" href="/contact">Contact</a></li>
                    <li><a class="navbar-link" href="/about">About</a></li>
                    <!-- <li id="lg-bag"><a href="cart"><i class="fa-solid fa-bag-shopping"></i></a></li> -->
                    <a href="#" id="close"><i class="fa-solid fa-xmark"></i></a>
                    <c:if test="${!not empty pageContext.request.userPrincipal}">
                        <li>
                            <a href="/cart">
                                <i class="fa-solid fa-bag-shopping"></i>
                                <span
                                    class="position-absolute rounded-circle d-flex align-items-center bg-danger justify-content-center px-1 "
                                    style="top: -5px; left: 25px; height: 10px; min-width: 10px;" id="sumCart">
                                    ${sessionScope.sum}
                                </span>
                            </a>
                        </li>

                        <li><a id="login" href="/login">Login</a></li>
                        <li><a id="register" href="/register">Register</a></li>
                    </c:if>
                    <c:if test="${not empty pageContext.request.userPrincipal}">
                        <li>
                            <a href="/cart" class="navbar-link ">
                                <i class="fa-solid fa-bag-shopping"></i>
                                <span
                                    class="position-absolute rounded-circle d-flex align-items-center justify-content-center px-1"
                                    style="top: -5px; left: 25px; height: 10px; min-width: 10px;" id="sumCart">
                                    ${sessionScope.sum}
                                </span>
                            </a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class=" dropdown-toggle navbar-link " href="#" id="navbarDarkDropdownMenuLink"
                                data-bs-toggle="dropdown" aria-expanded="false">
                                <c:out value="${sessionScope.username}" />
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDarkDropdownMenuLink"
                                style="background-color: #e3e6f3;">
                                <li><a href="/myaccount">My Account</a></li>
                                <li><a href="/history_order">History order</a></li>
                                <li>
                                    <form method="post" action="/logout">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <button
                                            style="border: none; background-color: #e3e6f3; font-weight: 600;">Logout</button>
                                    </form>
                                </li>

                            </ul>
                        </li>

                    </c:if>
                </ul>
            </div>
            <div id="mobile">
                <a href="cart"><i class="fa-solid fa-bag-shopping"></i></a>
                <i id="bar" class="fa-solid fa-bars"></i>
            </div>
        </section>