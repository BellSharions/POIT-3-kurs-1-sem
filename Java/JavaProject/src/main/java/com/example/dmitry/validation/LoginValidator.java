package com.example.dmitry.validation;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class LoginValidator implements
        ConstraintValidator<LoginConstraint, String> {

    @Override
    public void initialize(LoginConstraint contactNumber) {
    }

    @Override
    public boolean isValid(String contactField, ConstraintValidatorContext cxt) {
        return contactField != null && (contactField.length() >= 5) && (contactField.length() <= 20);
    }
}
