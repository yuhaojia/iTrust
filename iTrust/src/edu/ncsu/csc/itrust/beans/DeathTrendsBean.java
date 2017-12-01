package edu.ncsu.csc.itrust.beans;
import java.util.List;

/**
 * A bean for storing data about a death trends query for a given
 * HCP's patients who visited their office in a given range of years.
 *
 * A bean's purpose is to store data. Period. Little or no functionality is to be added to a bean
 * (with the exception of minor formatting such as concatenating phone numbers together).
 * A bean must only have Getters and Setters (Eclipse Hint: Use Source > Generate Getters and Setters.
 * to create these easily)
 */
public class DeathTrendsBean {
    private long hcpid;
    private String startYear;
    private String endYear;
    private List<String> icdCodes;
    private List<String> icdNames;
    private List<Long> numDeaths;

    /**
     * @param hcpid hcpid
     * @param startYear startYear
     * @param endYear endYear
     * @param icdCodes icdCodes
     * @param icdNames icdNames
     * @param numDeaths numDeaths
     */
    public DeathTrendsBean(long hcpid, String startYear, String endYear, List<String> icdCodes, List<String> icdNames, List<Long> numDeaths) {
        this.hcpid = hcpid;
        this.startYear = startYear;
        this.endYear = endYear;
        this.icdCodes = icdCodes;
        this.icdNames = icdNames;
        this.numDeaths = numDeaths;
    }



    /**
     * Gets the HCPID for this death trends query
     *
     * @return The HCPID for this death trends query
     */
    public long getHCPID() {
        return hcpid;
    }

    /**
     * Sets the HCPID for this death trends query
     * @param hcpid hcpid
     */
    public void setHCPID(long hcpid) {
        this.hcpid = hcpid;
    }



    /**
     * Gets the start year for this death trends query
     *
     * @return The start year for this death trends query
     */
    public String getStartYear() {
        return startYear;
    }

    /**
     * Sets the start year for this death trends query
     * @param startYear startYear
     */
    public void setStartYear(String startYear) {
        this.startYear = startYear;
    }



    /**
     * Gets the end year for this death trends query
     *
     * @return The end year for this death trends query
     */
    public String getEndYear() {
        return endYear;
    }

    /**
     * Sets the end year for this death trends query
     * @param endYear endYear
     */
    public void setEndYear(String endYear) {
        this.endYear = endYear;
    }



    /**
     * Gets the ICD codes for this death trends query
     *
     * @return The ICD codes for this death trends query
     */
    public List<String> getICDCodes() {
        return icdCodes;
    }

    /**
     * Sets the ICD codes for this death trends query
     * @param icdCodes icdCodes
     */
    public void setICDCodes(List<String> icdCodes) {
        this.icdCodes = icdCodes;
    }



    /**
     * Gets the names of the ICD codes for this death trends query
     *
     * @return The names of the ICD codes for this death trends query
     */
    public List<String> getICDNames() {
        return icdNames;
    }

    /**
     * Sets the names of the ICD codes for this death trends query
     * @param icdNames icdNames
     */
    public void setICDNames(List<String> icdNames) {
        this.icdNames = icdNames;
    }



    /**
     * Gets number of deaths per ICD code for this death trends query
     *
     * @return number of deaths per ICD code for this death trends query
     */
    public List<Long> getNumDeaths() {
        return numDeaths;
    }

    /**
     * Sets number of deaths per ICD code for this death trends query
     * @param numDeaths numDeaths
     */
    public void setNumDeaths(List<Long> numDeaths) {
        this.numDeaths = numDeaths;
    }



}
