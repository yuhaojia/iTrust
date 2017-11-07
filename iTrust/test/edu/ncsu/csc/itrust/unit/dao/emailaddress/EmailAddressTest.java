package edu.ncsu.csc.itrust.unit.dao.emailaddress;

import junit.framework.TestCase;

import edu.ncsu.csc.itrust.beans.EmailAddressBean;
import edu.ncsu.csc.itrust.dao.DAOFactory;
import edu.ncsu.csc.itrust.unit.datagenerators.TestDataGenerator;
import edu.ncsu.csc.itrust.unit.testutils.TestDAOFactory;

public class EmailAddressTest extends TestCase {

    DAOFactory factory = TestDAOFactory.getTestInstance();

    @Override
    protected void setUp() throws Exception {
    }

    public void testIsUniqueEmailAddress() throws Exception {
        EmailAddressBean input = new EmailAddressBean();
        input.setAddress("a.unique@address.com");
        EmailAddressBean email = factory.getEmailAddressDAO().isUniqueEmailAddress(input);
        assertTrue(email.isUnique());
    }
}
