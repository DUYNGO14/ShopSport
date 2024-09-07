package com.duyngostore.shopsport.controller.admin;

import java.time.Instant;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.duyngostore.shopsport.domain.Feedback;
import com.duyngostore.shopsport.domain.User;
import com.duyngostore.shopsport.service.FeedbackService;
import com.duyngostore.shopsport.service.OrderService;
import com.duyngostore.shopsport.service.ProductService;
import com.duyngostore.shopsport.service.UploadService;
import com.duyngostore.shopsport.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class AdminController {

    private final UserService userService;
    private final UploadService uploadService;
    private final PasswordEncoder passwordEncoder;
    private final ProductService productService;
    private final OrderService orderService;
    private final FeedbackService feedbackService;

    public AdminController(UserService userService, UploadService uploadService, PasswordEncoder passwordEncoder,
            ProductService productService, OrderService orderService, FeedbackService feedbackService) {
        this.userService = userService;
        this.uploadService = uploadService;
        this.passwordEncoder = passwordEncoder;
        this.productService = productService;
        this.orderService = orderService;
        this.feedbackService = feedbackService;
    }

    @GetMapping("/admin")
    public String getAdminPage(Model model) {
        List<User> listUser = this.userService.getFindAllUser();
        model.addAttribute("listUser", listUser);
        model.addAttribute("countUser", this.userService.countUser());
        model.addAttribute("countProduct", this.productService.countProduct());
        model.addAttribute("countOrder", this.orderService.countOrder());
        return "admin/homepage/homepage";
    }

    @GetMapping("/admin/user")
    public String getAdminPage1(Model model, @RequestParam("page") Optional<String> pageOptional) {
        int page = 1;
        try {
            if (pageOptional.isPresent()) {
                page = Integer.parseInt(pageOptional.get());
            } else {

            }
        } catch (Exception e) {
            // TODO: handle exception
        }
        Pageable pageable = PageRequest.of(page - 1, 5);
        Page<User> prs = this.userService.getAllUsers(pageable);
        List<User> listUser = prs.getContent();
        model.addAttribute("listUser", listUser);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", prs.getTotalPages());
        return "admin/user/show";
    }

    @GetMapping("/admin/user/create")
    public String getCreateUerPage(Model model) {
        model.addAttribute("newUser", new User());
        model.addAttribute("lstRole", this.userService.getFindAllRole());
        return "admin/user/create";
    }

    @GetMapping("/admin/user/update")
    public String getUpdateUserPage(Model model) {
        model.addAttribute("newUser", new User());

        return "admin/user/update";
    }

    // Show User
    @GetMapping("/admin/user/{id}")
    public String getMethodName(Model model, @PathVariable long id) {
        User user = this.userService.getUserById(id);
        model.addAttribute("user", user);
        model.addAttribute("id", id);
        return "admin/user/view";
    }

    // Create admin
    @PostMapping("/admin/user/create")
    public String postCreateUser(@ModelAttribute("newUser") @Valid User newUser,
            BindingResult newUserBindingResult,
            @RequestParam("avatarUser") MultipartFile file, Model model,
            HttpServletRequest request) {

        if (newUserBindingResult.hasErrors()) {
            model.addAttribute("lstRole", this.userService.getFindAllRole());
            return "admin/user/create";
        }
        HttpSession session = request.getSession();
        String avatar = this.uploadService.handleSaveUploadFile(file, "avatar");
        String hashPassword = this.passwordEncoder.encode(newUser.getPassword());
        newUser.setRole(this.userService.getRoleByName(newUser.getRole().getName()));
        newUser.setPassword(hashPassword);
        newUser.setAvatar(avatar);
        newUser.setCreatedBy((String) session.getAttribute("username"));
        newUser.setCreatedAt(Instant.now());
        this.userService.handleSaveUser(newUser);
        return "redirect:/admin";
    }

    @GetMapping("/admin/user/update/{id}") // GET
    public String getUpdateUserPage(Model model, @PathVariable long id) {
        User currentUser = this.userService.getUserById(id);
        model.addAttribute("newUser", currentUser);
        model.addAttribute("lstRole", this.userService.getFindAllRole());
        model.addAttribute("id", id);

        return "admin/user/update";
    }

    @PostMapping("/admin/user/update")
    public String postUpdateUser(Model model, @ModelAttribute("newUser") @Valid User user,
            BindingResult newProductBindingResult,
            @RequestParam("avatarUser") MultipartFile file,
            HttpServletRequest request) {
        User currentUser = this.userService.getUserById(user.getId());
        HttpSession session = request.getSession();
        if (currentUser != null) {
            if (!file.isEmpty()) {
                String img = this.uploadService.handleSaveUploadFile(file, "avatar");
                currentUser.setAvatar(img);
            }
            currentUser.setAddress(user.getAddress());
            currentUser.setFull_name(user.getFull_name());
            currentUser.setPhone_number(user.getPhone_number());
            currentUser.setRole(this.userService.getRoleByName(user.getRole().getName()));
            currentUser.setUpdatedBy((String) session.getAttribute("username"));
            currentUser.setUpdatedAt(Instant.now());
            // bug here
            this.userService.handleSaveUser(currentUser);
        }
        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/delete/{id}")
    public String getDeleteUserPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        // User user = new User();
        // user.setId(id);
        model.addAttribute("newUser", new User());
        return "admin/user/delete";
    }

    @PostMapping("/admin/user/delete")
    public String postDeleteUser(Model model, @ModelAttribute("newUser") User user) {
        this.userService.deleteById(user.getId());
        return "redirect:/admin/user";
    }

    // feedback
    @GetMapping("/admin/feedback")
    public String getFeedback(Model model, @RequestParam("page") Optional<String> pageOptional) {
        int page = 1;
        try {
            if (pageOptional.isPresent()) {
                page = Integer.parseInt(pageOptional.get());
            } else {

            }
        } catch (Exception e) {
            // TODO: handle exception
        }
        Pageable pageable = PageRequest.of(0, 12);
        Page<Feedback> prs = this.feedbackService.getAll(pageable);
        List<Feedback> lstFeedbacks = prs.getContent();
        model.addAttribute("lstFeedbacks", lstFeedbacks);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", prs.getTotalPages() == 0 ? 1 : prs.getTotalPages());
        return "admin/feedback/show";
    }

}
