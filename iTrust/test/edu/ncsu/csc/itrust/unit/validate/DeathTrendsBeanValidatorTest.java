package edu.ncsu.csc.itrust.unit.validate;

import edu.ncsu.csc.itrust.beans.DeathTrendsBean;
import edu.ncsu.csc.itrust.exception.FormValidationException;
import edu.ncsu.csc.itrust.validate.DeathTrendsBeanValidator;
import junit.framework.TestCase;

public class DeathTrendsBeanValidatorTest extends TestCase {
    DeathTrendsBeanValidator validator = new DeathTrendsBeanValidator();
    DeathTrendsBean bean = null;

    @Override
    public void setUp(){
        bean = new DeathTrendsBean(1,"1999","2002",null,null,null);
    }

    public void testTrendsBeansValidator() throws Exception{
        try{
            validator.validate(bean);
        }catch(FormValidationException e){
            fail();
        }

        bean.setEndYear("");
        bean.setStartYear("20");
        try{
            validator.validate(bean);
        }catch(FormValidationException e){
            assertEquals("This form has not been validated correctly. The following field are not properly filled in: [Start Year: Must be 4 digits, End Year: Must be 4 digits]",e.getMessage());
        }

        bean.setEndYear("1996");
        bean.setStartYear("1997");
        try{
            validator.validate(bean);
        }catch(FormValidationException e){
            assertEquals("This form has not been validated correctly. The following field are not properly filled in: [End year cannot be before start year!]",e.getMessage());
        }


        bean.setEndYear("3000");
        bean.setStartYear("2999");
        try{
            validator.validate(bean);
        }catch(FormValidationException e){
            assertEquals("This form has not been validated correctly. The following field are not properly filled in: [Start year cannot be in the future!, End year cannot be in the future!]",e.getMessage());
        }
    }
}
