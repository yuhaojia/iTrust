package edu.ncsu.csc.itrust.selenium;

import com.meterware.httpunit.HttpUnitOptions;
import edu.ncsu.csc.itrust.enums.TransactionType;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class AppointmentReminderTest extends iTrustSeleniumTest {

	/*
	 * The URL for iTrust, change as needed
	 */
    /**
     * ADDRESS
     */
    public static final String ADDRESS = "http://localhost:8080/iTrust/";
    private WebDriver driver;

    @Override
    protected void setUp() throws Exception {
        super.setUp();
        gen.clearAllTables();
        gen.standardData();
        HttpUnitOptions.setScriptingEnabled(false);
        // turn off htmlunit warnings
        java.util.logging.Logger.getLogger("com.gargoylesoftware.htmlunit").setLevel(java.util.logging.Level.OFF);
        java.util.logging.Logger.getLogger("org.apache.http").setLevel(java.util.logging.Level.OFF);
    }

    public void testSendAppointmentReminders() throws Exception {
        driver = login("9000000001", "pw");
        assertLogged(TransactionType.HOME_VIEW, 9000000001L, 0L, "");
        driver.findElement(By.linkText("Appointment Reminders")).click();
        assertLogged(TransactionType.OUTBOX_VIEW, 9000000001L, 0L, "");
        //assertTrue(driver.getPageSource().contains(""));
        driver.findElement(By.name("n_days")).sendKeys("50");
        driver.findElement(By.cssSelector("input[type=\"submit\"]")).click();
        assertLogged(TransactionType.APPOINTMENT_REMINDERS, 9000000001L, 0, "");
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        Date date = new Date();
        String stamp = dateFormat.format(date);

        assertTrue(driver.getPageSource().contains("Random Person"));
        assertTrue(driver.getPageSource().contains("Reminder: upcoming appointment"));
        assertTrue(driver.getPageSource().contains(stamp));
        assertLogged(TransactionType.OUTBOX_VIEW, 9000000001L, 0L, "");
        driver.findElement(By.linkText("Read")).click();
        assertTrue(driver.getPageSource().contains("Random Person"));
        assertTrue(driver.getPageSource().contains("Reminder: upcoming appointment"));
        assertTrue(driver.getPageSource().contains(stamp));
        assertTrue(driver.getPageSource().contains("You have an appointment on 09:10:00.0, "));
        assertTrue(driver.getPageSource().contains(" with Dr. Kelly Doctor"));

        driver.findElement(By.linkText("Show Fake Emails")).click();
        assertTrue(driver.getPageSource().contains("nobody@gmail.com"));
        assertTrue(driver.getPageSource().contains("noreply@itrust.com"));
        assertTrue(driver.getPageSource().contains("Reminder: upcoming appointment"));
        assertTrue(driver.getPageSource().contains("You have an appointment on 09:10:00.0, "));
        assertTrue(driver.getPageSource().contains(" with Dr. Kelly Doctor"));

        driver = login("2", "pw");
        assertLogged(TransactionType.HOME_VIEW, 2L, 0L, "");
        driver.findElement(By.linkText("Message Inbox")).click();
        assertLogged(TransactionType.INBOX_VIEW, 2L, 0L, "");
        assertTrue(driver.getPageSource().contains("System Reminder"));
        assertTrue(driver.getPageSource().contains("Reminder: upcoming appointment"));
        assertTrue(driver.getPageSource().contains(stamp));

    }
}