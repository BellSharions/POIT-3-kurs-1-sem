package com.example.dmitry.service;

import com.example.dmitry.entity.Roles;
import com.example.dmitry.repository.RolesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class RolesService {

    @Autowired
    private RolesRepository rolesRepository;

    public Optional<Roles> GetById(Long id) {
        return rolesRepository.findById(id);
    }

    public List<Roles> getAll() {
        return rolesRepository.findAll();
    }

    public Roles findByName(String name) {
        return rolesRepository.findByName(name);
    }
}
