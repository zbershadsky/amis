package belcer.remoteserverconnector.model.entity;

import java.sql.Date;

public class User {

  private String username;
  private String email;
  private String password;
  private Date registrationDate;
  private Date lastLogin;
  private Role role;

  public User(String username, String email, String password, Role role) {
    this(username, email, password, new Date(System.currentTimeMillis()), null, role);
  }

  public User(String username, String email, String password, Date registrationDate, Date lastLogin, Role role) {
    this.username = username;
    System.out.println("email = " + email);
    System.out.println("password = " + password);
    this.email = email;
    this.password = password;
    this.registrationDate = registrationDate;
    this.lastLogin = lastLogin;
    this.role = role;
  }


  public Role getRole() {
    return role;
  }

  public void setRole(Role role) {
    this.role = role;
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
