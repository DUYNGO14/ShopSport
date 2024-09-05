package com.duyngostore.shopsport.domain;

import java.time.Instant;
import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;

import jakarta.persistence.Table;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

@lombok.Getter
@lombok.Setter
@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    @NotNull
    @Size(min = 3, message = "Fullname phải có tối thiểu 3 ký tự")
    private String full_name;
    @NotNull
    @Size(min = 3, message = "Username phải có tối thiểu 3 ký tự")
    private String user_name;
    @NotNull
    @Email(message = "Email không hợp lệ", regexp = "^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$")
    private String email;
    private String address;
    @NotNull
    @Size(min = 6, message = "Password phải có tối thiểu 2 ký tự")
    // @StrongPassword()
    private String password;
    @Pattern(regexp = "(^$|[0-9]{10})", message = "Phone number là số và độ dài là 10")
    private String phone_number;
    private String avatar;
    private int deleted;
    Instant createdAt;
    Instant updatedAt;
    String createdBy;
    String updatedBy;
    // role_id
    @ManyToOne
    @JoinColumn(name = "role_id")
    private Role role;

    // // feedback
    @OneToMany(mappedBy = "user")
    private List<Ratings> feedbacks;

    // // Ordrer
    @OneToMany(mappedBy = "user")
    private List<Order> list_order;

    @OneToOne(mappedBy = "user")
    private Cart cart;

    @Override
    public String toString() {
        return "User [id=" + id + ", full_name=" + full_name + ", user_name=" + user_name + ", email=" + email
                + ", address=" + address + ", password=" + password + ", phone_number=" + phone_number + ", avatar="
                + avatar + ", deleted=" + deleted + "]";
    }

}
