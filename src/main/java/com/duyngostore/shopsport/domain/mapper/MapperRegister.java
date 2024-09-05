package com.duyngostore.shopsport.domain.mapper;

import org.springframework.stereotype.Service;

import com.duyngostore.shopsport.domain.User;
import com.duyngostore.shopsport.domain.dto.RegisterDTO;
import com.duyngostore.shopsport.service.UserService;

@Service
public class MapperRegister {
    private final UserService userService;

    public MapperRegister(UserService userService) {
        this.userService = userService;
    }

    public User registerDTOtoUser(RegisterDTO registerDTO) {
        User user = new User();
        user.setFull_name(registerDTO.getFull_name());
        user.setEmail(registerDTO.getEmail());
        user.setPassword(registerDTO.getPassword());
        user.setUser_name(registerDTO.getUser_name());
        user.setPhone_number(registerDTO.getPhone_number());
        return user;
    }
}
