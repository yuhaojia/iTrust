package edu.ncsu.csc.itrust.unit.bean;

import edu.ncsu.csc.itrust.beans.EmailAddressBean;
import junit.framework.TestCase;

public class EmailAddressBeanTest extends TestCase {

    public void testSetters() throws Exception {
        EmailAddressBean email = new EmailAddressBean();
        String expectedAddress = "address";
        email.setAddress(expectedAddress);
        email.setUnique(true);
        assertEquals(expectedAddress, email.getAddress());
        assertTrue(email.isUnique());
    }
}
