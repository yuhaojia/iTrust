package edu.ncsu.csc.itrust.selenium;

import java.util.concurrent.TimeUnit;

import com.meterware.httpunit.HttpUnitOptions;
import edu.ncsu.csc.itrust.unit.datagenerators.TestDataGenerator;
import org.openqa.selenium.By;
import org.openqa.selenium.htmlunit.HtmlUnitDriver;

public class PreRegisterTest extends iTrustSeleniumTest{
    TestDataGenerator gen = new TestDataGenerator();
	/*
	 * The URL for iTrust, change as needed
	 */
    /**ADDRESS*/
    public static final String ADDRESS = "http://localhost:8080/iTrust/";

    /**
     * Set up for testing.
     */
    protected void setUp() throws Exception {
        super.setUp();
        gen.clearAllTables();
        gen.standardData();
        // turn off htmlunit warnings
        java.util.logging.Logger.getLogger("com.gargoylesoftware.htmlunit").setLevel(java.util.logging.Level.OFF);
        java.util.logging.Logger.getLogger("org.apache.http").setLevel(java.util.logging.Level.OFF);
        HttpUnitOptions.setExceptionsThrownOnScriptError(false);
    }

    /**
     * Tear down from testing.
     */
    protected void tearDown() throws Exception {
        super.tearDown();
    }

    public void testInvalidPreregister() throws Exception {
        HtmlUnitDriver driver = new HtmlUnitDriver();
        driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
        driver.get(ADDRESS);

        driver.findElement(By.id("j_firstname")).clear();
        driver.findElement(By.id("j_firstname")).sendKeys("testname");
        //omit lastname intentionally
        //driver.findElement(By.id("j_lastname")).clear();
        //driver.findElement(By.id("j_lastname")).sendKeys("foo");
        driver.findElement(By.id("j_pass")).clear();
        driver.findElement(By.id("j_pass")).sendKeys("testpass");
        driver.findElement(By.id("j_passwordverif")).clear();
        driver.findElement(By.id("j_passwordverif")).sendKeys("nomatchingpass");
        driver.findElement(By.id("j_email")).clear();
        driver.findElement(By.id("j_email")).sendKeys("email@wrongformat");

        driver.findElement(By.xpath("//*[@id=\"iTrustMenu\"]/div/div/div[2]/form[2]/input[23]")).click();

        assertTrue(driver.getPageSource().contains("At lease one required field is not filled"));
        assertTrue(driver.getPageSource().contains("Password does not match"));
        assertTrue(driver.getPageSource().contains("Email not valid"));
    }

    public void testValidPreregister() throws Exception {
        HtmlUnitDriver driver = new HtmlUnitDriver();
        driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
        driver.get(ADDRESS);

        driver.findElement(By.id("j_firstname")).clear();
        driver.findElement(By.id("j_firstname")).sendKeys("first");
        driver.findElement(By.id("j_lastname")).clear();
        driver.findElement(By.id("j_lastname")).sendKeys("last");
        driver.findElement(By.id("j_pass")).clear();
        driver.findElement(By.id("j_pass")).sendKeys("pass");
        driver.findElement(By.id("j_passwordverif")).clear();
        driver.findElement(By.id("j_passwordverif")).sendKeys("pass");
        driver.findElement(By.id("j_email")).clear();
        driver.findElement(By.id("j_email")).sendKeys("email@format.com");

        driver.findElement(By.xpath("//*[@id=\"iTrustMenu\"]/div/div/div[2]/form[2]/input[23]")).click();

        assertEquals("iTrust - Preregister", driver.getTitle());
    }

    public void testPreregisteredUserLogin() throws Exception {
        HtmlUnitDriver driver = new HtmlUnitDriver();
        driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
        driver.get(ADDRESS);

        driver.findElement(By.id("j_firstname")).clear();
        driver.findElement(By.id("j_firstname")).sendKeys("first");
        driver.findElement(By.id("j_lastname")).clear();
        driver.findElement(By.id("j_lastname")).sendKeys("last");
        driver.findElement(By.id("j_pass")).clear();
        driver.findElement(By.id("j_pass")).sendKeys("pass");
        driver.findElement(By.id("j_passwordverif")).clear();
        driver.findElement(By.id("j_passwordverif")).sendKeys("pass");
        driver.findElement(By.id("j_email")).clear();
        driver.findElement(By.id("j_email")).sendKeys("diffemail@format.com");

        driver.findElement(By.xpath("//*[@id=\"iTrustMenu\"]/div/div/div[2]/form[2]/input[23]")).click();

        String mid = driver.findElement(By.xpath("//*[@id=\"iTrustContent\"]/h2[2]")).getText().substring(9);

        driver.findElement(By.xpath("//*[@id=\"iTrustMenu\"]/div/form[2]/input")).click();

        driver.findElement(By.id("j_username")).clear();
        driver.findElement(By.id("j_username")).sendKeys(mid);
        driver.findElement(By.id("j_password")).clear();
        driver.findElement(By.id("j_password")).sendKeys("pass");
        driver.findElement(By.cssSelector("input[type=\"submit\"]")).click();

        assertEquals("iTrust - Patient Home", driver.getTitle());

        driver.findElement(By.xpath("/html/body/div[1]/div/div[2]/ul/li[2]/a")).click();
    }
}
