package com.duyngostore.shopsport.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.duyngostore.shopsport.domain.Role;
import com.duyngostore.shopsport.domain.User;
import com.duyngostore.shopsport.reppository.RoleRepository;
import com.duyngostore.shopsport.reppository.UserRepository;

@Service
public class UserService {
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;

    public UserService(UserRepository userRepository, RoleRepository roleRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
    }

    public User handleSaveUser(User user) {
        User newUser = this.userRepository.save(user);
        System.out.println(newUser);
        return newUser;
    }

    public List<User> getFindAllUser() {
        return this.userRepository.findAll();
    }

    public Role getRoleByName(String name) {
        return this.roleRepository.findByName(name);
    }

    public User getUserById(long id) {
        return this.userRepository.findById(id);
    }

    public User getUserByEmail(String email) {
        return this.userRepository.findByEmail(email);
    }

    public void deleteById(long id) {
        this.userRepository.deleteById(id);
    }

    public List<Role> getFindAllRole() {
        return this.roleRepository.findAll();
    }

    public boolean checkEmailExist(String email) {
        return this.userRepository.existsByEmail(email);
    }

    public boolean checkUserNameExist(String username) {
        return this.userRepository.findExistByUserName(username);
    }

    public User getfindByUserName(String username) {
        return this.userRepository.findByUserName(username);
    }

    public long countUser() {
        return this.userRepository.count();
    }

    public Page<User> getAllUsers(Pageable pageable) {
        return this.userRepository.findAll(pageable);
    }
}
