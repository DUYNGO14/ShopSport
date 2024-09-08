package com.duyngostore.shopsport.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.duyngostore.shopsport.domain.Feedback;
import com.duyngostore.shopsport.domain.Product;

public interface FeedbackService {
    public Feedback save(Feedback feedback);

    public Page<Feedback> getAll(Pageable pageable);

    public Feedback getFeedbackByIdProductAndIdOrder(long idOrder, long idProduct);

    public List<Feedback> getFeedbacksByProduct(Product product);
}
