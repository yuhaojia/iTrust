package edu.ncsu.csc.itrust.beans.loaders;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import edu.ncsu.csc.itrust.beans.EmailAddressBean;

/**
 * A loader for Email addresses.
 *
 * Loads in information to/from beans using ResultSets and PreparedStatements. Use the superclass to enforce consistency.
 * For details on the paradigm for a loader (and what its methods do), see {@link BeanLoader}
 */
public class EmailAddressBeanLoader implements BeanLoader<EmailAddressBean> {
    /**
     * Sets the parameters for the query
     * @param ps The prepared statement to be loaded.
     * @param emailAddr
     * @return
     * @throws SQLException
     */
    public PreparedStatement loadParameters(PreparedStatement ps, EmailAddressBean emailAddr) throws SQLException {
        ps.setString(1, emailAddr.getAddress());
        return ps;
    }

    /**
     * loadSingle
     * @param rs rs
     * @return p
     * @throws SQLException
     */
    public EmailAddressBean loadSingle(ResultSet rs) throws SQLException {
        EmailAddressBean emailAddr = new EmailAddressBean();
        int numDuplicates = rs.getInt(1);
        emailAddr.setUnique(numDuplicates == 0);
        return emailAddr;
    }

    /**
     * loadList
     * @param rs rs
     * @throws SQLException
     */
    public List<EmailAddressBean> loadList(ResultSet rs) throws SQLException {
        List<EmailAddressBean> list = new ArrayList<>();
        while (rs.next()) {
            list.add(loadSingle(rs));
        }
        return list;
    }

}
