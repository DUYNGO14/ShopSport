package com.duyngostore.shopsport.service;

import java.util.List;

import com.duyngostore.shopsport.domain.Category;

public interface CategoryService {
    public List<Category> getAll();

    public List<Category> getAllByDelete(boolean delete);

    public Category handelSaveCategory(Category category);

    public void deleteCategory(Category category);

    public Category findCategoryByName(String name);

    public Category findCategoryById(long id);
}
