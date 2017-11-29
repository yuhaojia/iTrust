/**
 * Tests for AddPatientAction
 */

package edu.ncsu.csc.itrust.unit.action;

import edu.ncsu.csc.itrust.beans.HealthRecord;
import edu.ncsu.csc.itrust.dao.mysql.HealthRecordsDAO;
import junit.framework.TestCase;
import edu.ncsu.csc.itrust.action.AddPatientAction;
import edu.ncsu.csc.itrust.beans.PatientBean;
import edu.ncsu.csc.itrust.dao.DAOFactory;
import edu.ncsu.csc.itrust.dao.mysql.AuthDAO;
import edu.ncsu.csc.itrust.unit.datagenerators.TestDataGenerator;
import edu.ncsu.csc.itrust.unit.testutils.TestDAOFactory;

public class AddPatientActionTest extends TestCase {
	private DAOFactory factory = TestDAOFactory.getTestInstance();
	private TestDataGenerator gen;
	private AddPatientAction action;
	
/**
 * Sets up defaults
 */
	@Override
	protected void setUp() throws Exception {
		gen = new TestDataGenerator();
		
		gen.transactionLog();
		gen.patient2();
		action = new AddPatientAction(factory, 9000000000L);
	}

	/**
	 * Tests adding a new patient
	 * @throws Exception
	 */
	public void testAddPatient() throws Exception {
		AuthDAO authDAO = factory.getAuthDAO();
		
		//Add a dependent
		PatientBean p = new PatientBean();
		p.setFirstName("Jiminy");
		p.setLastName("Cricket");
		p.setEmail("make.awish@gmail.com");
		long newMID = action.addDependentPatient(p, 102);
		assertEquals(p.getMID(), newMID);
		assertTrue(authDAO.isDependent(newMID));
		
		//Add a non-dependent
		p.setFirstName("Chuck");
		p.setLastName("Cheese");
		p.setEmail("admin@chuckecheese.com");
		newMID = action.addPatient(p);
		assertEquals(p.getMID(), newMID);
		assertFalse(authDAO.isDependent(newMID));
	}

	/**
	 * Tests adding a new preregistered patient
	 * @throws Exception
	 */
	public void testAddPRPatient() throws Exception {
		PatientBean p = new PatientBean();
		HealthRecord h = new HealthRecord();
		action = new AddPatientAction(factory);
		p.setFirstName("Jiminy");
		p.setLastName("Cricket");
		p.setEmail("make.awish@gmail.com");
		p.setCity("Test city");
		p.setPassword("password");
		p.setDateOfBirthStr("01/01/2017");
		p.setEmergencyName("test");
		p.setIcCity("testiccity");
		p.setIcState("CA");
		p.setState("CA");
		p.setPhone("1111111111");
		p.setStreetAddress1("street address");
		p.setZip("11111");
		p.setPreregistered(true);
		long newMID = action.addPRPatient(p, h);
		assertEquals(p.getMID(), newMID);
		assertTrue(p.isPreregistered());
		assertEquals(h.getPatientID(), newMID);
	}

	/**
	 * Tests checking if email is unique in the case where it is unique
	 * @throws Exception
	 */
	public void testCheckPatientEmailIsUniqueTrueCase() throws Exception {
		PatientBean p = new PatientBean();
		action = new AddPatientAction(factory);
		p.setEmail("does.not@exist.com");
		assertTrue(action.checkPatientEmailIsUnique(p));
	}

	/**
	 * Tests checking if email is unique in the case where it is not unique.
	 * The email used in this test is taken from the patient2.sql test file.
	 * @throws Exception
	 */
	public void testCheckPatientEmailIsUniqueFalseCase() throws Exception {
		PatientBean p = new PatientBean();
		action = new AddPatientAction(factory);
		p.setEmail("andy.programmer@gmail.com");
		assertFalse(action.checkPatientEmailIsUnique(p));
	}
}
