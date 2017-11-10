package edu.ncsu.csc.itrust.action;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import edu.ncsu.csc.itrust.beans.OfficeVisitBean;
import edu.ncsu.csc.itrust.beans.PatientBean;
import edu.ncsu.csc.itrust.beans.PatientVisitBean;
import edu.ncsu.csc.itrust.beans.PersonnelBean;
import edu.ncsu.csc.itrust.beans.HealthRecord;
import edu.ncsu.csc.itrust.dao.DAOFactory;
import edu.ncsu.csc.itrust.dao.mysql.OfficeVisitDAO;
import edu.ncsu.csc.itrust.dao.mysql.PatientDAO;
import edu.ncsu.csc.itrust.dao.mysql.PersonnelDAO;
import edu.ncsu.csc.itrust.exception.DBException;
import edu.ncsu.csc.itrust.exception.ITrustException;

public class ViewPreregisteredPatientsAction {
    private long loggedInMID;
    private DAOFactory factory;
    private PatientDAO patientDAO;
    private ViewHealthRecordsHistoryAction healthRecords;


    public ViewPreregisteredPatientsAction(DAOFactory factory, long loggedInMID){
        this.factory = factory;
        this.loggedInMID = loggedInMID;
        this.patientDAO = factory.getPatientDAO();
    }


    public List<PatientBean> getPreregisteredPatients() throws DBException {

        try {
            List<PatientBean> plist = patientDAO.getAllPreregisteredPatients();
            for(PatientBean b: plist){
                long id = b.getMID();
                String pid = Long.toString(id);
                healthRecords = new ViewHealthRecordsHistoryAction(factory,pid,loggedInMID);


                List<HealthRecord> records = healthRecords.getAllPatientHealthRecords();
                if(records.size() > 0) {
                    HealthRecord one = records.get(0);
                    b.setHeight(Double.toString(one.getHeight()));
                    b.setWeight(Double.toString(one.getWeight()));
                    b.setSmoker(one.getSmokingStatusDesc());
                }else{
                    b.setHeight("N/A");
                    b.setWeight("0");
                    b.setSmoker("NA");
                }
            }
            return plist;

        }
        catch (ITrustException ie) {
            //TODO
        }

        return null;
    }




}
