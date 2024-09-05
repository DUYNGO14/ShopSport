package com.duyngostore.shopsport.reppository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.duyngostore.shopsport.domain.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    User save(User eric);

    void deleteById(long id);

    List<User> findOneByEmail(String email);

    List<User> findAll();

    User findById(long id); // null

    boolean existsByEmail(String email);

    // boolean existsByUser_name(String user_name);

    User findByEmail(String email);

    @Query("select count(p) = 1 from User p where user_name = ?1")
    public boolean findExistByUserName(String user_name);

    @Query("select p from User p where user_name = ?1")
    public User findByUserName(String user_name);
}
