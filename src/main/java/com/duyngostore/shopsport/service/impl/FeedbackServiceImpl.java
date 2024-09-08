package com.duyngostore.shopsport.service.impl;

import java.util.List;
import java.util.Optional;

import org.eclipse.tags.shaded.org.apache.regexp.recompile;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.duyngostore.shopsport.domain.Feedback;
import com.duyngostore.shopsport.domain.Product;
import com.duyngostore.shopsport.reppository.FeedbackRepository;
import com.duyngostore.shopsport.service.FeedbackService;

@Service
public class FeedbackServiceImpl implements FeedbackService {
    private final FeedbackRepository feedbackRepository;

    public FeedbackServiceImpl(FeedbackRepository feedbackRepository) {
        this.feedbackRepository = feedbackRepository;
    }

    @Override
    public Page<Feedback> getAll(Pageable pageable) {
        return this.feedbackRepository.findAll(pageable);
    }

    @Override
    public Feedback getFeedbackByIdProductAndIdOrder(long idOrder, long idProduct) {
        // Optional<Feedback> feedbackOptional =
        // this.feedbackRepository.findByFeedbackByProductIdAndOrderId(idOrder,
        // idProduct);
        // return feedbackOptional.isPresent() ? feedbackOptional.get() : null;
        return null;
    }

    @Override
    public Feedback save(Feedback feedback) {
        return this.feedbackRepository.save(feedback);
    }

    @Override
    public List<Feedback> getFeedbacksByProduct(Product product) {
        Optional<List<Feedback>> feedbacksOptional = this.feedbackRepository.findByProduct(product);
        if (feedbacksOptional.isPresent()) {
            return feedbacksOptional.get();
        }
        return null;
    }

}
