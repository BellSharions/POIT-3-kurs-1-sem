package com.example.dmitry.entity;

import javax.validation.Valid;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import lombok.Data;
import org.hibernate.annotations.GenericGenerator;
import javax.persistence.*;
import javax.validation.constraints.Future;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.sql.Date;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "Events")
public class Events {

    @Id
    @GeneratedValue(generator = "increment")
    @GenericGenerator(name = "increment", strategy = "increment")
    @Column(name = "id", length = 6, nullable = false)
    private long id;

    @NotBlank
    @Size(min=5, max=50)
    @Column(name = "name")
    private String name;

    @NotBlank
    @Size(min=10, max=200)
    @Column(name = "description")
    private String description;

    @NotBlank(message = "Empty region")
    @Size(min=5, max=20)
    @Column(name = "region")
    private String region;

    @NotNull
    @Column(name = "date")
    private Date date;

    @ManyToMany
    @JoinTable(
            name = "eventsathletes",
            joinColumns = @JoinColumn(name = "idevents"),
            inverseJoinColumns = @JoinColumn(name = "idathletes")
    )
    Set<Athletes> athletesSet;

    @JsonManagedReference
    @OneToMany(mappedBy="event", cascade = CascadeType.ALL)
    private Set<Reviews> review;

    public Events() { }

    public Events(long id, String name, String description, String region, Date date, Set<Athletes> athletesSet) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.region = region;
        this.date = date;
        this.athletesSet = athletesSet;
    }

    public Events(String name, String description, String region, Date date) {
        this.name = name;
        this.description = description;
        this.region = region;
        this.date = date;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Set<Athletes> getAthletesSet() {
        return athletesSet;
    }

    public void setAthletesSet(Set<Athletes> athletesSet) {
        this.athletesSet = athletesSet;
    }

    public Set<Reviews> getReview() {
        return review;
    }

    public void setReview(Set<Reviews> review) {
        this.review = review;
    }
}
