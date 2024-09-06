package com.duyngostore.shopsport.controller.client;

import java.net.http.HttpRequest;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.repository.query.Param;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;

import com.duyngostore.shopsport.domain.Cart;
import com.duyngostore.shopsport.domain.CartDetail;
import com.duyngostore.shopsport.domain.Product;
import com.duyngostore.shopsport.domain.Product_;
import com.duyngostore.shopsport.domain.User;
import com.duyngostore.shopsport.domain.dto.ProductCriterioDTO;
import com.duyngostore.shopsport.domain.dto.RegisterDTO;
import com.duyngostore.shopsport.domain.mapper.MapperRegister;
import com.duyngostore.shopsport.service.ProductService;
import com.duyngostore.shopsport.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class UserController {

    private final UserService userService;
    private final ProductService productService;
    private final MapperRegister mapperRegister;
    private final PasswordEncoder passwordEncoder;

    public UserController(UserService userService, ProductService productService, MapperRegister mapperRegister,
            PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.productService = productService;
        this.mapperRegister = mapperRegister;
        this.passwordEncoder = passwordEncoder;
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
        model.addAttribute("lstProduct", this.productService.getAllProduct());
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
        Page<Product> prs = this.productService.fetchProductsWithSpec(pageable, productCriterioDTO);
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

    @GetMapping("/login")
    public String getLoginPage(Model model) {
        model.addAttribute("newUser", new User());
        return "client/auth/login";
    }

    @GetMapping("/register")
    public String getRegisterPage(Model model) {
        model.addAttribute("newUser", new RegisterDTO());
        return "client/auth/register";
    }

    @PostMapping("/register")
    public String postRegisterUser(@ModelAttribute("newUser") @Valid RegisterDTO newUser,
            BindingResult newUserBindingResult) {
        if (newUserBindingResult.hasErrors()) {
            return "client/auth/register";
        }
        User user = this.mapperRegister.registerDTOtoUser(newUser);
        String hashPassword = this.passwordEncoder.encode(user.getPassword());
        user.setPassword(hashPassword);
        user.setRole(this.userService.getRoleByName("User"));
        user.setCreatedAt(Instant.now());
        this.userService.handleSaveUser(user);
        return "redirect:/login";
    }

    @GetMapping("/access-deny")
    public String getPage404(Model model) {
        return "/client/auth/error404";
    }

    @GetMapping("/search")
    public String getProductbyKeySearch(Model model, @Param("keySearch") String keySearch) {
        List<Product> listproduct = this.productService.searchProduct(keySearch);
        model.addAttribute("keySearch", keySearch);
        model.addAttribute("lstProduct", listproduct);
        return "redirect:/shop";
    }
}
