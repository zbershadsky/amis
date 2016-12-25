package belcer.remoteserverconnector.controller;

import belcer.remoteserverconnector.model.FtpConnection;
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
  public TextField connectionHost;
  @FXML
  public TextField connectionPort;
  @FXML
  public TextField connectionUser;
  @FXML
  public TextField connectionPass;
  @FXML
  public TextArea log;
  @FXML
  public TreeTableView localFileList;
  @FXML
  public TreeTableView remoteFileList;

  private Map<String, FtpConnection> connections = new HashMap<String, FtpConnection>();
  private ConnectionsService connectionsService;

  public void newConnection() {
    System.out.println("FrontController.newConnection");
  }

  public void localPathChanged() {

  }
  public void login() {

  }
  public void register() {

  }
  public void logout() {

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
    int port = Integer.valueOf(connectionPort.getText());
    String user = connectionUser.getText();
    String pass = connectionPass.getText();
//    if (title != null && !(title = title.trim()).isEmpty() && connections)
  }
}