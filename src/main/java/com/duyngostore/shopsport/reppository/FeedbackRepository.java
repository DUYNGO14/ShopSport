package com.duyngostore.shopsport.reppository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.duyngostore.shopsport.domain.Feedback;
import com.duyngostore.shopsport.domain.Product;

@Repository
public interface FeedbackRepository extends JpaRepository<Feedback, Long> {
    // @Query("select p from Feedback p where order_id = ?1 and product_id =?2")
    // public Optional<Feedback> findByFeedbackByProductIdAndOrderId(long idOrder,
    // long idProduct);

    Optional<List<Feedback>> findByProduct(Product product);
}
