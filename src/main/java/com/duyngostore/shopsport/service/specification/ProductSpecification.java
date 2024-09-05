package com.duyngostore.shopsport.service.specification;

import java.util.List;

import org.springframework.data.jpa.domain.Specification;

import com.duyngostore.shopsport.domain.Category;
import com.duyngostore.shopsport.domain.Category_;
import com.duyngostore.shopsport.domain.Product;
import com.duyngostore.shopsport.domain.Product_;

import jakarta.persistence.criteria.Join;
import jakarta.persistence.metamodel.SingularAttribute;

public class ProductSpecification {
    public static Specification<Product> nameLike(String name) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.like(root.get(Product_.NAME), "%" + name + "%");
    }

    // public static Specification<Product> findByCategory(String name) {
    // return (root, query, criterBuilder) ->
    // criterBuilder.equal(root.get(Product_.FACTORY), name);
    // }

    // tìm theo hãng sản xuất
    public static Specification<Product> findProductByFactory(List<String> factory) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.in(root.get(Product_.FACTORY)).value(factory);
    }

    // tìm theo loại áo
    public static Specification<Product> findProductByCategory(List<String> category) {
        return (root, query, criteriaBuilder) -> {
            Join<Product, Category> joinProvsCate = root.join("category");
            return criteriaBuilder.in(joinProvsCate.get(Category_.NAME)).value(category);
        };
    }

    // tìm theo khoảng giá
    public static Specification<Product> findByBetweenPrice(double min, double max) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.and(
                // gt >= : le <=
                criteriaBuilder.gt(root.get(Product_.PRICE), min),
                criteriaBuilder.le(root.get(Product_.PRICE), max));
    }

    // tìm theo nhiều khoảng giá cả
    public static Specification<Product> matchMultiplePrice(double min, double max) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.between(root.get(Product_.price), min, max);
    }
}
