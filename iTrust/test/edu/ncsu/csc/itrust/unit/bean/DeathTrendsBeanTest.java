package edu.ncsu.csc.itrust.unit.bean;

import edu.ncsu.csc.itrust.beans.DeathTrendsBean;
import edu.ncsu.csc.itrust.exception.ITrustException;
import junit.framework.TestCase;

import java.util.ArrayList;
import java.util.List;

public class DeathTrendsBeanTest extends TestCase {

    DeathTrendsBean bean;

    public void testDeathTrendsBean() throws ITrustException {
        List<String> testList = new ArrayList<String>();
        testList.add("data1");
        List<Long> testList2 = new ArrayList<Long>();
        testList2.add(2L);
        bean = new DeathTrendsBean(2L,"1910","1950",null,null,null);
        assertEquals(2L,bean.getHCPID());
        assertEquals("1910",bean.getStartYear());
        assertEquals("1950",bean.getEndYear());

        bean.setHCPID(5L);
        assertEquals(5L,bean.getHCPID());

        bean.setStartYear("1900");
        assertEquals("1900",bean.getStartYear());

        bean.setEndYear("1960");
        assertEquals("1960",bean.getEndYear());

        bean.setICDCodes(testList);
        assertEquals("data1",bean.getICDCodes().get(0));

        bean.setICDNames(testList);
        assertEquals("data1",bean.getICDNames().get(0));

        bean.setNumDeaths(testList2);
        assertEquals(2L,bean.getNumDeaths().get(0).longValue());
    }
}
