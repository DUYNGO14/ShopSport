package com.duyngostore.shopsport.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.duyngostore.shopsport.domain.Category;
import com.duyngostore.shopsport.reppository.CategoryRepository;
import com.duyngostore.shopsport.service.CategoryService;

@Service
public class CategoryServiceImpl implements CategoryService {

    private final CategoryRepository categoryRepository;

    public CategoryServiceImpl(CategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    @Override
    public List<Category> getAll() {
        List<Category> categories = this.categoryRepository.findAll();
        return categories;
    }

    @Override
    public Category handelSaveCategory(Category category) {
        return this.categoryRepository.save(category);
    }

    @Override
    public void deleteCategory(Category category) {
        Category currentCategory = this.findCategoryById(category.getId());
        currentCategory.setDeleted(true);
        this.categoryRepository.save(currentCategory);
    }

    @Override
    public Category findCategoryByName(String name) {
        Optional<Category> cate = this.categoryRepository.findByName(name);
        if (cate.isPresent()) {
            return cate.get();
        }
        return null;
    }

    @Override
    public Category findCategoryById(long id) {
        Optional<Category> cate = this.categoryRepository.findById(id);
        if (cate.isPresent()) {
            return cate.get();
        }
        return null;
    }

    @Override
    public List<Category> getAllByDelete(boolean delete) {
        return this.categoryRepository.findByDeleted(delete);
    }
}
