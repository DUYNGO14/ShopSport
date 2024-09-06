package com.duyngostore.shopsport.controller.client;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.PathVariable;

import com.duyngostore.shopsport.domain.Cart;
import com.duyngostore.shopsport.domain.CartDetail;
import com.duyngostore.shopsport.domain.Product;
import com.duyngostore.shopsport.domain.Product_;
import com.duyngostore.shopsport.domain.User;
import com.duyngostore.shopsport.domain.dto.ProductCriterioDTO;

import com.duyngostore.shopsport.service.ProductService;
import com.duyngostore.shopsport.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {

    private final UserService userService;
    private final ProductService productService;

    public UserController(UserService userService, ProductService productService) {
        this.userService = userService;
        this.productService = productService;

    }

    @GetMapping("/")
    public String getHomePage(Model model) {
        Pageable pageable = PageRequest.of(0, 12);
        Page<Product> prs = this.productService.getAllProduct(pageable);
        List<Product> products = prs.getContent();
        model.addAttribute("lstProduct", prs.getContent());
        return "client/homepage/homepage";
    }

    @GetMapping("/home")
    public String getHomePage1(Model model) {
        Pageable pageable = PageRequest.of(0, 12);
        Page<Product> prs = this.productService.getAllProduct(pageable);
        List<Product> lstProduct = prs.getContent();
        model.addAttribute("lstProduct", lstProduct);
        return "client/homepage/homepage";
    }

    @GetMapping("/shop")
    public String getShopPage(Model model, @Param("keySearch") Optional<String> keySearch,
            ProductCriterioDTO productCriterioDTO, HttpServletRequest request) {
        int page = 1;
        try {
            if (productCriterioDTO.getPage().isPresent()) {
                page = Integer.parseInt(productCriterioDTO.getPage().get());
            } else {
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        Pageable pageable = PageRequest.of(page - 1, 12);
        if (productCriterioDTO.getSort() != null && productCriterioDTO.getSort().isPresent()) {
            String sort = productCriterioDTO.getSort().get();
            if (sort.equals("gia-tang-dan")) {
                pageable = PageRequest.of(page - 1, 10, Sort.by(Product_.PRICE).ascending());
            } else if (sort.equals("gia-giam-dan")) {
                pageable = PageRequest.of(page - 1, 10, Sort.by(Product_.PRICE).descending());
            }
        }

        String key = keySearch.isEmpty() ? "" : keySearch.get();
        Page<Product> prs = key == null ? this.productService.fetchProductsWithSpec(pageable, productCriterioDTO)
                : this.productService.getAllProduct(pageable, key);
        List<Product> lstProduct = prs.getContent().size() > 0 ? prs.getContent() : new ArrayList<Product>();
        String qs = request.getQueryString();
        if (qs != null && !qs.isBlank()) {
            // remove page
            qs = qs.replace("page=" + page, "");
        }

        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", prs.getTotalPages() == 0 ? 1 : prs.getTotalPages());
        model.addAttribute("lstProduct", lstProduct);
        model.addAttribute("keySearch", key);
        model.addAttribute("queryString", qs);
        return "client/homepage/shop";
    }

    @GetMapping("/blog")
    public String getBlogPage(Model model) {
        return "client/homepage/blog";
    }

    @GetMapping("/contact")
    public String getContactPage(Model model) {
        return "client/homepage/contact";
    }

    @GetMapping("/about")
    public String getAboutPage(Model model) {
        return "client/homepage/about";
    }

    @GetMapping("/cart")
    public String getCartPage(Model model, HttpServletRequest request) {
        User cuurentUser = new User();
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        cuurentUser.setId(id);
        Cart cart = this.productService.getCartByUser(cuurentUser);
        List<CartDetail> lstCartDetail = cart == null ? new ArrayList<CartDetail>() : cart.getLstCartDetail();
        double totalPrice = 0;
        for (CartDetail cartDetail : lstCartDetail) {
            totalPrice += cartDetail.getPrice() * cartDetail.getQuantity();
        }
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("lstProduct", lstCartDetail);
        model.addAttribute("cart", cart);
        return "client/carts/cart";
    }

    @GetMapping("/sproduct/{id}")
    public String getDetailProduct(Model model, @PathVariable long id) {
        model.addAttribute("product", this.productService.getProductById(id).get());
        model.addAttribute("lstProduct", this.productService.getAllProduct());
        return "client/products/sproduct";
    }

    // @GetMapping("/search")
    // public String getProductbyKeySearch(Model model, @Param("keySearch") String
    // keySearch) {
    // List<Product> listproduct = this.productService.searchProduct(keySearch);
    // model.addAttribute("keySearch", keySearch);
    // model.addAttribute("lstProduct", listproduct);
    // return "redirect:/shop";
    // }
}
