package edu.ncsu.csc.itrust.beans.forms;


import static org.junit.Assert.*;
import junit.framework.TestCase;
import edu.ncsu.csc.itrust.beans.forms.EditMessageFilterForm;

public class EditMessageFilterFormTest extends TestCase{
    public void testEditMessageFilterFormSecurity() {

        EditMessageFilterForm e = new EditMessageFilterForm();

        e.setSender("Sender");
        assertEquals("Sender", e.getSender());

        e.setSubject("Subject");
        assertEquals("Subject", e.getSubject());

        e.setIncludeWords("includeWords");
        assertEquals("includeWords", e.getIncludeWords());

        e.setExcludeWords("excludeWords");
        assertEquals("excludeWords", e.getExcludeWords());

        e.setStartDateStr("startDate");
        assertEquals("startDate", e.getStartDateStr());

        e.setEndDateStr("endDate");
        assertEquals("endDate", e.getEndDateStr());

    }


}