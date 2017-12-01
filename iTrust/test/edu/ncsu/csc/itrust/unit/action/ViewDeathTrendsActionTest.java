package edu.ncsu.csc.itrust.unit.action;

import edu.ncsu.csc.itrust.action.ViewDeathTrendsAction;
import edu.ncsu.csc.itrust.beans.DeathTrendsBean;
import edu.ncsu.csc.itrust.dao.DAOFactory;
import edu.ncsu.csc.itrust.exception.ITrustException;
import edu.ncsu.csc.itrust.unit.datagenerators.TestDataGenerator;
import edu.ncsu.csc.itrust.unit.testutils.TestDAOFactory;
import junit.framework.TestCase;

public class ViewDeathTrendsActionTest extends TestCase {

    private ViewDeathTrendsAction action;
    private DeathTrendsBean bean;
    private DAOFactory factory;
    private long mId = 2L;
    private long hcpId = 9000000000L;

    @Override
    protected void setUp() throws Exception {
        super.setUp();

        TestDataGenerator gen = new TestDataGenerator();
        gen.clearAllTables();
        gen.standardData();

        this.factory = TestDAOFactory.getTestInstance();

    }

    public void testGetPatientName() throws ITrustException {
        this.action = new ViewDeathTrendsAction(this.factory);
        try {
            bean = action.getDeathTrends(2L, "1910", "1950", "both");
        }catch(Exception e){
            e.getMessage();
        }
        assertEquals("1910",bean.getStartYear());
        assertEquals("1950",bean.getEndYear());

    }

}
