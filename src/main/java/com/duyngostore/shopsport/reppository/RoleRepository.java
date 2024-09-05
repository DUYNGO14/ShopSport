package com.duyngostore.shopsport.reppository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.duyngostore.shopsport.domain.Role;
import java.util.List;

@Repository
public interface RoleRepository extends JpaRepository<Role, Long> {

    List<Role> findAll();

    Role findByName(String name);

}
