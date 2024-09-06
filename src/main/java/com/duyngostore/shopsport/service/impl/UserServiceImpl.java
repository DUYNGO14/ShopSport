package com.duyngostore.shopsport.service.impl;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.duyngostore.shopsport.domain.Role;
import com.duyngostore.shopsport.domain.User;
import com.duyngostore.shopsport.reppository.RoleRepository;
import com.duyngostore.shopsport.reppository.UserRepository;
import com.duyngostore.shopsport.service.UserService;

@Service
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;

    public UserServiceImpl(UserRepository userRepository, RoleRepository roleRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
    }

    @Override
    public User handleSaveUser(User user) {
        User newUser = this.userRepository.save(user);
        System.out.println(newUser);
        return newUser;
    }

    @Override
    public List<User> getFindAllUser() {
        return this.userRepository.findAll();
    }

    @Override
    public Role getRoleByName(String name) {
        return this.roleRepository.findByName(name);
    }

    @Override
    public User getUserById(long id) {
        return this.userRepository.findById(id);
    }

    @Override
    public User getUserByEmail(String email) {
        return this.userRepository.findByEmail(email);
    }

    @Override
    public void deleteById(long id) {
        this.userRepository.deleteById(id);
    }

    @Override
    public List<Role> getFindAllRole() {
        return this.roleRepository.findAll();
    }

    @Override
    public boolean checkEmailExist(String email) {
        return this.userRepository.existsByEmail(email);
    }

    @Override
    public boolean checkUserNameExist(String username) {
        return this.userRepository.findExistByUserName(username);
    }

    @Override
    public User getfindByUserName(String username) {
        return this.userRepository.findByUserName(username);
    }

    @Override
    public long countUser() {
        return this.userRepository.count();
    }

    @Override
    public Page<User> getAllUsers(Pageable pageable) {
        return this.userRepository.findAll(pageable);
    }
}
