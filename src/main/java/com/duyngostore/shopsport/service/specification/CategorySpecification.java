package com.duyngostore.shopsport.service.specification;

import java.util.List;

import org.springframework.data.jpa.domain.Specification;

import com.duyngostore.shopsport.domain.Category;
import com.duyngostore.shopsport.domain.Category_;

public class CategorySpecification {
    public static Specification<Category> findCategoryByName(List<String> category) {
        return (root, query, criterBuilder) -> criterBuilder.in(root.get(Category_.NAME)).value(category);
    }
}
