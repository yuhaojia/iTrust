package edu.ncsu.csc.itrust.selenium;

import java.util.List;
import java.util.concurrent.TimeUnit;

import org.openqa.selenium.Alert;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.htmlunit.HtmlUnitDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;

import com.meterware.httpunit.HttpUnitOptions;

import edu.ncsu.csc.itrust.enums.TransactionType;

public class ViewPreregisteredPatientsTest extends iTrustSeleniumTest {

	/*
	 * The URL for iTrust, change as needed
	 */
    /**ADDRESS*/
    public static final String ADDRESS = "http://localhost:8080/iTrust/";

    private HtmlUnitDriver driver;

    /**
     * Set up for testing.
     */
    protected void setUp() throws Exception {
        super.setUp();
        gen.clearAllTables();
        gen.standardData();
        // turn off htmlunit warnings
        //java.util.logging.Logger.getLogger("com.gargoylesoftware.htmlunit").setLevel(java.util.logging.Level.OFF);
        //java.util.logging.Logger.getLogger("org.apache.http").setLevel(java.util.logging.Level.OFF);
        //HttpUnitOptions.setExceptionsThrownOnScriptError(false);
    }

    /**
     * Tear down from testing.
     */
    protected void tearDown() throws Exception {
        super.tearDown();
    }



    public void testResetPassword() throws Exception {

        String baseUrl = "http://localhost:8080/iTrust/";

        driver = (HtmlUnitDriver)login("9000000000", "pw");
        assertEquals("iTrust - HCP Home", driver.getTitle());
        driver.get(baseUrl + "auth/hcp-uap/viewPreregisteredPatients.jsp");
        assertEquals("iTrust - View All Preregistered Patients",driver.getTitle());

        WebElement table = driver.findElement(By.id("patientList"));
        List<WebElement> table_headers = table.findElements(By.xpath("id('patientList')/thead/tr/th"));
        System.out.println(table_headers.size());


        WebElement head1 = table_headers.get(0);
        assertEquals("Name",head1.getText());
        head1 = table_headers.get(1);
        assertEquals("Address",head1.getText());
        head1 = table_headers.get(2);
        assertEquals("Email",head1.getText());
        head1 = table_headers.get(3);
        assertEquals("Phone",head1.getText());
        head1 = table_headers.get(7);
        assertEquals("Height",head1.getText());
        head1 = table_headers.get(8);
        assertEquals("Weight",head1.getText());
        head1 = table_headers.get(9);
        assertEquals("Smoker",head1.getText());

        WebElement element;
        element = driver.findElement(By.linkText("Brody Franco"));
        element.click();

        assertEquals("iTrust - Edit Personal Health Record",driver.getTitle());

        WebElement element2;
        element2 = driver.findElement(By.linkText("Register"));
        element2.click();

        assertEquals("iTrust - Register Patient",driver.getTitle());

        driver.get(baseUrl + "auth/hcp-uap/viewPatientOfficeVisitHistory.jsp");

        element = driver.findElement(By.linkText("Brody Franco"));
        element.click();

        element2 = driver.findElement(By.linkText("DeRegister"));
        element2.click();

        assertEquals("iTrust - DeRegister Patient",driver.getTitle());


    }
}
