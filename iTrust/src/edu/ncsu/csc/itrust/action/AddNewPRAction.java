package edu.ncsu.csc.itrust.action;

import edu.ncsu.csc.itrust.validate.ValidationFormat;

public class AddNewPRAction {
    private static boolean validEmail = true;
    public static boolean validateEmail(String email){
        return ValidationFormat.EMAIL.getRegex().matcher(email).matches();
    }

    public static boolean getEmailValidation(){
        return validEmail;
    }

    public static void setEmailValidation(boolean val){
        validEmail = val;
    }

}
