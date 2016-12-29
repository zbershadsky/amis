package belcer.remoteserverconnector.model.dao;

import belcer.remoteserverconnector.model.entity.ConnectionProfile;

import java.util.List;

public interface ConnectionProfileDao {

  ConnectionProfile get(String title, String username);

  List<ConnectionProfile> getAll();

  void delete(String username, String title);

  void save(ConnectionProfile connection);

  void update(ConnectionProfile connection);

  boolean isConnectionWithSuchTitleAndUserExist(String title, String username);

}
