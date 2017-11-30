package edu.ncsu.csc.itrust.action;

import edu.ncsu.csc.itrust.beans.ApptBean;
import edu.ncsu.csc.itrust.beans.MessageBean;
import edu.ncsu.csc.itrust.dao.DAOFactory;
import edu.ncsu.csc.itrust.dao.mysql.ApptDAO;
import edu.ncsu.csc.itrust.dao.mysql.PersonnelDAO;
import edu.ncsu.csc.itrust.exception.FormValidationException;
import edu.ncsu.csc.itrust.exception.ITrustException;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SendRemindersAction {
    private long loggedInMID;
    private ApptDAO apptDAO;
    private SendMessageAction messageAction;
    private PersonnelDAO personnelDAO;

    /**
     * Sets up defaults
     * @param factory The DAOFactory used to create the DAOs used in this action.
     * @param loggedInMID The MID of the user sending the message.
     */
    public SendRemindersAction(DAOFactory factory, long loggedInMID) {
        this.loggedInMID = loggedInMID;
        this.apptDAO = factory.getApptDAO();
        this.personnelDAO = factory.getPersonnelDAO();
        this.messageAction = new SendMessageAction(factory, loggedInMID);
    }

    /**
     * Send reminders to each patient that has an appointment within n days.
     * @param ndays the number of days away an appointment needs to be to send a patient a reminder.
     */
    public void sendReminders(long ndays) throws SQLException, FormValidationException, ITrustException {
        // Get all appointments between now and n days from now
        List<ApptBean> apptBeans = apptDAO.getApptsWithinNDays(ndays);
        // Convert the appointments into message beans
        List<MessageBean> messageBeans = new ArrayList<>();
        for (ApptBean apptBean: apptBeans) {
            messageBeans.add(makeReminderMessageBean(apptBean, ndays));
        }
        // Send the messages
        messageAction.sendAppointmentReminders(messageBeans);
    }

    /***
     * Create a MessageBean for sending a reminder from an ApptBean
     * @param apptBean The appointment bean to use to create a message bean
     * @param ndays the number of days away an appointment needs to be to send a patient a reminder.
     * @return A MessageBean that can be sent to the patient.
     */
    private MessageBean makeReminderMessageBean(ApptBean apptBean, long ndays) throws ITrustException {
        MessageBean messageBean = new MessageBean();
        messageBean.setTo(apptBean.getPatient());
        // -1 indicates that the message is from the System Reminder
        messageBean.setFrom(-1);
        String subject = "Reminder: upcoming appointment in " + Long.toString(ndays) + " day(s)";
        messageBean.setSubject(subject);
        String[] splitDate = apptBean.getDate().toString().split(" ");
        String doctor = personnelDAO.getName(apptBean.getHcp());
        String body = null;
        if (splitDate.length > 2)
            body = String.format("You have an appointment on %s, %s with Dr. %s", splitDate[0], splitDate[1], doctor);
        messageBean.setBody(body);
        return messageBean;
    }
}
