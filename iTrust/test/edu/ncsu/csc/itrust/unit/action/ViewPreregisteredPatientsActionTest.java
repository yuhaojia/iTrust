


package edu.ncsu.csc.itrust.unit.action;

import java.util.List;

import edu.ncsu.csc.itrust.action.ViewPreregisteredPatientsAction;
import junit.framework.TestCase;
import edu.ncsu.csc.itrust.action.ViewPatientOfficeVisitHistoryAction;
import edu.ncsu.csc.itrust.beans.PatientVisitBean;
import edu.ncsu.csc.itrust.beans.PersonnelBean;
import edu.ncsu.csc.itrust.beans.PatientBean;

import edu.ncsu.csc.itrust.dao.DAOFactory;
import edu.ncsu.csc.itrust.unit.datagenerators.TestDataGenerator;
import edu.ncsu.csc.itrust.unit.testutils.TestDAOFactory;

/**
 * ViewPatientOfficeVisitHistoryActionTest
 */
public class ViewPreregisteredPatientsActionTest extends TestCase{

    private DAOFactory factory = TestDAOFactory.getTestInstance();
    private TestDataGenerator gen = new TestDataGenerator();
    private ViewPreregisteredPatientsAction action;

    @Override
    protected void setUp() throws Exception{
        action = new ViewPreregisteredPatientsAction(factory, 9000000000L);
        gen.clearAllTables();
        gen.standardData();
    }

    /**
     * testGetPersonnel
     * @throws Exception
     */
    public void testGetPreregisteredPatients() throws Exception {
        List<PatientBean> patients = action.getPreregisteredPatients();
        assertEquals(3,patients.size());
    }

}










