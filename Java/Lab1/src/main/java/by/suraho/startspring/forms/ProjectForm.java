package by.suraho.startspring.forms;

import lombok.Data;

@Data
public class ProjectForm {
    private String name;
    private String description;

    public ProjectForm() { }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public ProjectForm(String name, String description) {
        this.name = name;
        this.description = description;
    }
}
