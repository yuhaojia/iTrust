package edu.ncsu.csc.itrust.unit.action;

import junit.framework.TestCase;
import edu.ncsu.csc.itrust.action.AddNewPRAction;

public class AddNewPRActionTest extends TestCase {

    @Override
    protected void setUp() throws Exception {
        AddNewPRAction.setEmailValidation(true);
        AddNewPRAction.setReqFields(true);
        AddNewPRAction.setPwMatch(true);
        AddNewPRAction.setIsNewPR(false);
    }

    public void testValidateEmail() throws Exception {
        assertTrue(AddNewPRAction.validateEmail("proper@format.com"));
        assertFalse(AddNewPRAction.validateEmail("nonproper@email"));
        assertFalse(AddNewPRAction.validateEmail("another.nonproper"));
        assertFalse(AddNewPRAction.validateEmail("wrongformat"));
    }

    public void testGetEmailValidation() throws Exception {
        assertTrue(AddNewPRAction.getEmailValidation());
    }

    public void testSetEmailValidaion() throws Exception {
        AddNewPRAction.setEmailValidation(false);
        assertFalse(AddNewPRAction.getEmailValidation());
        AddNewPRAction.setEmailValidation(true);
    }

    public void testGetReqFields() throws Exception {
        assertTrue(AddNewPRAction.getReqFields());
    }

    public void testSetReqFields() throws Exception {
        AddNewPRAction.setReqFields(false);
        assertFalse(AddNewPRAction.getReqFields());
        AddNewPRAction.setReqFields(true);
    }

    public void testGetPwMatch() throws Exception {
        assertTrue(AddNewPRAction.getPwMatch());
    }

    public void testSetPwMatch() throws Exception {
        AddNewPRAction.setPwMatch(false);
        assertFalse(AddNewPRAction.getPwMatch());
        AddNewPRAction.setPwMatch(true);
    }

    public void testGetIsNewPR() throws Exception {
        assertFalse(AddNewPRAction.getIsNewPR());
    }

    public void testSetIsNewPR() throws Exception {
        AddNewPRAction.setIsNewPR(false);
        assertFalse(AddNewPRAction.getIsNewPR());
        AddNewPRAction.setIsNewPR(true);
    }
}
