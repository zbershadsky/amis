package belcer.remoteserverconnector.model.utils;

import org.mindrot.jbcrypt.BCrypt;

public class Utils {

  public static String hashPassword(String password) {
    return BCrypt.hashpw(password, BCrypt.gensalt());
  }

  public static boolean checkPassword(String password, String correctHash) {
    System.out.println("password = " + password);
    System.out.println("correctHash = " + correctHash);
    System.out.println(BCrypt.checkpw(password, correctHash));
    return BCrypt.checkpw(password, correctHash);
  }

}
