package edu.ncsu.csc.itrust.unit.validate;

import edu.ncsu.csc.itrust.beans.forms.EditMessageFilterForm;
import edu.ncsu.csc.itrust.exception.FormValidationException;
import edu.ncsu.csc.itrust.validate.EditMessageFilterValidator;
import junit.framework.TestCase;

public class EditMessageFilterValidatorTest extends TestCase{
    EditMessageFilterValidator validator = new EditMessageFilterValidator();
    EditMessageFilterForm form = new EditMessageFilterForm();

    @Override
    public void setUp() {
        form.setSender("Andy Programmer");
        form.setSubject("Scratchy Throat");
        form.setIncludeWords("");
        form.setExcludeWords("");
        form.setStartDateStr("");
        form.setEndDateStr("");
    }

    public void testfilterValidator() throws Exception{
        try {
            validator.validate(form);
        }catch(FormValidationException e){
            assertEquals("",e.getMessage());
        }

        form.setStartDateStr("12/25/2020");
        try {
            validator.validate(form);
        }catch(FormValidationException e){
            assertEquals("This form has not been validated correctly. The following field are not properly filled in: [Start date cannot be in the future!]",e.getMessage());
        }

        form.setStartDateStr("");
        form.setEndDateStr("12/26/2020");
        try {
            validator.validate(form);
        }catch(FormValidationException e){
            assertEquals("This form has not been validated correctly. The following field are not properly filled in: [End date cannot be in the future!]",e.getMessage());
        }

        form.setStartDateStr("10/10/2010");
        form.setEndDateStr("10/02/2010");
        try {
            validator.validate(form);
        }catch(FormValidationException e){
            assertEquals("This form has not been validated correctly. The following field are not properly filled in: [End date cannot be before start date]",e.getMessage());
        }

        form.setStartDateStr("");
        form.setEndDateStr("");
        form.setSender("###");
        try{
            validator.validate(form);
        }catch(FormValidationException e){
            assertEquals("This form has not been validated correctly. The following field are not properly filled in: [Sender: Up to 20 Letters, space, ' and -]",e.getMessage());
        }

        form.setSender("");
        form.setStartDateStr("1/1/2010");
        try{
            validator.validate(form);
        }catch(FormValidationException e){
            assertEquals("This form has not been validated correctly. The following field are not properly filled in: [Start Date: MM/DD/YYYY]",e.getMessage());
        }
    }

}
