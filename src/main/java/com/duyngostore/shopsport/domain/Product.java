package com.duyngostore.shopsport.domain;

import java.time.Instant;
import java.util.List;

import com.duyngostore.shopsport.domain.constant.FactoryProductEnum;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;

@lombok.Getter
@lombok.Setter
@Entity
@Table(name = "product")
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    @NotNull
    @NotEmpty(message = "Tên sản phẩm không được để trống")
    private String name;
    @NotBlank(message = "Thông tin sản phẩm không được để trống")
    @Column(columnDefinition = "MEDIUMTEXT")
    private String description;
    private String image;// ảnh sản phẩm chính
    @NotNull
    @Min(value = 1, message = "Số lượng cần lớn hơn hoặc bằng 1")
    private long quantity;// số lượng sản phẩm
    @NotNull
    @DecimalMin(value = "0", inclusive = false, message = "Price phải lớn hơn 0")
    private double price;
    private long discount;
    private long deleted;
    private String listImage;// ảnh mô tả sản phẩm
    @NotNull
    @NotEmpty(message = "Chất liệu sản phẩm không được để trống")
    private String material;
    @Enumerated(EnumType.STRING)
    private FactoryProductEnum factory;
    Instant createdAt;
    Instant updatedAt;
    String createdBy;
    String updatedBy;
    // mlh với loại sản phẩm
    @ManyToOne
    @JoinColumn(name = "category_id")
    private Category category;
    // mlh với danh sách ảnh sản phẩm
    @OneToMany(mappedBy = "product")
    private List<Size> sizes;
    // feedback
    @OneToMany(mappedBy = "product")
    private List<Ratings> list_feedback;

    @OneToMany(mappedBy = "product")
    private List<OrderDetail> list_orderdetail;

    @OneToMany(mappedBy = "product")
    private List<CartDetail> lstCartDetail;
}
