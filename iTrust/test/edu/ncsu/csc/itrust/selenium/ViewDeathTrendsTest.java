package edu.ncsu.csc.itrust.selenium;

import org.openqa.selenium.htmlunit.HtmlUnitDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.By;

import java.util.List;




public class ViewDeathTrendsTest extends iTrustSeleniumTest {


    public static final String ADDRESS = "http://localhost:8080/iTrust/";

    private HtmlUnitDriver driver;

    @Override
    protected void setUp() throws Exception {
        super.setUp();
        gen.clearAllTables();
        gen.standardData();
        gen.deadPatients();
    }


    public void testDeathTrendsMales() throws Exception{
        String baseUrl = "http://localhost:8080/iTrust/";

        driver = (HtmlUnitDriver)login("9000000000", "pw");
        assertEquals("iTrust - HCP Home", driver.getTitle());
        driver.get(baseUrl + "auth/hcp/viewDeathTrends.jsp");
        assertEquals("iTrust - View Cause-Of-Death Trends",driver.getTitle());


        driver.findElement(By.id("start")).clear();
        driver.findElement(By.id("start")).sendKeys("1990");

        driver.findElement(By.id("end")).clear();
        driver.findElement(By.id("end")).sendKeys("2015");

        List<WebElement> buts = driver.findElements(By.name("gender"));
        System.out.println("Size: " + buts.size());
        buts.get(1).click();


        WebElement form = driver.findElement(By.id("formMain"));
        form.submit();

        WebElement table = driver.findElement(By.id("deathTrendsTable"));

        List<WebElement> table_headers = table.findElements(By.tagName("tr"));

        assertEquals("Diagnosis codeDiagnosis nameNumber of deaths",table_headers.get(0).getText());
        assertEquals("250.10Diabetes with ketoacidosis3",table_headers.get(1).getText());
        assertEquals("84.50Malaria2",table_headers.get(2).getText());



    }


    public void testDeathTrendsFemales() throws Exception{
        String baseUrl = "http://localhost:8080/iTrust/";

        driver = (HtmlUnitDriver)login("9000000000", "pw");
        assertEquals("iTrust - HCP Home", driver.getTitle());
        driver.get(baseUrl + "auth/hcp/viewDeathTrends.jsp");
        assertEquals("iTrust - View Cause-Of-Death Trends",driver.getTitle());


        driver.findElement(By.id("start")).clear();
        driver.findElement(By.id("start")).sendKeys("1990");

        driver.findElement(By.id("end")).clear();
        driver.findElement(By.id("end")).sendKeys("2015");

        List<WebElement> buts = driver.findElements(By.name("gender"));
        System.out.println("Size: " + buts.size());
        buts.get(2).click();


        WebElement form = driver.findElement(By.id("formMain"));
        form.submit();

        WebElement table = driver.findElement(By.id("deathTrendsTable"));

        List<WebElement> table_headers = table.findElements(By.tagName("tr"));

        assertEquals("Diagnosis codeDiagnosis nameNumber of deaths",table_headers.get(0).getText());
        assertEquals("487.00Influenza2",table_headers.get(1).getText());
        assertEquals("250.10Diabetes with ketoacidosis1",table_headers.get(2).getText());


    }

    public void testDeathTrendsBoth() throws Exception{
        String baseUrl = "http://localhost:8080/iTrust/";

        driver = (HtmlUnitDriver)login("9000000000", "pw");
        assertEquals("iTrust - HCP Home", driver.getTitle());
        driver.get(baseUrl + "auth/hcp/viewDeathTrends.jsp");
        assertEquals("iTrust - View Cause-Of-Death Trends",driver.getTitle());


        driver.findElement(By.id("start")).clear();
        driver.findElement(By.id("start")).sendKeys("1990");

        driver.findElement(By.id("end")).clear();
        driver.findElement(By.id("end")).sendKeys("2015");


        WebElement form = driver.findElement(By.id("formMain"));
        form.submit();

        WebElement table = driver.findElement(By.id("deathTrendsTable"));

        List<WebElement> table_headers = table.findElements(By.tagName("tr"));

        assertEquals("Diagnosis codeDiagnosis nameNumber of deaths",table_headers.get(0).getText());
        assertEquals("250.10Diabetes with ketoacidosis4",table_headers.get(1).getText());
        assertEquals("487.00Influenza3",table_headers.get(2).getText());

    }

    public void testInvalidYears() throws Exception{
        String baseUrl = "http://localhost:8080/iTrust/";

        driver = (HtmlUnitDriver)login("9000000000", "pw");
        assertEquals("iTrust - HCP Home", driver.getTitle());
        driver.get(baseUrl + "auth/hcp/viewDeathTrends.jsp");
        assertEquals("iTrust - View Cause-Of-Death Trends",driver.getTitle());


        driver.findElement(By.id("start")).clear();
        driver.findElement(By.id("start")).sendKeys("2020");

        driver.findElement(By.id("end")).clear();
        driver.findElement(By.id("end")).sendKeys("2015");


        WebElement form = driver.findElement(By.id("formMain"));
        form.submit();

        WebElement message = driver.findElement(By.id("validateMessage"));
        assertEquals("This form has not been validated correctly. The following field are not properly " +
                "filled in: [End year cannot be before start year!, Start year cannot be in the future!]",message.getText());

    }


}
