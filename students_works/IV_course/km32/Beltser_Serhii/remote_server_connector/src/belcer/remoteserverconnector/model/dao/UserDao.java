package belcer.remoteserverconnector.model.dao;

import belcer.remoteserverconnector.model.entity.User;

import java.util.List;

public interface UserDao {
  User get(String username);

  List<User> getAll();

  void delete(String username);

  User save(User user);

  void update(User user);
}
