package com.duyngostore.shopsport.reppository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.duyngostore.shopsport.domain.Cart;
import com.duyngostore.shopsport.domain.CartDetail;
import com.duyngostore.shopsport.domain.Product;

public interface CartDetailRepository extends JpaRepository<CartDetail, Long> {
    boolean existsByCartAndProduct(Cart cart, Product product);

    CartDetail findByCartAndProduct(Cart cart, Product product);
}
