package com.duyngostore.shopsport.reppository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.duyngostore.shopsport.domain.Order;
import com.duyngostore.shopsport.domain.User;

public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findByUser(User user);
}
