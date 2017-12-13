package edu.ncsu.csc.itrust.validate;

import edu.ncsu.csc.itrust.beans.DeathTrendsBean;
import edu.ncsu.csc.itrust.exception.ErrorList;
import edu.ncsu.csc.itrust.exception.FormValidationException;
import java.util.Date;

/**
 * Validator used to validate viewing dead trend
 */
public class DeathTrendsBeanValidator extends BeanValidator<DeathTrendsBean>{
    /**
     * Performs the act of validating the bean in question, which varies depending on the
     * type of validator.  If the validation does not succeed, a {@link FormValidationException} is thrown.
     * @param bean
     * @throws FormValidationException
     */

    @Override
    public void validate(DeathTrendsBean bean) throws FormValidationException {
        ErrorList errorList = new ErrorList();


        errorList.addIfNotNull(checkFormat("Start Year", bean.getStartYear(), ValidationFormat.YEAR, false));
        errorList.addIfNotNull(checkFormat("End Year", bean.getEndYear(), ValidationFormat.YEAR, false));

        try {
            if (Integer.parseInt(bean.getStartYear()) > Integer.parseInt(bean.getEndYear()))
                errorList.addIfNotNull("End year cannot be before start year!");
        }catch(Exception e){}
        try{
            if (Integer.parseInt(bean.getStartYear()) > new Date().getYear() + 1900)
                errorList.addIfNotNull("Start year cannot be in the future!");
        }catch(Exception e){}
        try{
            if (Integer.parseInt(bean.getEndYear()) > new Date().getYear() + 1900)
                errorList.addIfNotNull("End year cannot be in the future!");
        }catch(Exception e){}
        if (errorList.hasErrors())
            throw new FormValidationException(errorList);


    }
}
