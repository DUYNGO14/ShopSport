package com.duyngostore.shopsport.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.duyngostore.shopsport.domain.Order;
import com.duyngostore.shopsport.domain.OrderDetail;
import com.duyngostore.shopsport.domain.User;
import com.duyngostore.shopsport.reppository.OrderDetailRepository;
import com.duyngostore.shopsport.reppository.OrderRepository;

@Service
public class OrderService {
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public OrderService(OrderRepository orderRepository, OrderDetailRepository orderDetailRepository) {
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    public List<Order> getAllOrder() {
        return this.orderRepository.findAll();
    }

    public Page<Order> getAllOrder(Pageable pageable) {
        return this.orderRepository.findAll(pageable);
    }

    public Optional<Order> findOrderById(long id) {
        return this.orderRepository.findById(id);
    }

    public void deleteOrderById(long id) {
        Optional<Order> orderOptional = this.findOrderById(id);
        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            List<OrderDetail> orderDetails = order.getListOrder();
            for (OrderDetail orderDetail : orderDetails) {
                this.orderDetailRepository.deleteById(orderDetail.getId());
            }
        }
        this.orderRepository.deleteById(id);
    }

    public void updateOrder(Order order) {
        Optional<Order> orderOptional = this.findOrderById(order.getId());
        if (orderOptional.isPresent()) {
            Order currentOrder = orderOptional.get();
            currentOrder.setStatus(order.getStatus());
            this.orderRepository.save(currentOrder);
        }
    }

    public long countOrder() {
        return this.orderRepository.count();
    }

    public List<Order> findOrderByUser(User user) {
        return this.orderRepository.findByUser(user);
    }
}
