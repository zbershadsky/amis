package belcer.remoteserverconnector.model.entity;

import java.sql.Date;

public class User {

  private String username;
  private String email;
  private String password;
  private Date registrationDate;
  private Date lastLogin;
//  private AccountStatus status;

  public User(String username, String email, String password, Date registrationDate, Date lastLogin) {
    this.username = username;
    this.email = email;
    this.password = password;
    this.registrationDate = registrationDate;
    this.lastLogin = lastLogin;
  }

  public String getUsername() {
    return username;
  }

  public void setUsername(String username) {
    this.username = username;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  public Date getRegistrationDate() {
    return registrationDate;
  }

  public void setRegistrationDate(Date registrationDate) {
    this.registrationDate = registrationDate;
  }

  public Date getLastLogin() {
    return lastLogin;
  }

  public void setLastLogin(Date lastLogin) {
    this.lastLogin = lastLogin;
  }

  @Override
  public String toString() {
    return "User{" +
        "username='" + username + '\'' +
        ", email='" + email + '\'' +
        ", password='" + password + '\'' +
        ", registrationDate=" + registrationDate +
        ", lastLogin=" + lastLogin +
        '}';
  }
}
