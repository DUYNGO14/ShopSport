package com.duyngostore.shopsport.controller.admin;

import java.time.Instant;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.duyngostore.shopsport.domain.Product;
import com.duyngostore.shopsport.service.ProductService;
import com.duyngostore.shopsport.service.UploadService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class ProductController {
    private final ProductService productService;
    private final UploadService uploadService;

    public ProductController(ProductService productService, UploadService uploadService) {
        this.productService = productService;
        this.uploadService = uploadService;
    }

    @GetMapping("/admin/product")
    public String getCrProductPage(Model model, @RequestParam("page") Optional<String> pageOptional) {
        int page = 1;
        try {
            if (pageOptional.isPresent()) {
                page = Integer.parseInt(pageOptional.get());
            } else {

            }
        } catch (Exception e) {
            // TODO: handle exception
        }
        Pageable pageable = PageRequest.of(page - 1, 5);
        Page<Product> prs = this.productService.getAllProduct(pageable);
        List<Product> lstProduct = prs.getContent();
        model.addAttribute("lstProduct", lstProduct);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", prs.getTotalPages());
        return "admin/product/show";
    }

    @GetMapping("/admin/product/create")
    public String getCreatePage(Model model) {
        model.addAttribute("newProduct", new Product());
        model.addAttribute("lstCategory", this.productService.getAllCategory());
        return "admin/product/create";
    }

    @PostMapping("/admin/product/create")
    public String postMethodName(@ModelAttribute("newProduct") @Valid Product newProduct,
            BindingResult newUserBindingResult, @RequestParam("avatarProduct") MultipartFile file,
            @RequestParam("listImageProduct") MultipartFile[] listFiles, Model model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        // TODO: process POST request
        if (newUserBindingResult.hasErrors()) {
            model.addAttribute("lstCategory", this.productService.getAllCategory());
            return "admin/product/create";
        }
        String avatar = this.uploadService.handleSaveUploadFile(file, "product");
        String listImage = this.uploadService.handleSaveUploadListFile(listFiles, "product");
        newProduct.setCategory(this.productService.getCategoryByName(newProduct.getCategory().getName()));
        newProduct.setImage(avatar);
        newProduct.setListImage(listImage);
        newProduct.setCreatedBy((String) session.getAttribute("username"));
        newProduct.setCreatedAt(Instant.now());
        this.productService.handleSaveProduct(newProduct);
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/{id}")
    public String getMethodName(Model model, @PathVariable long id) {
        Product product = this.productService.getProductById(id).get();
        String lstimage[] = product.getListImage().split(";");
        model.addAttribute("listimage", lstimage);
        model.addAttribute("product", product);
        model.addAttribute("id", id);

        return "admin/product/view";
    }

    @GetMapping("/admin/product/update/{id}") // GET
    public String getUpdateProductPage(Model model, @PathVariable long id) {
        Product currentProduct = this.productService.getProductById(id).get();
        model.addAttribute("newProduct", currentProduct);
        model.addAttribute("lstCategory", this.productService.getAllCategory());
        model.addAttribute("id", id);
        return "admin/product/update";
    }

    @PostMapping("/admin/product/update")
    public String postUpdateUser(Model model, @ModelAttribute("newProduct") @Valid Product product,
            BindingResult newProductBindingResult,
            @RequestParam("avatarProduct") MultipartFile file,
            @RequestParam("listImageProduct") MultipartFile[] files,
            HttpServletRequest request) {
        HttpSession session = request.getSession();
        Product currentProduct = this.productService.getProductById(product.getId()).get();
        if (currentProduct != null) {
            if (!file.isEmpty()) {
                String img = this.uploadService.handleSaveUploadFile(file, "product");
                currentProduct.setImage(img);
            }
            String listImageProduct = this.uploadService.handleSaveUploadListFile(files, "product");
            currentProduct.setListImage(listImageProduct);
            currentProduct.setName(product.getName());
            currentProduct.setPrice(product.getPrice());
            currentProduct.setDescription(product.getDescription());
            currentProduct.setCategory(this.productService.getCategoryByName(product.getCategory().getName()));
            currentProduct.setDiscount(product.getDiscount());
            currentProduct.setMaterial(product.getMaterial());
            currentProduct.setQuantity(product.getQuantity());
            currentProduct.setUpdatedBy((String) session.getAttribute("username"));
            currentProduct.setUpdatedAt(Instant.now());
            // bug here
            this.productService.handleSaveProduct(currentProduct);
        }
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/delete/{id}")
    public String getDeleteProductPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        model.addAttribute("newProduct", new Product());
        return "admin/product/delete";
    }

    @PostMapping("/admin/product/delete")
    public String postDeleteProduct(Model model, @ModelAttribute("newProduct") Product product) {
        // TODO: process POST request
        this.productService.deleteProductById(product.getId());
        return "redirect:/admin/product";
    }

}
