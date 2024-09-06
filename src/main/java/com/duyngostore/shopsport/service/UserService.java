package com.duyngostore.shopsport.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import com.duyngostore.shopsport.domain.Role;
import com.duyngostore.shopsport.domain.User;

public interface UserService {
    public User handleSaveUser(User user);

    public List<User> getFindAllUser();

    public Role getRoleByName(String name);

    public User getUserById(long id);

    public User getUserByEmail(String email);

    public void deleteById(long id);

    public List<Role> getFindAllRole();

    public boolean checkEmailExist(String email);

    public boolean checkUserNameExist(String username);

    public User getfindByUserName(String username);

    public long countUser();

    public Page<User> getAllUsers(Pageable pageable);
}
