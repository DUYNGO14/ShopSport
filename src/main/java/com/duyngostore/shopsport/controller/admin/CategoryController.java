package com.duyngostore.shopsport.controller.admin;

import java.time.Instant;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.duyngostore.shopsport.domain.Category;
import com.duyngostore.shopsport.domain.Product;
import com.duyngostore.shopsport.service.CategoryService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class CategoryController {
    private final CategoryService categoryService;

    public CategoryController(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @GetMapping("/admin/category")
    public String getShowCategory(Model model) {
        List<Category> categories = this.categoryService.getAllByDelete(false);
        model.addAttribute("categories", categories);
        return "admin/category/show";
    }

    @GetMapping("/admin/category/create")
    public String getCreate(Model model) {
        model.addAttribute("newCategory", new Category());
        return "admin/category/create";
    }

    @PostMapping("/admin/category/create")
    public String postMethodName(@ModelAttribute("newCategory") @Valid Category newCategory,
            BindingResult newUserBindingResult, Model model,
            HttpServletRequest request) {
        HttpSession session = request.getSession();
        // TODO: process POST request
        if (newUserBindingResult.hasErrors()) {
            return "admin/category/create";
        }
        newCategory.setDeleted(false);
        newCategory.setCreatedBy((String) session.getAttribute("username"));
        newCategory.setCreatedAt(Instant.now());
        this.categoryService.handelSaveCategory(newCategory);
        return "redirect:/admin/category";
    }

    @GetMapping("/admin/category/update/{id}")
    public String getCreate(Model model, @PathVariable long id) {
        Category category = this.categoryService.findCategoryById(id);
        model.addAttribute("newCategory", category);
        model.addAttribute("id", id);
        return "admin/category/update";
    }

    @PostMapping("/admin/category/update")
    public String update(@ModelAttribute("newCategory") @Valid Category newCategory,
            BindingResult newUserBindingResult, Model model,
            HttpServletRequest request) {
        if (newUserBindingResult.hasErrors()) {
            return "admin/category/update";
        }
        HttpSession session = request.getSession();
        Category currentCategory = this.categoryService.findCategoryById(newCategory.getId());
        currentCategory.setName(newCategory.getName());
        currentCategory.setDescription(newCategory.getDescription());
        currentCategory.setUpdatedBy((String) session.getAttribute("username"));
        currentCategory.setUpdatedAt(Instant.now());
        this.categoryService.handelSaveCategory(currentCategory);
        return "redirect:/admin/category";
    }

    @GetMapping("/admin/category/delete/{id}")
    public String deleted(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        model.addAttribute("newCategory", new Category());
        return "admin/category/delete";
    }

    @PostMapping("/admin/category/delete")
    public String postDelete(Model model, @ModelAttribute("newCategory") Category newCategory) {
        Category p = this.categoryService.findCategoryById(newCategory.getId());
        p.setDeleted(true);
        this.categoryService.handelSaveCategory(p);
        return "redirect:/admin/category";
    }
}
