package com.duyngostore.shopsport.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.duyngostore.shopsport.domain.Cart;
import com.duyngostore.shopsport.domain.CartDetail;

import com.duyngostore.shopsport.domain.Order;
import com.duyngostore.shopsport.domain.Product;
import com.duyngostore.shopsport.domain.User;
import com.duyngostore.shopsport.domain.dto.ProductCriterioDTO;
import jakarta.servlet.http.HttpSession;

public interface ProductService {

    public Product handleSaveProduct(Product product);

    public List<Product> getAllProduct();

    public Page<Product> getAllProduct(Pageable pageable);

    public Optional<Product> getProductById(long id);

    public void deleteProductById(long id);

    // public Category getCategoryByName(String name);

    // public List<Category> getAllCategory();

    public Cart getCartByUser(User user);

    public void handleAddProductToCart(String email, long productId, HttpSession session, long quantity, String size);

    public void handleDeleteProductToCart(HttpSession session, long cartdetailId);

    public void handleUpdateCartBeforeCheckout(List<CartDetail> cartDetails);

    public void handlePlaceOrder(User user, HttpSession session, Order newOrder);

    public Page<Product> searchProduct(Pageable pageable);

    public long countProduct();

    // Specification
    public Page<Product> getAllProduct(Pageable pageable, String name);

    public Page<Product> fetchProductsWithSpec(Pageable page, ProductCriterioDTO productCriteriaDTO);

}
