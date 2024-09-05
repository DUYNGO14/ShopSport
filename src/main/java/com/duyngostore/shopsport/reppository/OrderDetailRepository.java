package com.duyngostore.shopsport.reppository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.duyngostore.shopsport.domain.OrderDetail;

public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {

}
