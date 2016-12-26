package belcer.remoteserverconnector.model.dao.oracle_impl;

import belcer.remoteserverconnector.model.entity.User;

import javax.naming.NamingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public enum OracleConnector {
  INSTANCE,;

  private final static String HOST = "localhost";
  private final static String PORT = "1521";
  private final static String SCHEMA = "xe";
  private final static String URL = "jdbc:oracle:thin:@%1$s:%2$s/%3$s";
  private final static String USER_LOGIN = "system";
  private final static String USER_PASS = "root";
  private Connection conn;

  private static final String usersTable = "users";


  public User getUser(String username) {
    conn = open();
    PreparedStatement ins = null;
    User user = null;
    try {
      ins = conn.prepareStatement("SELECT * FROM " + usersTable + " WHERE username = ?");
      ins.setString(1, username);
      ResultSet resultSet = ins.executeQuery();
      if (!resultSet.isBeforeFirst()) {
        return null;
      }
      resultSet.next();
      user = new User(resultSet.getString(1), resultSet.getString(2), resultSet.getString(3), resultSet.getDate(4), resultSet.getDate(5));
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      close();
    }
    return user;
  }

  public User saveUser(User user) {
    PreparedStatement ins = null;
    try {
      ins = conn.prepareStatement(
          "INSERT INTO " + usersTable + " (username, email, password, registration_date, last_login_date) " +
              "VALUES (?, ?, ?, ?, ?)");
      ins.setString(1, user.getUsername());
      ins.setString(2, user.getEmail());
      ins.setString(3, user.getPassword());
      ins.setDate(4, user.getRegistrationDate());
      ins.setDate(5, user.getLastLogin());
      ins.executeQuery();
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return user;
  }

  OracleConnector() {
    open();
  }

  public Connection open() {
    System.out.println("Oracle DB connection is open");
    try {
      if (conn != null && !conn.isClosed()) {
        conn.close();
      }
    } catch (SQLException e) {
      e.printStackTrace();
    }
    try {
      conn = createConnection();
    } catch (SQLException e) {
      e.printStackTrace();
    } catch (ClassNotFoundException e) {
      e.printStackTrace();
    } catch (NamingException e) {
      e.printStackTrace();
    }
    return conn;
  }

  public Connection createConnection() throws SQLException, ClassNotFoundException, NamingException {
    System.out.println("Oracle DB connection is created");
    DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
    return DriverManager.getConnection(String.format(URL, HOST, PORT, SCHEMA), USER_LOGIN, USER_PASS);
  }

  public void close() {
    try {
      if (conn != null && !conn.isClosed()) {
        conn.close();
      }
    } catch (SQLException e) {
      e.printStackTrace();
    }
    System.out.println("Connection is closed.");
  }

  public List<User> getAllUsers() {
    conn = open();
    PreparedStatement ins = null;
    User user = null;
    List<User> users = new ArrayList<User>();
    try {
      ins = conn.prepareStatement("SELECT * FROM " + usersTable);
      ResultSet resultSet = ins.executeQuery();
      if (!resultSet.isBeforeFirst()) {
        return null;
      }
      while (resultSet.next()) {
//        user = new User(resultSet.getString(1), resultSet.getString(2), resultSet.getString(3), resultSet.getDate(4), resultSet.getDate(5));
        users.add(new User(resultSet.getString(1), resultSet.getString(2), resultSet.getString(3), resultSet.getDate(4), resultSet.getDate(5)));
      }
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      close();
    }
    return users;
  }

//  public UserDAO getUserDAO() {
//
//    // CloudscapeCustomerDAO implements CustomerDAO
//    return new OracleUserDAO();
//  }
//  public PaymentDAO getPaymentDAO() {
//    // CloudscapeAccountDAO implements AccountDAO
//    return new OraclePaymentDAO();
//  }
//  public CardDAO getCardDAO() {
//    // CloudscapeOrderDAO implements OrderDAO
//    return new OracleCardDAO();
//  }


}