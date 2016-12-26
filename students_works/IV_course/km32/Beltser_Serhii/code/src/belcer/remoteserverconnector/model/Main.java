package belcer.remoteserverconnector.model;

import belcer.remoteserverconnector.controller.FrontController;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.util.Scanner;

//-Duser.country=en -Duser.language=en
public class Main extends Application {

  public static final boolean DEBUG_MODE = true;
  public static final Scanner SCANNER = new Scanner(System.in);
  public static Stage stage;
  public static FrontController controller;

  @Override
  public void start(Stage primaryStage) throws Exception {
    String v1 = "/fxml/main.fxml";//-
    Parent root = FXMLLoader.load(Main.class.getResource(v1));
    primaryStage.setTitle("Main window");
    primaryStage.setScene(new Scene(root));
    primaryStage.show();
    stage = primaryStage;
//    controller = (FrontController) fxmlLoader.getController();

//    User user = new User("Milena", "milena@gmail.com", "secret", new Date(System.currentTimeMillis()), new Date(System.currentTimeMillis()));
//    User save = userDao.save(user);
//    System.out.println("save = " + save);
//    List<User> all = userDao.getAll();
//    all.forEach(System.out::println);
//    System.out.println("get = " + get);
  }

  public static void main(String[] args) {
    launch(args);
  }
}
