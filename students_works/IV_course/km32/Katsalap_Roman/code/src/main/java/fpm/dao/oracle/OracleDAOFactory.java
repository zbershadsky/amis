package fpm.dao.oracle;

import com.sun.org.apache.xpath.internal.operations.Or;
import fpm.dao.interfaces.*;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class OracleDAOFactory  {

    final static String URL = "jdbc:oracle:thin:@localhost:1521:orcl2";
    final static String USER_LOGIN = "Roma";
    final static String USER_PASS = "orcl";


    public OracleDAOFactory() {

    }

    public static Connection open()  {
        Connection con;
        try {
            con = OracleDAOFactory.createConnection();
            return con;
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (NamingException e) {
            e.printStackTrace();
        }
        return null;
    }


    public static void close(Connection con) {
        try {
            if(con!=null && !con.isClosed())
                con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public static Connection createConnection() throws SQLException, ClassNotFoundException, NamingException {

        /*
        InitialContext initContext= new InitialContext();
        DataSource ds = (DataSource) initContext.lookup("java:comp/env/jdbc/dbconnect");
        Connection conn = ds.getConnection();
        return conn;
        */

        DriverManager.registerDriver (new oracle.jdbc.OracleDriver());
        //Class.forName("oracle.jdbc.driver.OracleDriver");
        return DriverManager.getConnection(URL,USER_LOGIN,USER_PASS);

    }

    public UserDAO getUserDAO() {

        // CloudscapeCustomerDAO implements CustomerDAO
        return new OracleUserDAO();
    }
    public PaymentDAO getPaymentDAO() {
        // CloudscapeAccountDAO implements AccountDAO
        return new OraclePaymentDAO();
    }
    public CardDAO getCardDAO() {
        // CloudscapeOrderDAO implements OrderDAO
        return new OracleCardDAO();
    }

    public PhoneDAO getPhoneDAO() {
        return new OraclePhoneDAO();
    }


}
