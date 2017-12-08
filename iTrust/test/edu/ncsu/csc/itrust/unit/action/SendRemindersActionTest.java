package edu.ncsu.csc.itrust.unit.action;

import edu.ncsu.csc.itrust.action.SendRemindersAction;
import edu.ncsu.csc.itrust.beans.ApptBean;
import edu.ncsu.csc.itrust.beans.MessageBean;
import edu.ncsu.csc.itrust.dao.DAOFactory;
import edu.ncsu.csc.itrust.dao.mysql.MessageDAO;
import edu.ncsu.csc.itrust.exception.DBException;
import edu.ncsu.csc.itrust.exception.FormValidationException;
import edu.ncsu.csc.itrust.exception.ITrustException;
import edu.ncsu.csc.itrust.unit.datagenerators.TestDataGenerator;
import edu.ncsu.csc.itrust.unit.testutils.TestDAOFactory;
import junit.framework.TestCase;

import java.sql.SQLException;
import java.util.List;

public class SendRemindersActionTest extends TestCase {

    private SendRemindersAction action;
    private DAOFactory factory;
    private MessageDAO messageDAO;
    private long patientId = 101L;
    private long adminId = 9000000001L;
    TestDataGenerator gen;

    @Override
    protected void setUp() throws Exception {
        gen = new TestDataGenerator();
        gen.clearAllTables();
        gen.standardData();
        gen.patient101();

        this.factory = TestDAOFactory.getTestInstance();
        this.action = new SendRemindersAction(this.factory, this.adminId);
        this.messageDAO = factory.getMessageDAO();
    }

    public void testSendReminders() throws FormValidationException, SQLException, ITrustException {
        action.sendReminders(10000);
        List<MessageBean> mbList = this.messageDAO.getMessagesFor(this.patientId);

        assertEquals(1, mbList.size());
    }
}
