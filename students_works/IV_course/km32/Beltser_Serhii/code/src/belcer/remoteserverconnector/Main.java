package belcer.remoteserverconnector;

import belcer.remoteserverconnector.controller.AppWindows;
import belcer.remoteserverconnector.controller.CmpController;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;
import javafx.stage.StageStyle;

import java.io.IOException;
import java.util.Scanner;

//-Duser.country=en -Duser.language=en
public class Main extends Application {
  public static Main INSTANCE;

  public static final boolean DEBUG_MODE = true;
  public static final Scanner SCANNER = new Scanner(System.in);

  private static final String MAIN_WINDOW_TITLE = "Main window";
  private static final String MAIN_WINDOW_RESOURCE = "/fxml/main.fxml";
  private Stage mainStage;
  private Stage stage;
  private FXMLLoader loader;

  @Override
  public void start(Stage primaryStage) throws Exception {
    INSTANCE = this;
    loader = new FXMLLoader();
    mainStage = primaryStage;
    mainStage.setTitle(MAIN_WINDOW_TITLE);
    mainStage.setScene(new Scene(initWindow(MAIN_WINDOW_RESOURCE)));
    mainStage.show();
  }

  public static void main(String[] args) {
    launch(args);
  }

  public void setStage(AppWindows window, Object... args) {
    String rootResource = null;
    String title = null;
    switch (window) {
      case MAIN:
        rootResource = "/fxml/main.fxml";
        title = "Main window";
//        if (args.length != 0 && args[0] instanceof User) {
//
//        }
        break;
      case SIGNUP:
        rootResource = "/fxml/signup.fxml";
        title = "Registration";
        break;
      case LOGIN:
        rootResource = "/fxml/login.fxml";
        title = "Login";
        break;
      case CREATE_CONNECTION:
        rootResource = "/fxml/cmp.fxml";
        title = "Create new connection";
        break;
    }

    if (rootResource == null) {
      throw new IllegalArgumentException("Wrong window");
    } else if (title == null) {
      throw new IllegalArgumentException("Wrong window title");
    } else {
      if (rootResource.equals("/fxml/main.fxml")) {
        mainStage.setTitle(title);
        mainStage.setScene(new Scene(initWindow(rootResource)));
        mainStage.show();
      } else {
        if (stage != null && stage.isShowing()) {
          stage.close();
        }
        stage = new Stage(StageStyle.DECORATED);
        stage.setTitle(title);
        System.out.println("rootResource = " + rootResource);
        stage.setScene(new Scene(initWindow(rootResource)));
        stage.show();
        if(window == AppWindows.CREATE_CONNECTION) {
          Object controller = loader.getController();
          if (controller instanceof CmpController) {
            ((CmpController)controller).init();
          }
        }

      }
    }
  }

  public Parent initWindow(String resource) {
    try {
      loader = new FXMLLoader();
      System.out.println("loader.getLocation() = " + loader.getLocation());
      loader.setLocation(Main.class.getResource(resource));
      System.out.println("loader.getLocation() = " + loader.getLocation());
      return loader.load();
    } catch (IOException e) {
      e.printStackTrace();
    }
    return null;
  }

  public void closeAdditionalWindow() {
    stage.close();
  }
}
