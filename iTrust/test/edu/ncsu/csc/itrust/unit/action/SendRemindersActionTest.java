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
    private long patientId = 2L;
    private long adminId = 9000000001L;
    TestDataGenerator gen;

    @Override
    protected void setUp() throws Exception {
        gen = new TestDataGenerator();
        gen.clearAllTables();
        gen.standardData();

        this.factory = TestDAOFactory.getTestInstance();
        this.action = new SendRemindersAction(this.factory, this.adminId);
        this.messageDAO = factory.getMessageDAO();
    }

    public void testSendReminders() throws FormValidationException, SQLException, ITrustException {
        action.sendReminders(7);
        List<MessageBean> mbList = this.messageDAO.getMessagesFor(this.patientId);

        assertEquals(4, mbList.size());
        MessageBean mBeanDB0 = mbList.get(0);
        MessageBean mBeanDB1 = mbList.get(1);
        MessageBean mBeanDB2 = mbList.get(2);
        assertEquals("You have an appointment on 09:10:00.0, 2017-12-05 with Dr. Kelly Doctor", mBeanDB0.getBody());
        assertEquals("You have an appointment on 13:30:00.0, 2017-12-05 with Dr. Kelly Doctor", mBeanDB1.getBody());
        assertEquals("You have an appointment on 09:30:00.0, 2017-12-08 with Dr. Gandalf Stormcrow", mBeanDB2.getBody());
    }
}
