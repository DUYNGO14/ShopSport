package com.duyngostore.shopsport.reppository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.duyngostore.shopsport.domain.Category;
import java.util.List;
import java.util.Optional;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Long> {
    List<Category> findAll();

    List<Category> findByDeleted(boolean deleted);

    Optional<Category> findByName(String name);

}
