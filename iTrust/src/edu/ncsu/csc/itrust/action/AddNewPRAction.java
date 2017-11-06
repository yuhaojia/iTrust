package edu.ncsu.csc.itrust.action;

import edu.ncsu.csc.itrust.validate.ValidationFormat;

public class AddNewPRAction {
    private static boolean validEmail = true;
    private static boolean reqFields = true;
    private static boolean pwMatch = true;
    private static boolean isNewPR = false;

    public static boolean validateEmail(String email){
        return ValidationFormat.EMAIL.getRegex().matcher(email).matches();
    }

    public static boolean getEmailValidation(){
        return validEmail;
    }

    public static void setEmailValidation(boolean val){
        validEmail = val;
    }

    public static boolean getReqFields(){
        return reqFields;
    }

    public static void setReqFields(boolean val){
        reqFields = val;
    }

    public static boolean getPwMatch(){
        return pwMatch;
    }

    public static void setPwMatch(boolean val){
        pwMatch = val;
    }

    public static boolean getIsNewPR() { return isNewPR; }

    public static void setIsNewPR(boolean val) { isNewPR = val; }
}
