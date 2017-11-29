package edu.ncsu.csc.itrust.dao.mysql;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import edu.ncsu.csc.itrust.DBUtil;
import edu.ncsu.csc.itrust.beans.EmailAddressBean;
import edu.ncsu.csc.itrust.beans.loaders.EmailAddressBeanLoader;
import edu.ncsu.csc.itrust.dao.DAOFactory;
import edu.ncsu.csc.itrust.exception.DBException;

/**
 *
 * DAO stands for Database Access Object. All DAOs are intended to be reflections of the database, that is,
 * one DAO per table in the database (most of the time). For more complex sets of queries, extra DAOs are
 * added. DAOs can assume that all data has been validated and is correct.
 *
 * DAOs should never have setters or any other parameter to the constructor than a factory. All DAOs should be
 * accessed by DAOFactory (@see {@link DAOFactory}) and every DAO should have a factory - for obtaining JDBC
 * connections and/or accessing other DAOs.
 *
 *
 *
 */
public class EmailAddressDAO {
    private DAOFactory factory;
    private EmailAddressBeanLoader emailAddrLoader = new EmailAddressBeanLoader();

    /**
     * The typical constructor.
     * @param factory The {@link DAOFactory} associated with this DAO, which is used for obtaining SQL connections, etc.
     */
    public EmailAddressDAO(DAOFactory factory) {
        this.factory = factory;
    }

    /**
     * Finds out if there are patients with duplicate emails in the database currently. Returns a new
     * EmailAddressBean with the isUnique member variable set to indicate whether the given EmailAddressBean's
     * email address is unique.
     *
     * @return An int representing the number of duplicate email address entries in the database.
     * @throws DBException
     */
    public EmailAddressBean isUniqueEmailAddress(EmailAddressBean emailAddr) throws DBException {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = factory.getConnection();
            ps = conn.prepareStatement("SELECT COUNT(1) FROM patients WHERE email=?");
            ps = emailAddrLoader.loadParameters(ps, emailAddr);
            ResultSet rs = ps.executeQuery();
            EmailAddressBean newEmailAddrBean = null;
            if (rs.next())
                newEmailAddrBean = emailAddrLoader.loadSingle(rs);
            rs.close();
            ps.close();
            return newEmailAddrBean;
        } catch (SQLException e) {
            throw new DBException(e);
        } finally {
            DBUtil.closeConnection(conn, ps);
        }
    }
}
