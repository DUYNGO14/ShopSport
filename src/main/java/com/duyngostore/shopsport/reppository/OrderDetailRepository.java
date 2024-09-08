package com.duyngostore.shopsport.reppository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import com.duyngostore.shopsport.domain.Order;
import com.duyngostore.shopsport.domain.OrderDetail;

public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {
    List<OrderDetail> findByOrder(Order order);
}
