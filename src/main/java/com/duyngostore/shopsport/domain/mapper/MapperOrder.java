package com.duyngostore.shopsport.domain.mapper;

import org.springframework.stereotype.Service;

import com.duyngostore.shopsport.domain.Order;
import com.duyngostore.shopsport.domain.dto.OrderDTO;
import com.duyngostore.shopsport.service.ProductService;

@Service
public class MapperOrder {
    private final ProductService productService;

    public MapperOrder(ProductService productService) {
        this.productService = productService;
    }

    public Order orderDTOtoOrder(OrderDTO orderDTO) {
        Order order = new Order();
        order.setFull_name(orderDTO.getReceive_FullName());
        String address = orderDTO.getPhuongXa() + "/" + orderDTO.getQuanHuyen() + "/" + orderDTO.getTinhThanh();
        order.setAddress(orderDTO.getReceive_Address());
        order.setPhone_number(orderDTO.getReceive_PhoneNumber());
        return order;
    }
}
