package com.example.dmitry.entity.model;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
public class Token {
    private String token;

    public Token() { }

    public Token(String token) {
        this.token = token;
    }
}
