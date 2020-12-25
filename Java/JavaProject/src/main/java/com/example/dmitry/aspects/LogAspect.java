package com.example.dmitry.aspects;

import com.example.dmitry.exceptions.InvalidFormsException;
import org.apache.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class LogAspect {

    private static final Logger log = Logger.getLogger(LogAspect.class);

    @Pointcut("execution(* com.example.dmitry.controller.AdminController.addEvent(..))")
    public void addEventMethod() {}

    @Before("addEventMethod()")
    public void beforeAddEvent() {
        log.info("Start of adding event method");
    }

    @After("addEventMethod()")
    public void afterAddEvent() {
        log.info("End of adding event method");
    }

    @Around("addEventMethod()")
    public Object aroundAddEvent(ProceedingJoinPoint jp) throws Throwable {
        long start = System.currentTimeMillis();
        Object res = jp.proceed();
        long end = System.currentTimeMillis();
        log.info("Execution of adding event took " + (end - start) + "msec.");
        return res;
    }

    @AfterThrowing(pointcut = "addEventMethod()", throwing = "e")
    public void afterThrowingAddEvent(Exception e) {
        log.info("Error: " + e.getMessage());
    }

    ////////////////////////////////////////

    @Pointcut("execution(* com.example.dmitry.controller.AdminController.changeEvent(..))")
    public void changeEventMethod() {}

    @Before("changeEventMethod()")
    public void beforeChangeEvent() {
        log.info("Start of changing event method");
    }

    @After("changeEventMethod()")
    public void afterChangeEvent() {
        log.info("End of changing event method");
    }

    @Around("changeEventMethod()")
    public Object aroundChangeEvent(ProceedingJoinPoint jp) throws Throwable {
        long start = System.currentTimeMillis();
        Object res = jp.proceed();
        long end = System.currentTimeMillis();
        log.info("Execution of changing event took " + (end - start) + "msec.");
        return res;
    }

    @AfterThrowing(pointcut = "changeEventMethod()", throwing = "e")
    public void afterThrowingChangeEvent(Exception e) {
        log.info("Error: " + e.getMessage());
    }

    ////////////////////////////////////////

    @Pointcut("execution(* com.example.dmitry.controller.AdminController.deleteEvent(..))")
    public void deleteEventMethod() {}

    @Before("deleteEventMethod()")
    public void beforeDeleteEvent() {
        log.info("Start of deleting event method");
    }

    @After("deleteEventMethod()")
    public void afterDeleteEvent() {
        log.info("End of deleting event method");
    }

    @Around("deleteEventMethod()")
    public Object aroundDeleteEvent(ProceedingJoinPoint jp) throws Throwable {
        long start = System.currentTimeMillis();
        Object res = jp.proceed();
        long end = System.currentTimeMillis();
        log.info("Execution of deleting event took " + (end - start) + "msec.");
        return res;
    }

    @AfterThrowing(pointcut = "deleteEventMethod()", throwing = "e")
    public void afterThrowingDeleteEvent(Exception e) {
        log.info("Error: " + e.getMessage());
    }

    ////////////////////////////////////////

    @Pointcut("execution(* com.example.dmitry.controller.AdminController.deleteReview(..))")
    public void deleteReviewMethod() {}

    @Before("deleteReviewMethod()")
    public void beforeDeleteReview() {
        log.info("Start of deleting review method");
    }

    @After("deleteReviewMethod()")
    public void afterDeleteReview() {
        log.info("End of deleting review method");
    }

    @Around("deleteReviewMethod()")
    public Object aroundDeleteReview(ProceedingJoinPoint jp) throws Throwable {
        long start = System.currentTimeMillis();
        Object res = jp.proceed();
        long end = System.currentTimeMillis();
        log.info("Execution of deleting review took " + (end - start) + "msec.");
        return res;
    }

    @AfterThrowing(pointcut = "deleteReviewMethod()", throwing = "e")
    public void afterThrowingDeleteReview(Exception e) {
        log.info("Error: " + e.getMessage());
    }

    ////////////////////////////////////////

    @Pointcut("execution(* com.example.dmitry.controller.ReviewsController.addReview(..))")
    public void addReviewMethod() {}

    @AfterThrowing(pointcut = "addReviewMethod()", throwing = "e")
    public void afterThrowingAddReview(Exception e) {
        log.info("Error: " + e.getMessage());
    }

    ////////////////////////////////////////

    @Pointcut("execution(* com.example.dmitry.controller.AuthController.auth(..))")
    public void authMethod() {}

    @AfterThrowing(pointcut = "authMethod()", throwing = "e")
    public void afterThrowingAuth(Exception e) {
        log.info("Error: " + e.getMessage());
    }

    @Pointcut("execution(* com.example.dmitry.controller.AuthController.registerUser(..))")
    public void registerMethod() {}

    @AfterThrowing(pointcut = "registerMethod()", throwing = "e")
    public void afterThrowingRegister(Exception e) {
        log.info("Error: " + e.getMessage());
    }
}
