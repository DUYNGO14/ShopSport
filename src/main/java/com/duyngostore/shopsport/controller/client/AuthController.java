package com.duyngostore.shopsport.controller.client;

import java.time.Instant;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.duyngostore.shopsport.domain.User;
import com.duyngostore.shopsport.domain.dto.RegisterDTO;
import com.duyngostore.shopsport.domain.mapper.MapperRegister;
import com.duyngostore.shopsport.service.EmailService;
import com.duyngostore.shopsport.service.UserService;

import jakarta.validation.Valid;

@Controller
public class AuthController {

    private final UserService userService;
    private final MapperRegister mapperRegister;
    private final EmailService emailService;
    private final PasswordEncoder passwordEncoder;

    public AuthController(UserService userService, MapperRegister mapperRegister,
            PasswordEncoder passwordEncoder, EmailService emailService) {
        this.userService = userService;
        this.mapperRegister = mapperRegister;
        this.emailService = emailService;
        this.passwordEncoder = passwordEncoder;
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

        // gửi thư cảm ơn
        String subject = "Thư cảm ơn từ shopsport";
        String content = "<h3>Chào mừng " + user.getFull_name() + " đến với Shop sport!</h3>";
        this.emailService.sendEmailSync(user.getEmail(), subject, content, false, true);
        return "redirect:/login";
    }

    @GetMapping("/access-deny")
    public String getPage404(Model model) {
        return "/client/auth/error404";
    }
}
