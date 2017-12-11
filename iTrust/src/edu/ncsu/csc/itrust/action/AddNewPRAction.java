package edu.ncsu.csc.itrust.action;

import edu.ncsu.csc.itrust.validate.ValidationFormat;

public class AddNewPRAction {
    private static boolean validEmail = true;
    private static boolean reqFields = true;
    private static boolean pwMatch = true;
    private static boolean isNewPR = false;

    /**
     * Return if email address is in valid format
     * @param email
     * @return boolean
     */
    public static boolean validateEmail(String email){
        return ValidationFormat.EMAIL.getRegex().matcher(email).matches();
    }

    /**
     * Returns if email is valid
     * @return boolean
     */
    public static boolean getEmailValidation(){
        return validEmail;
    }

    /**
     * Set validEmail to given value
     * @param val
     */
    public static void setEmailValidation(boolean val){
        validEmail = val;
    }

    /**
     * Returns if required fields are filled
     * @return
     */
    public static boolean getReqFields(){
        return reqFields;
    }

    /**
     * Set reqFields to given value
     * @param val
     */
    public static void setReqFields(boolean val){
        reqFields = val;
    }

    /**
     * Return if password matches with password verification
     * @return
     */
    public static boolean getPwMatch(){
        return pwMatch;
    }

    /**
     * Set pwMatch to given value
     * @param val
     */
    public static void setPwMatch(boolean val){
        pwMatch = val;
    }

    /**
     * Return if new preregistered user
     * @return
     */
    public static boolean getIsNewPR() { return isNewPR; }

    /**
     * Set isNewPR to given value
     *
     * @param val
     */
    public static void setIsNewPR(boolean val) { isNewPR = val; }
}
