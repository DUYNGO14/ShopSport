<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Contact Page</title>
                <!-- <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" /> -->
                <jsp:include page="../layout_client/head.jsp" />
            </head>

            <body>
                <jsp:include page="../layout_client/header.jsp" />
                <section id="page-header" class="about-header"
                    style="background-image: url(/images/client/img/about/banner.png);">
                    <h2>#Contact</h2>
                    <p>RLorem ipsum dolor sit amet consectetur!</p>
                </section>
                <section id="contact-details" class="section-p1">
                    <div class="details">
                        <span>GET IN TOUCH</span>
                        <h2>Visit one of our agency locations or contact us today</h2>
                        <h3>Head Office</h3>
                        <div>
                            <li>
                                <i class="fa-solid fa-map"></i>
                                <p>56 Abc Street Cdtt G1 Hue</p>
                            </li>
                            <li>
                                <i class="fa-solid fa-envelope"></i>
                                <p>abcdbs@gmail.com</p>
                            </li>
                            <li>
                                <i class="fa-solid fa-phone"></i>
                                <p>(+84) 123456789</p>
                            </li>
                            <li>
                                <i class="fa-solid fa-clock"></i>
                                <p>Monday to Saturday: 8.00am to 19.00pm</p>
                            </li>
                        </div>
                    </div>
                    <div class="map">
                        <iframe
                            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3828.9478674356938!2d107.76597919999995!3d16.325607800000007!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31419751ed10112b%3A0xa3dc54d122674bba!2zVHJ1bmcgaOG7jWMgcGjhu5UgdGjDtG5nIEFuIEzGsMahbmcgxJDDtG5n!5e0!3m2!1svi!2s!4v1719413373297!5m2!1svi!2s"
                            width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy"
                            referrerpolicy="no-referrer-when-downgrade"></iframe>
                    </div>
                </section>
                <section id="form-details">
                    <form action="">
                        <span>LEAVE A MESSAGE</span>
                        <h2>We love to hear from you</h2>
                        <input type="text" name="" id="" placeholder="Your Name">
                        <input type="text" name="" id="" placeholder="Email">
                        <input type="text" name="" id="" placeholder="Subject">
                        <textarea name="" id="" cols="30" rows="10" placeholder="Your Message"></textarea>
                        <button class="normal">Submit</button>
                    </form>
                    <div class="people">
                        <div>
                            <img src="/images/client/img/people/1.png" alt="">
                            <p><span>Ngo Duy</span> Senior Marketing Manager <br>Phone: +124 456 789 <br>Email:
                                abcd@gmail.com</p>
                        </div>
                        <div>
                            <img src="/images/client/img/people/2.png" alt="">
                            <p><span>Ngo Duy</span> Senior Marketing Manager <br>Phone: +124 456 789 <br>Email:
                                abcd@gmail.com</p>
                        </div>
                        <div>
                            <img src="/images/client/img/people/3.png" alt="">
                            <p><span>Ngo Duy</span> Senior Marketing Manager <br>Phone: +124 456 789 <br>Email:
                                abcd@gmail.com</p>
                        </div>
                    </div>

                </section>
                <jsp:include page="../layout_client/newsletter.jsp" />
                <jsp:include page="../layout_client/footer.jsp" />
                <script src="/js/client/script.js"></script>
            </body>

            </html>