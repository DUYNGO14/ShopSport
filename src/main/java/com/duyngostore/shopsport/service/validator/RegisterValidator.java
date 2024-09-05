package com.duyngostore.shopsport.service.validator;

import org.springframework.stereotype.Service;

import com.duyngostore.shopsport.domain.dto.RegisterDTO;
import com.duyngostore.shopsport.service.UserService;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

@Service
public class RegisterValidator implements ConstraintValidator<RegisterChecked, RegisterDTO> {

    private final UserService userService;

    public RegisterValidator(UserService userService) {
        this.userService = userService;
    }

    @Override
    public boolean isValid(RegisterDTO user, ConstraintValidatorContext context) {
        boolean valid = true;

        // Check if password fields match
        if (!user.getPassword().equals(user.getConfirmPassword())) {
            context.buildConstraintViolationWithTemplate("Passwords không trùng khớp")
                    .addPropertyNode("confirmPassword")// báo thông tin trường có lỗi
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            valid = false;
        }

        // Additional validations can be added here
        // check email
        if (this.userService.checkEmailExist(user.getEmail())) {
            context.buildConstraintViolationWithTemplate("Email đã tồn tại")
                    .addPropertyNode("email")// báo thông tin trường có lỗi
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            valid = false;
        }

        if (this.userService.checkUserNameExist(user.getUser_name())) {
            context.buildConstraintViolationWithTemplate("User name đã tồn tại")
                    .addPropertyNode("user_name")// báo thông tin trường có lỗi
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            valid = false;
        }
        return valid;
    }
}
