package com.duyngostore.shopsport.domain;

import java.time.Instant;
import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;

@lombok.Getter
@lombok.Setter
@Entity
@Table(name = "category")
public class Category {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    @NotNull(message = "name không được để trống")
    private String name;
    @NotNull(message = "description không được để trống")
    private String description;
    private boolean deleted;
    Instant createdAt;
    Instant updatedAt;
    String createdBy;
    String updatedBy;
    @OneToMany(mappedBy = "category")
    private List<Product> products;

}
