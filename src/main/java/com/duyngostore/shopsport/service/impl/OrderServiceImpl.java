package com.duyngostore.shopsport.service.impl;

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
import com.duyngostore.shopsport.service.OrderService;

@Service
public class OrderServiceImpl implements OrderService {
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public OrderServiceImpl(OrderRepository orderRepository, OrderDetailRepository orderDetailRepository) {
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    @Override
    public List<Order> getAllOrder() {
        return this.orderRepository.findAll();
    }

    @Override
    public Page<Order> getAllOrder(Pageable pageable) {
        return this.orderRepository.findAll(pageable);
    }

    @Override
    public Optional<Order> findOrderById(long id) {
        return this.orderRepository.findById(id);
    }

    @Override
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

    @Override
    public void updateOrder(Order order) {
        Optional<Order> orderOptional = this.findOrderById(order.getId());
        if (orderOptional.isPresent()) {
            Order currentOrder = orderOptional.get();
            currentOrder.setStatus(order.getStatus());
            this.orderRepository.save(currentOrder);
        }
    }

    @Override
    public long countOrder() {
        return this.orderRepository.count();
    }

    @Override
    public List<Order> findOrderByUser(User user) {
        return this.orderRepository.findByUser(user);
    }
}
