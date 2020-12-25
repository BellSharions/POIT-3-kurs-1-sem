package com.example.dmitry.repository;

import com.example.dmitry.entity.Events;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EventsRepository extends JpaRepository<Events, Long> {
    @Query("select b from Events b where b.name = :name")
    Events findByName(@Param("name") String name);

    @Modifying
    @Query(value = "insert into EventsAthletes(idEvents, idAthletes) values(:idEvents, :idAthletes)",
            nativeQuery = true)
    void addAthleteInEvent(@Param("idEvents") long idEvents, @Param("idAthletes") long idAthletes);

    @Modifying
    @Query(value = "delete from EventsAthletes where idEvents = :idEvents and idAthletes = :idAthletes",
            nativeQuery = true)
    void deleteAthleteFromEvent(@Param("idEvents") long idEvents, @Param("idAthletes") long idAthletes);

    @Query("select b from Events b where b.id = :id")
    Events getById(@Param("id") long id);
}
