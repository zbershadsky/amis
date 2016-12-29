package belcer.remoteserverconnector.model.dao.oracle_impl;

import belcer.remoteserverconnector.model.entity.ConnectionProfile;
import belcer.remoteserverconnector.model.entity.User;
import org.junit.Test;

import java.util.List;

//-Duser.country=en -Duser.language=en
public class OracleConnectorTest {
  @Test
  public void getAllUsers() throws Exception {
    List<User> allUsers = OracleConnector.INSTANCE.getAllUsers();
    for (User user : allUsers) {
      System.out.println("user = " + user);
    }
  }
  @Test
  public void getAllUsers2() throws Exception {
    String username = "maya";
    User user = OracleConnector.INSTANCE.getUser(username);
    System.out.println("user = " + user);
  }
  @Test
  public void getAllUsers3() throws Exception {
    String username = "dog";
    List<ConnectionProfile> cons = OracleConnector.INSTANCE.getConnections(username);
    System.out.println("cons = " + cons);
  }

}