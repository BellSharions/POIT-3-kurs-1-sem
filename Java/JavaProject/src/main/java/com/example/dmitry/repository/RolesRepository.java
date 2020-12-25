package com.example.dmitry.repository;

import com.example.dmitry.entity.Roles;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface RolesRepository extends JpaRepository<Roles, Long> {

    @Query(value = "select b from Roles b where b.role = :name")
    Roles findByName(String name);
}
