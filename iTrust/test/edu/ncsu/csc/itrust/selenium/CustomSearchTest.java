package edu.ncsu.csc.itrust.selenium;

import org.openqa.selenium.htmlunit.HtmlUnitDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.By;

import java.util.List;


public class CustomSearchTest extends iTrustSeleniumTest {

    public static final String ADDRESS = "http://localhost:8080/iTrust/";

    private HtmlUnitDriver driver;

    @Override
    protected void setUp() throws Exception {
        super.setUp();
        gen.clearAllTables();
        gen.standardData();
    }


    public void testCustomSiteFrontEnd() throws Exception{
        String baseUrl = "http://localhost:8080/iTrust/";

        driver = (HtmlUnitDriver)login("1", "pw");



        assertEquals("iTrust - Patient Home", driver.getTitle());
        driver.get(baseUrl + "auth/patient/myDiagnoses.jsp");
        assertEquals("iTrust - My Diagnoses",driver.getTitle());


        WebElement search = driver.findElement(By.id("search"));
        WebElement query = driver.findElement(By.id("query"));

        assertEquals("Search on Wikipedia",search.getAttribute("text"));
        assertEquals("Search on WebMD",query.getAttribute("text"));


    }



    public void testSearchWikipedia() throws Exception{
        String baseUrl = "http://localhost:8080/iTrust/";
        driver = (HtmlUnitDriver)login("1", "pw");
        driver.get(baseUrl + "auth/patient/myDiagnoses.jsp");


        driver.findElement(By.id("search")).sendKeys("Influenza");

        WebElement site = driver.findElement(By.id("wikisearch"));
        site.click();

        assertEquals("Influenza - Wikipedia",driver.getTitle());


    }

    public void testSearchWebMD() throws Exception{
        String baseUrl = "http://localhost:8080/iTrust/";
        driver = (HtmlUnitDriver)login("1", "pw");
        driver.get(baseUrl + "auth/patient/myDiagnoses.jsp");


        driver.findElement(By.id("query")).sendKeys("Influenza");

        WebElement site = driver.findElement(By.id("mdsearch"));
        site.click();

        assertEquals("WebMD Health Search",driver.getTitle());


    }





}
