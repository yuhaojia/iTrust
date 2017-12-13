package edu.ncsu.csc.itrust.validate;

import edu.ncsu.csc.itrust.beans.forms.EditMessageFilterForm;
import edu.ncsu.csc.itrust.exception.ErrorList;
import edu.ncsu.csc.itrust.exception.FormValidationException;

import java.util.Date;
/**
 * Validator used to validate adding a Message Filter
 *
 *
 */
 public class EditMessageFilterValidator extends BeanValidator<EditMessageFilterForm>{
    /**
     * Performs the act of validating the bean in question, which varies depending on the
     * type of validator.  If the validation does not succeed, a {@link FormValidationException} is thrown.
     *
     * @param form A bean of the type to be validated.
     */
    @Override
    public void validate(EditMessageFilterForm form) throws FormValidationException {
        ErrorList errorList = new ErrorList();
        errorList.addIfNotNull(checkFormat("Sender", form.getSender(), ValidationFormat.NAME, true));
        errorList.addIfNotNull(checkFormat("Subject", form.getSubject(), ValidationFormat.MESSAGES_SUBJECT, true));
        errorList.addIfNotNull(checkFormat("Start Date", form.getStartDateStr(), ValidationFormat.DATE, true));
        errorList.addIfNotNull(checkFormat("End Date", form.getEndDateStr(), ValidationFormat.DATE, true));

        try {
            if (!"".equals(form.getStartDateStr())) {
                if( form.getStartDate().after(new Date())){
                    errorList.addIfNotNull("Start date cannot be in the future!");
                }
            }
            if (!"".equals(form.getEndDateStr())) {
                if( form.getEndDate().after(new Date())){
                    errorList.addIfNotNull("End date cannot be in the future!");
                }
            }
            if (!"".equals(form.getStartDateStr()) && !"".equals(form.getEndDateStr())) {
                if (form.getEndDate().before(form.getStartDate()))
                    errorList.addIfNotNull("End date cannot be before start date");
            }

        } catch (NullPointerException e) {
            // ignore this
        }

        if (errorList.hasErrors())
            throw new FormValidationException(errorList);
    }
}
