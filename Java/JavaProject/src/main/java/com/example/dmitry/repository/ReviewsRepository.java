package com.example.dmitry.repository;

import com.example.dmitry.entity.Reviews;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReviewsRepository extends JpaRepository<Reviews, Long> {
    @Query(value = "select b from Reviews b where b.event.id = :idE")
    List<Reviews> findReviewsByIdEvent(@Param("idE") long idE);

}
