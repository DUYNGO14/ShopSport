package com.duyngostore.shopsport.controller.client;

import java.time.Instant;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.duyngostore.shopsport.domain.Feedback;
import com.duyngostore.shopsport.domain.Order;
import com.duyngostore.shopsport.domain.Product;
import com.duyngostore.shopsport.domain.User;
import com.duyngostore.shopsport.service.FeedbackService;
import com.duyngostore.shopsport.service.OrderService;
import com.duyngostore.shopsport.service.ProductService;
import com.duyngostore.shopsport.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class FeedbackController {
    private final FeedbackService feedbackService;
    private final UserService userService;
    private final ProductService productService;
    private final OrderService orderService;

    public FeedbackController(FeedbackService feedbackService, ProductService productService, UserService userService,
            OrderService orderService) {
        this.feedbackService = feedbackService;
        this.userService = userService;
        this.productService = productService;
        this.orderService = orderService;
    }

    @PostMapping("/feedback")
    public String feedback(@ModelAttribute("newFeedback") @Valid Feedback newFeedback, Model model,
            HttpServletRequest request) {
        HttpSession session = request.getSession();
        long id = (long) session.getAttribute("id");
        User user = this.userService.getUserById(id);
        Product product = this.productService.getProductById(newFeedback.getProduct().getId()).get();
        Order order = this.orderService.findOrderById(newFeedback.getOrder().getId()).get();
        newFeedback.setUser(user);
        newFeedback.setProduct(product);
        newFeedback.setOrder(order);
        newFeedback.setCreatedAt(Instant.now());
        this.feedbackService.save(newFeedback);
        return "redirect:/history_order";
    }

}
