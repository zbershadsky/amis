package belcer.remoteserverconnector.model.entity;

import org.junit.Assert;
import org.mindrot.jbcrypt.BCrypt;

public class UserTest {
  public static void main(String[] args) {
    new UserTest().launch();
  }

  private void launch() {
    hashPassword();
  }

  private void hashPassword() {
    String password = "secretpass";
    User user = new User("test_username", "test_email", password, Role.USER);
    String hashed = user.getPassword();
    Assert.assertTrue(BCrypt.checkpw(password, hashed));
    System.out.println("assert true: " + BCrypt.checkpw(password, hashed));
  }
  private void hashPassword2() {
    String password = "catcat";
//    User user = new User("test_username", "test_email", password, Role.USER);
    String hashed = "$2a$10$OehVtNJQTfknuSRpjW4p3upGHChZIWKy4g0d6KJFJjsocIISzBkZm";
    Assert.assertTrue(BCrypt.checkpw(password, hashed));
    System.out.println("assert true: " + BCrypt.checkpw(password, hashed));
  }
}