package com.example.dmitry.entity.model;

import com.example.dmitry.entity.Athletes;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.sql.Date;
import java.util.Set;

@Data
public class Event {
    private String name;
    private String description;
    private String region;
    private Date date;
    Set<Athletes> athletesSet;

    public Event() { }

    public Event(String name, String description, String region, Date date, Set<Athletes> athletesSet) {
        this.name = name;
        this.description = description;
        this.region = region;
        this.date = date;
        this.athletesSet = athletesSet;
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

    public Set<Athletes> getAthletesSet() {
        return athletesSet;
    }

    public void setAthletesSet(Set<Athletes> athletesSet) {
        this.athletesSet = athletesSet;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}
