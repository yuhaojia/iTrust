package edu.ncsu.csc.itrust.unit.dao.transaction;

import edu.ncsu.csc.itrust.beans.TransactionBean;
import edu.ncsu.csc.itrust.dao.mysql.TransactionDAO;
import edu.ncsu.csc.itrust.enums.TransactionType;
import edu.ncsu.csc.itrust.unit.datagenerators.TestDataGenerator;
import edu.ncsu.csc.itrust.unit.testutils.TestDAOFactory;
import junit.framework.TestCase;

import java.util.List;

public class FilteredTransactionTest extends TestCase{
    private TransactionDAO tranDAO = TestDAOFactory.getTestInstance().getTransactionDAO();
    private TestDataGenerator gen;

    @Override
    protected void setUp() throws Exception {
        gen = new TestDataGenerator();
        gen.clearAllTables();
        gen.standardData();
    }

    public void testGetFilteredTransactions() throws Exception {
        String [] filter = new String[]{"hcp", "All", "400", "2007/01/01", "2007/12/31"};
        List<TransactionBean> list = tranDAO.getFilteredTransactions(filter);
        assertEquals(2, list.size());
        // that last one inserted should be last because it was backdated
        assertEquals(9000000000L, list.get(0).getLoggedInMID());
        assertEquals(TransactionType.DEMOGRAPHICS_VIEW, list.get(1).getTransactionType());
    }
}
