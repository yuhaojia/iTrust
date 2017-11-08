package edu.ncsu.csc.itrust.selenium;


import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.Select;

import com.meterware.httpunit.HttpUnitOptions;

import edu.ncsu.csc.itrust.enums.TransactionType;

public class MessagingUseCaseTest extends iTrustSeleniumTest {

	/*
	 * The URL for iTrust, change as needed
	 */
	/**ADDRESS*/
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
	
	public void testHCPSendMessage() throws Exception {
		driver = login("9000000000", "pw");
		assertLogged(TransactionType.HOME_VIEW, 9000000000L, 0L, "");
		driver.findElement(By.linkText("Message Outbox")).click();
		assertLogged(TransactionType.OUTBOX_VIEW, 9000000000L, 0L, "");
		driver.findElement(By.linkText("Compose a Message")).click();
		driver.findElement(By.name("UID_PATIENTID")).sendKeys("2");
		driver.findElement(By.xpath("//input[@value='2']")).submit();
		driver.findElement(By.name("subject")).clear();
		driver.findElement(By.name("subject")).sendKeys("Visit Request");
		driver.findElement(By.name("messageBody")).clear();
		driver.findElement(By.name("messageBody")).sendKeys("We really need to have a visit.");
		driver.findElement(By.cssSelector("input[type=\"submit\"]")).click();
		assertLogged(TransactionType.MESSAGE_SEND, 9000000000L, 2L, "");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date date = new Date();
		String stamp = dateFormat.format(date);
		assertTrue(driver.getPageSource().contains("My Sent Messages"));
		driver.findElement(By.linkText("Message Outbox")).click();
		assertTrue(driver.getPageSource().contains("Visit Request"));
		assertTrue(driver.getPageSource().contains("Andy Programmer"));
		assertTrue(driver.getPageSource().contains(stamp));
		assertLogged(TransactionType.OUTBOX_VIEW, 9000000000L, 0L, "");
		
		driver = login("2", "pw");
		assertLogged(TransactionType.HOME_VIEW, 2L, 0L, "");
		driver.findElement(By.linkText("Message Inbox")).click();
		assertLogged(TransactionType.INBOX_VIEW, 2L, 0L, "");
		assertTrue(driver.getPageSource().contains("Kelly Doctor"));
		assertTrue(driver.getPageSource().contains("Visit Request"));
		assertTrue(driver.getPageSource().contains(stamp));
	}
	
	public void testPatientSendReply() throws Exception {
		driver = login("2", "pw");
		assertLogged(TransactionType.HOME_VIEW, 2L, 0L, "");
		driver.findElement(By.linkText("Message Inbox")).click();
		assertLogged(TransactionType.INBOX_VIEW, 2L, 0L, "");
		driver.findElement(By.linkText("Read")).click();
		assertLogged(TransactionType.MESSAGE_VIEW, 2L, 9000000000L, "");
		driver.findElement(By.linkText("Reply")).click();
		driver.findElement(By.name("messageBody")).clear();
		driver.findElement(By.name("messageBody")).sendKeys("Which office visit did you update?");
		driver.findElement(By.cssSelector("input[type=\"submit\"]")).click();
		assertLogged(TransactionType.MESSAGE_SEND, 2L, 9000000000L, "");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date date = new Date();
		String stamp = dateFormat.format(date);
		driver.findElement(By.linkText("Message Outbox")).click();
		assertTrue(driver.getPageSource().contains("RE: Office Visit Updated"));
		assertTrue(driver.getPageSource().contains("Kelly Doctor"));
		assertTrue(driver.getPageSource().contains(stamp));
		assertLogged(TransactionType.OUTBOX_VIEW, 2L, 0L, "");
		
		driver = login("9000000000", "pw");
		assertLogged(TransactionType.HOME_VIEW, 9000000000L, 0L, "");
		driver.findElement(By.linkText("Message Inbox")).click();
		assertLogged(TransactionType.INBOX_VIEW, 9000000000L, 0L, "");
		assertTrue(driver.getPageSource().contains("Andy Programmer"));
		assertTrue(driver.getPageSource().contains("RE: Office Visit Updated"));
		assertTrue(driver.getPageSource().contains(stamp));
	}
	
	public void testPatientSendMessageMultiRecipients() throws Exception {
		gen.messagingCcs();
		driver = login("1", "pw");
		assertLogged(TransactionType.HOME_VIEW, 1L, 0L, "");
		driver.findElement(By.linkText("Compose a Message")).click();
		final Select selectBox = new Select(driver.findElement(By.name("dlhcp")));
		selectBox.selectByValue("9000000003");
		//selectComboValue("dlhcp", "9000000003", driver);
		driver.findElement(By.cssSelector("input[type=\"submit\"]")).click();
		driver.findElement(By.name("cc")).clear();
		driver.findElement(By.name("cc")).sendKeys("9000000000");
		driver.findElement(By.name("subject")).clear();
		driver.findElement(By.name("subject")).sendKeys("This is a message to multiple recipients");
		driver.findElement(By.name("messageBody")).clear();
		driver.findElement(By.name("messageBody")).sendKeys("We really need to have a visit!");
		driver.findElement(By.cssSelector("input[type=\"submit\"]")).click();
		assertTrue(driver.getPageSource().contains("Gandalf Stormcrow"));
		assertTrue(driver.getPageSource().contains("Kelly Doctor"));
		assertTrue(driver.getPageSource().contains("This is a message to multiple recipients"));
	}
	
	public void testPatientSendReplyMultipleRecipients() throws Exception {
		driver = login("2", "pw");
		assertLogged(TransactionType.HOME_VIEW, 2L, 0L, "");
		driver.findElement(By.linkText("Message Inbox")).click();
		assertLogged(TransactionType.INBOX_VIEW, 2L, 0L, "");
		driver.findElement(By.linkText("Read")).click();
		assertLogged(TransactionType.MESSAGE_VIEW, 2L, 9000000000L, "");
		driver.findElement(By.linkText("Reply")).click();
		driver.findElement(By.name("cc")).click();
		driver.findElement(By.name("messageBody")).clear();
		driver.findElement(By.name("messageBody")).sendKeys("Which office visit did you update?");
		driver.findElement(By.cssSelector("input[type=\"submit\"]")).click();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date date = new Date();
		String stamp = dateFormat.format(date);
		driver.findElement(By.linkText("Message Outbox")).click();
		assertTrue(driver.getPageSource().contains("RE: Office Visit Updated"));
		assertTrue(driver.getPageSource().contains("Kelly Doctor"));
		assertTrue(driver.getPageSource().contains("Gandalf Stormcrow"));
		assertTrue(driver.getPageSource().contains(stamp));
		assertLogged(TransactionType.OUTBOX_VIEW, 2L, 0L, "");
		
		driver = login("9000000000", "pw");
		assertLogged(TransactionType.HOME_VIEW, 9000000000L, 0L, "");
		driver.findElement(By.linkText("Message Inbox")).click();
		assertLogged(TransactionType.INBOX_VIEW, 9000000000L, 0L, "");
		assertTrue(driver.getPageSource().contains("Andy Programmer"));
		assertTrue(driver.getPageSource().contains("RE: Office Visit Updated"));
		assertTrue(driver.getPageSource().contains(stamp));
		
		driver = login("9000000003", "pw");
		assertLogged(TransactionType.HOME_VIEW, 9000000003L, 0L, "");
		driver.findElement(By.linkText("Message Inbox")).click();
		assertLogged(TransactionType.INBOX_VIEW, 9000000003L, 0L, "");
		assertTrue(driver.getPageSource().contains("Andy Programmer"));
		assertTrue(driver.getPageSource().contains("RE: Office Visit Updated"));
		assertTrue(driver.getPageSource().contains(stamp));
	}
	
	public void testHCPSendReplySingleCCRecipient() throws Exception {
		gen.clearMessages();
		gen.messages6();
		driver = login("9000000000", "pw");
		assertLogged(TransactionType.HOME_VIEW, 9000000000L, 0L, "");
		driver.findElement(By.linkText("Message Inbox")).click();
		assertLogged(TransactionType.INBOX_VIEW, 9000000000L, 0L, "");
		driver.findElement(By.linkText("Read")).click();
		assertLogged(TransactionType.MESSAGE_VIEW, 9000000000L, 22L, "Viewed Message: 3");
		driver.findElement(By.linkText("Reply")).click();
		driver.findElement(By.name("cc")).click();
		driver.findElement(By.name("messageBody")).clear();
		driver.findElement(By.name("messageBody")).sendKeys("I will not be able to make my next schedulded appointment.  Is there anyone who can book another time?");
		driver.findElement(By.cssSelector("input[type=\"submit\"]")).click();
		assertLogged(TransactionType.MESSAGE_SEND, 9000000000L, 22L, "9000000007");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date date = new Date();
		String stamp = dateFormat.format(date);
		driver.findElement(By.linkText("Message Outbox")).click();
		assertTrue(driver.getPageSource().contains("RE: Appointment rescheduling"));
		assertTrue(driver.getPageSource().contains("Fozzie Bear"));
		assertTrue(driver.getPageSource().contains("Beaker Beaker"));
		assertTrue(driver.getPageSource().contains(stamp));
		assertLogged(TransactionType.OUTBOX_VIEW, 9000000000L, 0L, "");
		
		driver = login("22", "pw");
		assertLogged(TransactionType.HOME_VIEW, 22L, 0L, "");
		driver.findElement(By.linkText("Message Inbox")).click();
		assertLogged(TransactionType.INBOX_VIEW, 22L, 0L, "");
		assertTrue(driver.getPageSource().contains("Kelly Doctor"));
		assertTrue(driver.getPageSource().contains("RE: Appointment rescheduling"));
		assertTrue(driver.getPageSource().contains(stamp));
		
		driver = login("9000000007", "pw");
		assertLogged(TransactionType.HOME_VIEW, 9000000007L, 0L, "");
		driver.findElement(By.linkText("Message Inbox")).click();
		assertLogged(TransactionType.INBOX_VIEW, 9000000007L, 0L, "");
		assertTrue(driver.getPageSource().contains("Kelly Doctor"));
		assertTrue(driver.getPageSource().contains("RE: Appointment rescheduling"));
		assertTrue(driver.getPageSource().contains(stamp));
	}

	public void testHCPFilter() throws Exception {
		// Log in as Kelly Doctor
		driver = login("9000000000", "pw");
		assertLogged(TransactionType.HOME_VIEW, 9000000000L, 0L, "");
		// Navigate to the Message Inbox page
		driver.findElement(By.linkText("Message Inbox")).click();
		assertLogged(TransactionType.INBOX_VIEW, 9000000000L, 0L, "");
		// Click on Edit Filter and enter relevant information
		driver.findElement(By.linkText("Edit Filter")).click();
		driver.findElement(By.name("sender")).sendKeys("Andy Programmer");
		driver.findElement(By.name("hasWords")).sendKeys("schedule");
		driver.findElement(By.name("startDate")).sendKeys("02/02/2010");
		driver.findElement(By.name("subject")).sendKeys("Scratchy Throat");
		driver.findElement(By.name("notWords")).sendKeys("checked");
		driver.findElement(By.name("endDate")).sendKeys("02/03/2010");
		// Click on Test Filter and check for correct filtered messages
		driver.findElement(By.name("test")).click();
		assertTrue(driver.getPageSource().contains("Andy Programmer"));
		assertTrue(driver.getPageSource().contains("Scratchy Throat"));
		assertFalse(driver.getPageSource().contains("Random Person"));
		assertFalse(driver.getPageSource().contains("Lab Results"));
		assertFalse(driver.getPageSource().contains("2010-01-13 13:46:00.0"));
		// Save the filter
		driver.findElement(By.name("save")).click();

		// Log in again as Kelly Doctor
		driver = login("9000000000", "pw");
		assertLogged(TransactionType.HOME_VIEW, 9000000000L, 0L, "");
		// Navigate to the Message Inbox page
		driver.findElement(By.linkText("Message Inbox")).click();
		assertLogged(TransactionType.INBOX_VIEW, 9000000000L, 0L, "");
		// Apply the saved filter and check for correct filtered messages
		driver.findElement(By.linkText("Apply Filter")).click();
		assertTrue(driver.getPageSource().contains("Visit Request"));
		assertTrue(driver.getPageSource().contains("Andy Programmer"));
		assertFalse(driver.getPageSource().contains("Random Person"));
		// Click on Edit Filter and check if the fields are saved properly
		driver.findElement(By.linkText("Edit Filter")).click();
		assertTrue(driver.findElement(By.name("sender")).getAttribute("value").equals("Andy Programmer"));
		assertTrue(driver.findElement(By.name("hasWords")).getAttribute("value").equals("schedule"));
		assertTrue(driver.findElement(By.name("startDate")).getAttribute("value").equals("02/02/2010"));
		assertTrue(driver.findElement(By.name("subject")).getAttribute("value").equals("Scratchy Throat"));
		assertTrue(driver.findElement(By.name("notWords")).getAttribute("value").equals("checked"));
		assertTrue(driver.findElement(By.name("endDate")).getAttribute("value").equals("02/03/2010"));
		// Click on Cancel and check if the filter is removed properly
		driver.findElement(By.name("cancel")).click();
		assertTrue(driver.getPageSource().contains("Visit Request"));
		assertTrue(driver.getPageSource().contains("Andy Programmer"));
		assertTrue(driver.getPageSource().contains("Random Person"));

	}

	public void testPatientFilter() throws Exception {
		// Log in as Random Person
		driver = login("2", "pw");
		assertLogged(TransactionType.HOME_VIEW, 2L, 0L, "");
		// Navigate to the inbox
		driver.findElement(By.linkText("Message Inbox")).click();
		assertLogged(TransactionType.INBOX_VIEW, 2L, 0L, "");
		// Click on Edit Filter and enter relevant information
		driver.findElement(By.linkText("Edit Filter")).click();
		driver.findElement(By.name("sender")).sendKeys("Kelly Doctor");
		driver.findElement(By.name("hasWords")).sendKeys("checked");
		driver.findElement(By.name("startDate")).sendKeys("01/28/2010");
		driver.findElement(By.name("subject")).sendKeys("Lab Procedure");
		driver.findElement(By.name("notWords")).sendKeys("schedule");
		driver.findElement(By.name("endDate")).sendKeys("02/03/2010");
		// Click on Test Filter and check for correct filtered messages
		driver.findElement(By.name("test")).click();
		assertTrue(driver.getPageSource().contains("Kelly Doctor"));
		assertTrue(driver.getPageSource().contains("Lab Procedure"));
		assertFalse(driver.getPageSource().contains("Andy Programming"));
		assertFalse(driver.getPageSource().contains("Lab Results"));
		// Save the filter
		driver.findElement(By.name("save")).click();

		// Log in as Random Person
		driver = login("2", "pw");
		assertLogged(TransactionType.HOME_VIEW, 2L, 0L, "");
		// Navigate to the inbox
		driver.findElement(By.linkText("Message Inbox")).click();
		assertLogged(TransactionType.INBOX_VIEW, 2L, 0L, "");
		// Apply the saved filter and check for correct filtered messages
		driver.findElement(By.linkText("Apply Filter")).click();
		assertTrue(driver.getPageSource().contains("Lab Procedure"));
		assertTrue(driver.getPageSource().contains("Kelly Doctor"));
		assertFalse(driver.getPageSource().contains("Lab Results"));
		// Click on Edit Filter and check if the fields are saved properly
		driver.findElement(By.linkText("Edit Filter")).click();
		assertTrue(driver.findElement(By.name("sender")).getAttribute("value").equals("Kelly Doctor"));
		assertTrue(driver.findElement(By.name("hasWords")).getAttribute("value").equals("checked"));
		assertTrue(driver.findElement(By.name("startDate")).getAttribute("value").equals("01/28/2010"));
		assertTrue(driver.findElement(By.name("subject")).getAttribute("value").equals("Lab Procedure"));
		assertTrue(driver.findElement(By.name("notWords")).getAttribute("value").equals("schedule"));
		assertTrue(driver.findElement(By.name("endDate")).getAttribute("value").equals("02/03/2010"));
		// Click on Cancel and check if the filter is removed properly
		driver.findElement(By.name("cancel")).click();
		assertTrue(driver.getPageSource().contains("Visit Request"));
		assertTrue(driver.getPageSource().contains("Andy Programmer"));
		assertTrue(driver.getPageSource().contains("Random Person"));
	}

}