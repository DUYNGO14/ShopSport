package com.duyngostore.shopsport.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.duyngostore.shopsport.domain.Cart;
import com.duyngostore.shopsport.domain.CartDetail;
import com.duyngostore.shopsport.domain.Category;
import com.duyngostore.shopsport.domain.Order;
import com.duyngostore.shopsport.domain.OrderDetail;
import com.duyngostore.shopsport.domain.Product;
import com.duyngostore.shopsport.domain.User;
import com.duyngostore.shopsport.domain.constant.StatusOrderEnum;
import com.duyngostore.shopsport.domain.dto.ProductCriterioDTO;
import com.duyngostore.shopsport.reppository.CartDetailRepository;
import com.duyngostore.shopsport.reppository.CartRepository;
import com.duyngostore.shopsport.reppository.CategoryRepository;
import com.duyngostore.shopsport.reppository.OrderDetailRepository;
import com.duyngostore.shopsport.reppository.OrderRepository;
import com.duyngostore.shopsport.reppository.ProductRepository;
import com.duyngostore.shopsport.service.ProductService;
import com.duyngostore.shopsport.service.UserService;
import com.duyngostore.shopsport.service.specification.ProductSpecification;

import jakarta.servlet.http.HttpSession;

@Service
public class ProductServiceImpl implements ProductService {
    private final ProductRepository productRepository;
    private final CategoryRepository categoryRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final UserService userService;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public ProductServiceImpl(ProductRepository productRepository, CategoryRepository categoryRepository,
            CartRepository cartRepository, UserService userService, CartDetailRepository cartDetailRepository,
            OrderRepository orderRepository, OrderDetailRepository orderDetailRepository) {
        this.productRepository = productRepository;
        this.categoryRepository = categoryRepository;
        this.cartRepository = cartRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.userService = userService;
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    @Override
    public Product handleSaveProduct(Product product) {
        return this.productRepository.save(product);
    }

    @Override
    public List<Product> getAllProduct() {
        return this.productRepository.findAll();
    }

    @Override
    public Page<Product> getAllProduct(Pageable pageable) {
        return this.productRepository.findAll(pageable);
    }

    @Override
    public Optional<Product> getProductById(long id) {
        return this.productRepository.findById(id);
    }

    @Override
    public void deleteProductById(long id) {
        this.productRepository.deleteById(id);
    }

    // @Override
    // public Category getCategoryByName(String name) {
    // return this.categoryRepository.findByName(name);
    // }

    // @Override
    // public List<Category> getAllCategory() {
    // return this.categoryRepository.findAll();
    // }

    @Override
    public Cart getCartByUser(User user) {
        return this.cartRepository.findByUser(user);
    }

    @Override
    public void handleAddProductToCart(String email, long productId, HttpSession session, long quantity, String size) {
        User user = this.userService.getUserByEmail(email);
        if (user != null) {
            Cart cart = this.cartRepository.findByUser(user);
            if (cart == null) {
                Cart otherCart = new Cart();
                otherCart.setUser(user);
                otherCart.setSum(0);
                cart = this.cartRepository.save(otherCart);
            }
            Optional<Product> producOptional = this.productRepository.findById(productId);
            if (producOptional.isPresent()) {
                Product realProduct = producOptional.get();
                // CartDetail oldCartDetail =
                // this.cartDetailRepository.findByCartAndProduct(cart, realProduct);
                CartDetail oldCartDetail = this.cartDetailRepository.findByCartAndProductAndSize(cart, realProduct,
                        size);
                if (oldCartDetail == null) {
                    CartDetail cd = new CartDetail();
                    cd.setCart(cart);
                    cd.setPrice(realProduct.getPrice());
                    cd.setProduct(realProduct);
                    cd.setSize(size);
                    cd.setQuantity(quantity);
                    this.cartDetailRepository.save(cd);

                    // update cartsum
                    long s = cart.getSum() + 1;
                    cart.setSum(s);
                    this.cartRepository.save(cart);
                    session.setAttribute("sum", s);
                } else {
                    oldCartDetail.setQuantity(oldCartDetail.getQuantity() + 1);
                    this.cartDetailRepository.save(oldCartDetail);
                }
            }
        }

    }

    @Override
    public void handleDeleteProductToCart(HttpSession session, long cartdetailId) {
        Optional<CartDetail> cartDetailOptional = this.cartDetailRepository.findById(cartdetailId);
        if (cartDetailOptional.isPresent()) {
            CartDetail cartDetail = cartDetailOptional.get();
            Cart curentCart = cartDetail.getCart();
            this.cartDetailRepository.deleteById(cartdetailId);
            if (curentCart.getSum() > 1) {
                long s = curentCart.getSum() - 1;
                curentCart.setSum(s);
                session.setAttribute("sum", s);
                this.cartRepository.save(curentCart);
            } else {
                this.cartRepository.deleteById(curentCart.getId());
                session.setAttribute("sum", 0);
            }
        }
    }

    @Override
    public void handleUpdateCartBeforeCheckout(List<CartDetail> cartDetails) {
        for (CartDetail cartDetail : cartDetails) {
            Optional<CartDetail> cdOptional = this.cartDetailRepository.findById(cartDetail.getId());
            if (cdOptional.isPresent()) {
                CartDetail currentCartDetail = cdOptional.get();
                currentCartDetail.setQuantity(cartDetail.getQuantity());
                this.cartDetailRepository.save(currentCartDetail);
            }

        }
    }

    @Override
    public void handlePlaceOrder(User user, HttpSession session, Order newOrder) {

        // step 1: get cart by user
        Cart cart = this.cartRepository.findByUser(user);
        if (cart != null) {
            List<CartDetail> cartDetails = cart.getLstCartDetail();

            if (cartDetails != null) {

                // create order
                Order order = new Order();
                order.setUser(user);
                order.setFull_name(newOrder.getFull_name());
                order.setAddress(newOrder.getAddress());
                order.setPhone_number(newOrder.getPhone_number());
                order.setDate_order(new java.sql.Date(System.currentTimeMillis()));
                order.setStatus(StatusOrderEnum.PENDING);
                double sum = 0;
                for (CartDetail cd : cartDetails) {
                    sum += cd.getPrice() * cd.getQuantity();
                }
                order.setTotal_money(sum);
                order = this.orderRepository.save(order);

                // create orderDetail

                for (CartDetail cd : cartDetails) {
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setOrder(order);
                    orderDetail.setProduct(cd.getProduct());
                    orderDetail.setPrice(cd.getPrice());
                    orderDetail.setQuantity(cd.getQuantity());
                    orderDetail.setSize(cd.getSize());
                    this.orderDetailRepository.save(orderDetail);
                }

                // step 2: delete cart_detail and cart
                for (CartDetail cd : cartDetails) {
                    this.cartDetailRepository.deleteById(cd.getId());
                }

                this.cartRepository.deleteById(cart.getId());

                // step 3 : update session
                session.setAttribute("sum", 0);
            }
        }

    }

    @Override
    public Page<Product> searchProduct(Pageable pageable) {
        // if(keySearch!=null){
        // return this.productRepository.search(pageable,keySearch);
        // }
        return this.productRepository.findAll(pageable);
    }

    @Override
    public long countProduct() {
        return this.productRepository.count();
    }

    @Override
    // Specification
    public Page<Product> getAllProduct(Pageable pageable, String name) {
        return this.productRepository.findAll(ProductSpecification.nameLike(name), pageable);
    }

    @Override
    public Page<Product> fetchProductsWithSpec(Pageable page, ProductCriterioDTO productCriteriaDTO) {
        Specification<Product> combinedSpec = Specification.where(null);
        if (productCriteriaDTO.getFactory() == null &&
                productCriteriaDTO.getCategory() == null && productCriteriaDTO.getKeySearch() == null) {
            return this.productRepository.findAll(page);
        }
        if (productCriteriaDTO.getFactory() != null && productCriteriaDTO.getFactory().isPresent()) {
            Specification<Product> currentSpec = ProductSpecification
                    .findProductByFactory(productCriteriaDTO.getFactory().get());
            combinedSpec = combinedSpec.and(currentSpec);
        }
        if (productCriteriaDTO.getCategory() != null && productCriteriaDTO.getCategory().isPresent()) {
            Specification<Product> currentSpec = ProductSpecification
                    .findProductByCategory(productCriteriaDTO.getCategory().get());
            combinedSpec = combinedSpec.and(currentSpec);
        }
        if (productCriteriaDTO.getKeySearch() != null && productCriteriaDTO.getKeySearch().isPresent()) {
            Specification<Product> currentSpec = ProductSpecification.nameLike(productCriteriaDTO.getKeySearch().get());
            combinedSpec = combinedSpec.and(currentSpec);
        }
        return this.productRepository.findAll(combinedSpec, page);
    }
}
