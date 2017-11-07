package edu.ncsu.csc.itrust.unit.bean;

import junit.framework.TestCase;

import static org.easymock.EasyMock.expect;
import static org.easymock.classextension.EasyMock.createControl;
import static org.junit.Assert.*;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import org.easymock.classextension.IMocksControl;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import edu.ncsu.csc.itrust.beans.EmailAddressBean;
import edu.ncsu.csc.itrust.beans.loaders.EmailAddressBeanLoader;

public class EmailAddressBeanLoaderTest extends TestCase {

    private IMocksControl ctrl;
    private ResultSet rs;
    private EmailAddressBeanLoader load;

    @Before
    public void setUp() throws Exception {
        ctrl = createControl();
        rs = ctrl.createMock(ResultSet.class);
        load = new EmailAddressBeanLoader();
    }

    @After
    public void tearDown() throws Exception {
    }

    @Test
    public void testLoadList() throws SQLException {
        List<EmailAddressBean> l = load.loadList(rs);
        assertEquals(0, l.size());

    }

    @Test
    public void testLoadSingle() {

        try {
            expect(rs.getInt(1)).andReturn(0).once();
            ctrl.replay();

            EmailAddressBean r = load.loadSingle(rs);
            assertTrue(r.isUnique());
        } catch (SQLException e) {
        }
    }

    @Test
    public void testLoadParameters() {
        try{
            load.loadParameters(null, null);
            fail();
        } catch (Exception e){

        }
    }
}
