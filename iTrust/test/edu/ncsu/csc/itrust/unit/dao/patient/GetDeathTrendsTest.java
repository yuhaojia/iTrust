package edu.ncsu.csc.itrust.unit.dao.patient;

import edu.ncsu.csc.itrust.beans.DeathTrendsBean;
import edu.ncsu.csc.itrust.dao.DAOFactory;
import edu.ncsu.csc.itrust.dao.mysql.PatientDAO;
import edu.ncsu.csc.itrust.unit.datagenerators.TestDataGenerator;
import edu.ncsu.csc.itrust.unit.testutils.TestDAOFactory;
import edu.ncsu.csc.itrust.validate.DeathTrendsBeanValidator;
import junit.framework.TestCase;

public class GetDeathTrendsTest extends TestCase {
    private PatientDAO patientDAO = TestDAOFactory.getTestInstance().getPatientDAO();
    private TestDataGenerator gen;

    @Override
    protected void setUp() throws Exception {
        gen = new TestDataGenerator();
        gen.clearAllTables();
        gen.standardData();

        patientDAO = TestDAOFactory.getTestInstance().getPatientDAO();
    }

    public void testGetDeathTrends()throws Exception{
        DeathTrendsBean bean = patientDAO.getDeathTrends(9000000000L,"1910","2005","male");
        assertEquals(1,bean.getNumDeaths().get(0).longValue());
        //assertEquals(2,bean.getNumDeaths().get(1).longValue());

    }
}
