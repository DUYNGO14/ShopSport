package com.duyngostore.shopsport.domain.dto;

import com.duyngostore.shopsport.service.validator.RegisterChecked;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@RegisterChecked
public class RegisterDTO {
    @NotNull
    @Size(min = 3, message = "Fullname phải có tối thiểu 3 ký tự")
    private String full_name;
    @NotNull
    @Size(min = 3, message = "Username phải có tối thiểu 3 ký tự")
    private String user_name;
    @NotNull
    @Email(message = "Email không hợp lệ", regexp = "^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$")
    private String email;
    @Pattern(regexp = "(^$|[0-9]{10})", message = "Phone number là số và độ dài là 10")
    private String phone_number;
    @NotNull
    @Size(min = 6, message = "Password phải có tối thiểu 6 ký tự")
    private String password;
    @NotNull
    @Size(min = 6, message = "Password phải có tối thiểu 6 ký tự")
    private String confirmPassword;

}
