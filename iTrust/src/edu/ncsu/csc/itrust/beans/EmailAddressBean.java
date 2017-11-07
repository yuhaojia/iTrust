package edu.ncsu.csc.itrust.beans;

public class EmailAddressBean {
    private String address;
    private boolean isUnique;

    /**
     * Default constructor
     */
    public EmailAddressBean() {
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public boolean isUnique() { return isUnique; }

    public void setUnique(boolean unique) { isUnique = unique; }
}
