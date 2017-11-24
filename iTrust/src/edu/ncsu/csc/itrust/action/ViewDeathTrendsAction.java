package edu.ncsu.csc.itrust.action;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import edu.ncsu.csc.itrust.beans.DeathTrendsBean;
import edu.ncsu.csc.itrust.beans.DiagnosisBean;
import edu.ncsu.csc.itrust.beans.DiagnosisStatisticsBean;
import edu.ncsu.csc.itrust.dao.DAOFactory;
import edu.ncsu.csc.itrust.dao.mysql.DiagnosesDAO;
import edu.ncsu.csc.itrust.dao.mysql.ICDCodesDAO;
import edu.ncsu.csc.itrust.dao.mysql.PatientDAO;
import edu.ncsu.csc.itrust.exception.DBException;
import edu.ncsu.csc.itrust.exception.FormValidationException;
import edu.ncsu.csc.itrust.exception.ITrustException;

/**
 * Used for the View Diagnosis Statistics page. Can return a list of all Diagnoses
 * and get diagnosis statistics for a specified Zip code, Diagnosis code, and date range.
 */
public class ViewDeathTrendsAction {
    /** Database access methods for patients information */
    private PatientDAO patientDAO;

    /**
     * Constructor for the action. Initializes DAO fields
     * @param factory The session's factory for DAOs
     */
    public ViewDeathTrendsAction(DAOFactory factory) {
        this.patientDAO = factory.getPatientDAO();
    }

    /**
     * Returns a list of diagnoses for currently dead patients who previously had had an
     * office visit with a given HCP during a given year range sorted by the number of
     * deaths per diagnosis.
     *
     * @param hcpid The ID for the given HCP
     * @param startYear The beginning year for the year range
     * @param endYear The ending year for the year range
     * @throws FormValidationException
     * @throws ITrustException
     */
    // ^^ Need these throw calls? !!!
    public DeathTrendsBean getDeathTrends(long hcpid, String startYear, String endYear, String gender) throws FormValidationException, ITrustException { // <-- Need these throw calls? !!!
        // Error check: years passed are null
        if (startYear == null || endYear == null)
            return null;

        // Initialize variables
        DeathTrendsBean dtBean = null;

        dtBean = patientDAO.getDeathTrends(hcpid, startYear, endYear, gender); // Temporary placement of function. Should be in try call after validation code is implemented. !!!
        // try {
        //     // Validate years here? !!!
        //     Date lower = new SimpleDateFormat("MM/dd/yyyy").parse(lowerDate);
        //     Date upper = new SimpleDateFormat("MM/dd/yyyy").parse(upperDate);

        //     if (lower.after(upper))
        //         throw new FormValidationException("Start date must be before end date!");

        //     // Get death trends from database
        //     dtBean = patientDAO.getDeathTrends(hcpid, startYear, endYear);

        // } catch (ParseException e) {
        //     throw new FormValidationException("!!! VALIDATION ERROR MESSAGE !!!");
        // }


        return dtBean;
    }

}
