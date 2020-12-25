package by.suraho.startspring.controller;

import by.suraho.startspring.forms.ProjectForm;
import by.suraho.startspring.model.Project;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@Controller
public class ProjectController {
    private static List<Project> projects = new ArrayList<Project>();

    private static final org.slf4j.Logger log =
            org.slf4j.LoggerFactory.getLogger(ProjectController.class);

    static {
        projects.add(new Project("name1", "some description1"));
        projects.add(new Project("name2", "some description2"));
    }

    @Value("${welcome.message}")
    private String message;

    @Value("${error.message}")
    private String errorMessage;

    @GetMapping(value = {"/", "index"})
    public ModelAndView index(Model model) {
        ModelAndView modelAndView = new ModelAndView("index");
        model.addAttribute("message", message);
        log.info("/index was called");
        return modelAndView;
    }

    @GetMapping(value = {"/allprojects"})
    public ModelAndView personList(Model model) {
        ModelAndView modelAndView = new ModelAndView("projectlist");
        model.addAttribute("projects", projects);
        log.info("/allprojects was called");
        return modelAndView;
    }

    @GetMapping(value= {"/addproject"})
    public ModelAndView showAddPersonPage(Model model) {
        ModelAndView modelAndView = new ModelAndView("addproject");
        ProjectForm projectForm = new ProjectForm();
        model.addAttribute("projectform", projectForm);
        log.info("/addproject was called");
        return modelAndView;
    }

    @PostMapping(value = {"/addproject"})
    public ModelAndView savePerson(Model model, @ModelAttribute("projectform") ProjectForm projectForm) {
        ModelAndView modelAndView = new ModelAndView("projectlist");
        String name = projectForm.getName();
        String description = projectForm.getDescription();

        boolean flag = false;
        for(Project x : projects) {
            if(name.equals(x.getName())) {
                flag = true;
                break;
            }
        }

        if(name != null && name.length() > 0 &&
            description != null && description.length() > 0 &&
            flag != true) {
            Project newProject = new Project(name, description);
            projects.add(newProject);
            model.addAttribute("projects", projects);
        }
        else {
            model.addAttribute("errorMessage", errorMessage);
            modelAndView.setViewName("addproject");
        }
        log.info("add project");
        return modelAndView;
    }

    @GetMapping(value= {"/deleteproject"})
    public ModelAndView deletePersonPage(Model model) {
        ModelAndView modelAndView = new ModelAndView("deleteproject");
        ProjectForm projectForm = new ProjectForm();
        model.addAttribute("projectform", projectForm);
        log.info("/deleteproject was called");
        return modelAndView;
    }

    @PostMapping(value = {"/deleteproject"})
    public ModelAndView deletePerson(Model model, @ModelAttribute("projectform") ProjectForm projectForm) {
        ModelAndView modelAndView = new ModelAndView("projectlist");
        String name = projectForm.getName();
        boolean flag = false;
        for(Project x : projects) {
            if(name.equals(x.getName())) {
                projects.remove(x);
                flag = true;
                break;
            }
        }
        if(flag) {
            model.addAttribute("projects", projects);
            modelAndView.setViewName("projectlist");
        }
        else {
            model.addAttribute("errorMessage", errorMessage);
            modelAndView.setViewName("deleteproject");
        }
        log.info("delete project");
        return modelAndView;
    }

    @GetMapping(value= {"/changeproject"})
    public ModelAndView ChagePersonPage(Model model) {
        ModelAndView modelAndView = new ModelAndView("changeproject");
        ProjectForm projectForm = new ProjectForm();
        model.addAttribute("projectform", projectForm);
        log.info("/deleteproject was called");
        return modelAndView;
    }

    @PostMapping(value = {"/changeproject"})
    public ModelAndView changePerson(Model model, @ModelAttribute("projectform") ProjectForm projectForm) {
        ModelAndView modelAndView = new ModelAndView("projectlist");
        String name = projectForm.getName();
        String description = projectForm.getDescription();
        boolean flag = false;
        for(Project x : projects) {
            if(name.equals(x.getName())) {
                x.setDescription(description);
                flag = true;
                break;
            }
        }
        if(flag) {
            model.addAttribute("projects", projects);
            modelAndView.setViewName("projectlist");
        }
        else {
            model.addAttribute("errorMessage", errorMessage);
            modelAndView.setViewName("changeproject");
        }
        log.info("change project");
        return modelAndView;
    }
}
