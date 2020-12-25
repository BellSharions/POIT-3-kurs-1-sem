package com.example.dmitry.repository;

import com.example.dmitry.entity.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface UsersRepository extends JpaRepository<Users, Long> {

    Users findByLogin(String login);

    Users findByActivationCode(String code);
}
