package com.duyngostore.shopsport.domain.dto;

import java.util.List;
import java.util.Optional;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductCriterioDTO {
    private Optional<String> page;
    private Optional<List<String>> category;
    private Optional<List<String>> factory;
    private Optional<String> sort;
    private Optional<String> keySearch;
}
