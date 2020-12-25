package com.example.dmitry.entity;

import javax.validation.Valid;

import com.example.dmitry.validation.LoginConstraint;
import com.fasterxml.jackson.annotation.JsonBackReference;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "Users")
public class Users {

    @Id
    @GeneratedValue(generator = "increment")
    @GenericGenerator(name = "increment", strategy = "increment")
    @Column(name = "id", length = 6, nullable = false)
    private long id;

    @LoginConstraint
    @Column(name = "login")
    private String login;

    @NotBlank
    @Size(min=5)
    @Column(name = "password")
    private String password;


    @ManyToOne
    @JoinColumn(name="idrole")
    private Roles role;

    @JsonBackReference
    @OneToMany(mappedBy="user")
    private Set<Reviews> review;

    @NotBlank
    @Email
    @Column(name = "email")
    private String email;

    @Column(name = "activationcode")
    private String activationCode;

    public Users() { }

    public Users(String login, String password, String email) {
        this.login = login;
        this.password = password;
        this.email = email;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
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

    public Roles getRole() {
        return role;
    }

    public void setRole(Roles role) {
        this.role = role;
    }

    public Set<Reviews> getReview() {
        return review;
    }

    public void setReview(Set<Reviews> review) {
        this.review = review;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getActivationCode() {
        return activationCode;
    }

    public void setActivationCode(String activationCode) {
        this.activationCode = activationCode;
    }
}
