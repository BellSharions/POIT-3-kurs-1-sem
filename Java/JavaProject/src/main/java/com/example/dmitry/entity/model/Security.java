package com.example.dmitry.entity.model;

import com.example.dmitry.validation.LoginConstraint;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

@Data
public class Security {

    @LoginConstraint
    private String login;

    @NotBlank
    @Size(min=5, max=20)
    private String password;

    public Security() { }

    public Security(String login, String password) {
        this.login = login;
        this.password = password;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
