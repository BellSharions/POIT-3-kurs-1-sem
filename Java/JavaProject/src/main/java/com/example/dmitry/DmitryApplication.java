package com.example.dmitry;

import com.example.dmitry.service.AthletesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.boot.web.servlet.MultipartConfigFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.event.EventListener;

import javax.servlet.MultipartConfigElement;
import java.util.HashSet;
import java.util.Set;


@SpringBootApplication
public class DmitryApplication {


    public static void main(String[] args) {
        SpringApplication.run(DmitryApplication.class, args);
    }

}
