package belcer.remoteserverconnector.model.dao.oracle_impl;

import belcer.remoteserverconnector.model.dao.UserDao;
import belcer.remoteserverconnector.model.entity.User;

import java.util.List;

public class UserDaoImpl implements UserDao {
  OracleConnector connector = OracleConnector.INSTANCE;

  public User get(String username) {
    return connector.getUser(username);
  }

  public List<User> getAll() {
    return connector.getAllUsers();
  }

  public void delete(String username) {

  }

  public User save(User user) {
    return connector.saveUser(user);
  }

  public void update(User user) {

  }
}
