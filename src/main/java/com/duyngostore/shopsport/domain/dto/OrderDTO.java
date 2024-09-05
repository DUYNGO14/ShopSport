package com.duyngostore.shopsport.domain.dto;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderDTO {
    @NotNull
    @Size(min = 1, message = "Tên người nhận không được để trống")
    private String receive_FullName;
    @NotNull
    @Size(min = 10, message = "Địa chỉ không được để trống")
    private String receive_Address;
    @NotNull
    @Size(min = 10, max = 10, message = "PhoneNumber không được để trống")
    @Pattern(regexp = "(^$|[0-9]{10})", message = "Phone number là số và độ dài là 10")
    private String receive_PhoneNumber;
}
