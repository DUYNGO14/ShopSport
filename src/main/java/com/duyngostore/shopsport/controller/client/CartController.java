package com.duyngostore.shopsport.controller.client;

import java.util.ArrayList;
import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.duyngostore.shopsport.domain.Cart;
import com.duyngostore.shopsport.domain.CartDetail;
import com.duyngostore.shopsport.domain.Order;
import com.duyngostore.shopsport.domain.User;
import com.duyngostore.shopsport.domain.dto.OrderDTO;
import com.duyngostore.shopsport.domain.mapper.MapperOrder;
import com.duyngostore.shopsport.domain.mapper.MapperRegister;
import com.duyngostore.shopsport.service.EmailService;
import com.duyngostore.shopsport.service.OrderService;
import com.duyngostore.shopsport.service.ProductService;
import com.duyngostore.shopsport.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class CartController {
    private final UserService userService;
    private final ProductService productService;
    private final MapperRegister mapperRegister;
    private final PasswordEncoder passwordEncoder;
    private final MapperOrder mapperOrder;
    private final OrderService orderService;
    private final EmailService emailService;

    public CartController(UserService userService, ProductService productService, MapperRegister mapperRegister,
            MapperOrder mapperOrder,
            PasswordEncoder passwordEncoder, OrderService orderService, EmailService emailService) {
        this.userService = userService;
        this.productService = productService;
        this.mapperRegister = mapperRegister;
        this.passwordEncoder = passwordEncoder;
        this.mapperOrder = mapperOrder;
        this.orderService = orderService;
        this.emailService = emailService;
    }

    @PostMapping("/cart/{id}")
    public String addProductToCart(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession();
        long productId = id;
        String email = (String) session.getAttribute("email");
        this.productService.handleAddProductToCart(email, id, session, 1, "M");

        return "redirect:/home";
    }

    @PostMapping("/delete-cart-product/{id}")
    public String postMethodName(@PathVariable long id, HttpServletRequest request) {
        // TODO: process POST request
        HttpSession session = request.getSession();
        long cartDetail = id;
        this.productService.handleDeleteProductToCart(session, id);
        return "redirect:/cart";
    }

    @GetMapping("/checkout")
    public String getCheckOutPage(Model model, HttpServletRequest request) {
        User currentUser = new User();// null
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        currentUser.setId(id);

        Cart cart = this.productService.getCartByUser(currentUser);

        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getLstCartDetail();
        double totalPrice = 0;
        for (CartDetail cd : cartDetails) {
            totalPrice += cd.getPrice() * cd.getQuantity();
        }
        model.addAttribute("newOrder", new OrderDTO());
        model.addAttribute("lstProduct", cartDetails);
        model.addAttribute("totalPrice", totalPrice);

        return "client/carts/checkout";
    }

    @PostMapping("/confirm-checkout")
    public String getCheckOutPage(@ModelAttribute("cart") Cart cart) {
        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getLstCartDetail();
        this.productService.handleUpdateCartBeforeCheckout(cartDetails);
        return "redirect:/checkout";
    }

    @GetMapping("/place-order")
    public String getPagePlaceOrder(Model model) {
        return "redirect:/confirm-checkout";
    }

    @PostMapping("/place-order")
    public String postPlaceOrder(Model model, @ModelAttribute("newOrder") @Valid OrderDTO newOrder,
            HttpServletRequest request,
            BindingResult newBindingResult) {
        if (newBindingResult.hasErrors()) {
            return "/place-order";
        }
        User currentUser = new User();
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        Order order = this.mapperOrder.orderDTOtoOrder(newOrder);
        String fullname = (String) session.getAttribute("fullName");
        String email = (String) session.getAttribute("email");
        currentUser.setId(id);

        this.productService.handlePlaceOrder(currentUser, session, order);
        // String subject = "Thư cảm ơn từ shopsport";
        // String content = "<h3>Cảm ơn bạn" + fullname + " đã tin tưởng đặt hàng Shop
        // sport!</h3>7\n"
        // + "<h4>Đơn hàng sẽ được giao đến bạn sớm nhất có thể </h4>/n"
        // + "<strong>Cảm ơn!</strong>";
        // this.emailService.sendEmailSync(email, subject, content, false, true);
        return "client/carts/thank";
    }

    @GetMapping("/history_order")
    public String getPageHistoryOrder(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        long id = (long) session.getAttribute("id");
        User user = new User();
        user.setId(id);
        List<Order> order = this.orderService.findOrderByUser(user);
        model.addAttribute("orders", order);
        return "client/carts/history_order";
    }

    @PostMapping("/add-product-from-view-detail")
    public String handleAddProductFromViewDetail(
            @RequestParam("id") long id,
            @RequestParam("quantity") long quantity,
            @RequestParam("size") String size,
            HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        this.productService.handleAddProductToCart(email, id, session, quantity, size);
        return "redirect:/sproduct/" + id;
    }

}
