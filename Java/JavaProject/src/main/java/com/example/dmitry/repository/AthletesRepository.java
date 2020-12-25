package com.example.dmitry.repository;

import com.example.dmitry.entity.Athletes;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface AthletesRepository extends JpaRepository<Athletes, Long> {
    @Query("select b from Athletes b where b.name = :name")
    Athletes findByName(@Param("name") String name);

}
