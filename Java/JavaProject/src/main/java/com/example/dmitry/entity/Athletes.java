package com.example.dmitry.entity;

import org.hibernate.annotations.GenericGenerator;
import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "Athletes")
public class Athletes {

    @Id
    @GeneratedValue(generator = "increment")
    @GenericGenerator(name = "increment", strategy = "increment")
    @Column(name = "id", length = 6, nullable = false)
    private long id;

    @NotBlank
    @Size(min=5, max=50)
    @Column(name = "name")
    private String name;

//    @ManyToMany(mappedBy = "athletesSet", cascade = CascadeType.ALL)
//    Set<Events> eventsSet;

    public Athletes() { }

    public Athletes(long id, String name) {
        this.id = id;
        this.name = name;
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

//    public List<Events> getEventsSet() {
//        return eventsSet;
//    }
//
//    public void setEventsSet(Set<Events> eventsSet) {
//        this.eventsSet = eventsSet;
//    }
}
