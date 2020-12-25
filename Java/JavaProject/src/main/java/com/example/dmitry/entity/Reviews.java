package com.example.dmitry.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.util.List;

@Entity
@Table(name = "Reviews")
public class Reviews {

    @Id
    @GeneratedValue(generator = "increment")
    @GenericGenerator(name = "increment", strategy = "increment")
    @Column(name = "id", length = 6, nullable = false)
    private long id;

//    @NotBlank
//    @Size(min=5, max=200)
    @Column(name = "description")
    private String description;

    @Column(name = "photolink")
    private String photoLink;

    @ManyToOne
    @JoinColumn(name="iduser", nullable=false)
    private Users user;

    @JsonBackReference
    @ManyToOne
    @JoinColumn(name="idevent", nullable=false)
    private Events event;

    public Reviews() { }

    public Reviews(String description, String photoLink) {
        this.description = description;
        this.photoLink = photoLink;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPhotoLink() {
        return photoLink;
    }

    public void setPhotoLink(String photoLink) {
        this.photoLink = photoLink;
    }

    public Users getUser() {
        return user;
    }

    public void setUser(Users user) {
        this.user = user;
    }

    public Events getEvent() {
        return event;
    }

    public void setEvent(Events event) {
        this.event = event;
    }
}
