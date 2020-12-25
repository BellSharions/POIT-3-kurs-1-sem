package com.example.dmitry.exceptions;


import com.example.dmitry.entity.model.Error;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler({ InvalidFormsException.class, AuthException.class, RegisterException.class })
    public final ResponseEntity<Error> handleException(Exception error) {
        if (error instanceof InvalidFormsException) {
            return handleInvalidFormsException((InvalidFormsException)error);
        } else if (error instanceof AuthException) {
            return handleAuthException((AuthException)error);
        } else if (error instanceof RegisterException) {
            return handleRegisterException((RegisterException)error);
        }else {
            return handleExceptionInternal(null);
        }
    }

    protected ResponseEntity<Error> handleInvalidFormsException(InvalidFormsException error) {
        return handleExceptionInternal(new Error(error.getMessage()));
    }

    protected ResponseEntity<Error> handleAuthException(AuthException error) {
        return handleExceptionInternal(new Error(error.getMessage()));
    }

    protected ResponseEntity<Error> handleRegisterException(RegisterException error) {
        return handleExceptionInternal(new Error(error.getMessage()));
    }

    protected ResponseEntity<Error> handleExceptionInternal(Error body) {
        return new ResponseEntity<Error>(body, HttpStatus.BAD_REQUEST);
    }
}
