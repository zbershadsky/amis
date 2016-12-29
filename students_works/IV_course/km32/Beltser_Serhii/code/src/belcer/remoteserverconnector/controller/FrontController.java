package belcer.remoteserverconnector.controller;

import belcer.remoteserverconnector.Main;
import belcer.remoteserverconnector.model.entity.ConnectionProfile;
import belcer.remoteserverconnector.model.entity.User;
import belcer.remoteserverconnector.model.service.ConnectionsService;
import javafx.fxml.FXML;
import javafx.scene.control.TextArea;
import javafx.scene.control.TextField;
import javafx.scene.control.TreeTableView;

import java.util.HashMap;
import java.util.Map;

public class FrontController {
  @FXML
  private TextField connectionTitle;
  @FXML
  private TextField connectionHost;
  @FXML
  private TextField connectionPort;
  @FXML
  private TextField connectionUser;
  @FXML
  private TextField connectionPass;
  @FXML
  private TextField connectionProtocol;

  @FXML
  private TextArea log;
  @FXML
  private TreeTableView localFileList;
  @FXML
  private TreeTableView remoteFileList;

  private static User user;
  //todo: not ConnectionProfile!
  private Map<String, ConnectionProfile> connections = new HashMap<>();
  private ConnectionsService connectionsService;

  public void newConnection() {
    System.out.println("FrontController.newConnection");
  }

  public void localPathChanged() {

  }

  public void login() {
    Main.INSTANCE.setStage(AppWindows.LOGIN);
//    System.out.println("FrontController.login");
//    System.out.println("before. user = " + user);
//    user = new User("test", "test", "test", new Date(System.currentTimeMillis()), new Date(System.currentTimeMillis()), Role.USER);
//    System.out.println("after. user = " + user);
  }

  public void register() {
    Main.INSTANCE.setStage(AppWindows.SIGNUP);
  }

  public void logout() {
    setUser(null);
  }

  public void closeConnection() {

  }

  public void updateLocalPath() {

  }

  public void updateRemotePath() {

  }

  private void addConnection() {
    String title = connectionTitle.getText();
    String host = connectionHost.getText();
    String port = connectionPort.getText();
    String connUser = connectionUser.getText();
    String connPass = connectionPass.getText();
    String protocol = connectionProtocol.getText();
    //todo: not ConnectionProfile!
    connections.put(title, new ConnectionProfile(title, host, port, connUser, connPass, protocol, user));
//    if (title != null && !(title = title.trim()).isEmpty() && connections)
  }

  public static void setUser(User user) {
    System.out.println("==========");
    System.out.println("User is changed: " + user);
    FrontController.user = user;
  }
}