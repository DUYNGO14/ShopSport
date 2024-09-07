package com.duyngostore.shopsport.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.duyngostore.shopsport.domain.Feedback;

public interface FeedbackService {
    public Feedback save(Feedback feedback);

    public Page<Feedback> getAll(Pageable pageable);

    public Feedback getFeedbackByIdProductAndIdOrder(long idOrder, long idProduct);
}
