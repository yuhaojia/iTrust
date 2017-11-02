package edu.ncsu.csc.itrust.beans.forms;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class EditMessageFilterForm {
    private String sender;
    private String subject;
    private String includeWords;
    private String excludeWords;
    private String startDate;
    private String endDate;

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getIncludeWords() {
        return includeWords;
    }

    public void setIncludeWords(String includeWords) {
        this.includeWords = includeWords;
    }

    public String getExcludeWords() {
        return excludeWords;
    }

    public void setExcludeWords(String excludeWords) {
        this.excludeWords = excludeWords;
    }

    public Date getStartDate() {
        try {
            return new SimpleDateFormat("MM/dd/yyyy").parse(startDate);
        } catch (ParseException e) {
            return null;
        }
    }

    public String getStartDateStr() {
        return startDate;
    }

    public void setStartDateStr(String startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        try {
            return new SimpleDateFormat("MM/dd/yyyy").parse(endDate);
        } catch (ParseException e) {
            return null;
        }
    }

    public String getEndDateStr() {
        return endDate;
    }

    public void setEndDateStr(String endDate) {
        this.endDate = endDate;
    }
}
