package edu.ncsu.csc.itrust.unit.dao.transaction;

import edu.ncsu.csc.itrust.beans.TransactionBean;
import edu.ncsu.csc.itrust.dao.mysql.TransactionDAO;
import edu.ncsu.csc.itrust.enums.TransactionType;
import edu.ncsu.csc.itrust.unit.datagenerators.TestDataGenerator;
import edu.ncsu.csc.itrust.unit.testutils.TestDAOFactory;
import junit.framework.TestCase;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.text.DateFormat;
import java.util.List;
import java.util.ArrayList;

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
        String [] filter = new String[]{"hcp", "All", "400", "2007/01/01", "2017/12/31"};
        List<TransactionBean> list = tranDAO.getFilteredTransactions(filter);
        assertEquals(2, list.size());
        // that last one inserted should be last because it was backdated
        assertEquals(9000000000L, list.get(0).getLoggedInMID());
        assertEquals(TransactionType.DEMOGRAPHICS_VIEW, list.get(1).getTransactionType());
    }
    public void testTransactionsChartRoll() throws Exception {

        String [] filter = new String[]{"hcp", "All", "All", "2007/01/01", "2017/11/23"};
        List<TransactionBean> list = tranDAO.getFilteredTransactions(filter);
        assertEquals(37, list.size());

    }

    public void testTransactionsChartSRoll() throws Exception {

        String [] filter = new String[]{"All", "patient", "All", "2007/01/01", "2017/11/23"};
        List<TransactionBean> list = tranDAO.getFilteredTransactions(filter);
        assertEquals(44, list.size());

    }

    public void testTransactionsChartType() throws Exception {
        ArrayList<String> transactionTypeString = new ArrayList<String>();
        ArrayList<Double> numTransactionTypes = new ArrayList<Double>();

        for (TransactionType type : TransactionType.values()) {
            String [] filter = new String[]{"All", "All", ""+type.getCode(), "2007/01/01", "2017/11/23"};
            List<TransactionBean> list = tranDAO.getFilteredTransactions(filter);
            if(list.size()!=0) {
                transactionTypeString.add("" + type.getCode());
                Double bb = new Double((double) list.size());
                numTransactionTypes.add(bb);
            }
        }
        assertEquals(8, numTransactionTypes.size());
        assertEquals(2.0, numTransactionTypes.get(0).doubleValue());
        assertEquals("400", transactionTypeString.get(0));
    }

    public void testTransactionsChartTime() throws Exception {
        String [] filter = new String[]{"All", "All", "All", "2007/06/01", "2007/06/30"};
        List<TransactionBean> list = tranDAO.getFilteredTransactions(filter);
        assertEquals(31, list.size());

    }

}
