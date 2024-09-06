package com.duyngostore.shopsport.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.duyngostore.shopsport.domain.Order;

import com.duyngostore.shopsport.domain.User;

public interface OrderService {

    public List<Order> getAllOrder();

    public Page<Order> getAllOrder(Pageable pageable);

    public Optional<Order> findOrderById(long id);

    public void deleteOrderById(long id);

    public void updateOrder(Order order);

    public long countOrder();

    public List<Order> findOrderByUser(User user);
}
