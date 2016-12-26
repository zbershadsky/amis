package belcer.remoteserverconnector.model.entity;

import java.sql.Date;

public class ConnectionProfile {

  private String title;
  private String host;
  private String port;
  private String connectionUser;
  private String connectionPass;
  private String protocol;
  private User user;
  private Date dateCreated;
  private Date dateModified;
  private Date lastConnectionDate;
  private boolean deleted;

  public ConnectionProfile(String title, String host, String port, String connectionUser, String connectionPass, String protocol, User user) {
    this.title = title;
    this.host = host;
    this.port = port;
    this.connectionUser = connectionUser;
    this.connectionPass = connectionPass;
    this.protocol = protocol;
    this.user = user;
  }

  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public String getHost() {
    return host;
  }

  public void setHost(String host) {
    this.host = host;
  }

  public String getPort() {
    return port;
  }

  public void setPort(String port) {
    this.port = port;
  }

  public String getConnectionUser() {
    return connectionUser;
  }

  public void setConnectionUser(String connectionUser) {
    this.connectionUser = connectionUser;
  }

  public String getConnectionPass() {
    return connectionPass;
  }

  public void setConnectionPass(String connectionPass) {
    this.connectionPass = connectionPass;
  }

  public String getProtocol() {
    return protocol;
  }

  public void setProtocol(String protocol) {
    this.protocol = protocol;
  }

  public User getUser() {
    return user;
  }

  public void setUser(User user) {
    this.user = user;
  }

  public Date getDateCreated() {
    return dateCreated;
  }

  public void setDateCreated(Date dateCreated) {
    this.dateCreated = dateCreated;
  }

  public Date getDateModified() {
    return dateModified;
  }

  public void setDateModified(Date dateModified) {
    this.dateModified = dateModified;
  }

  public Date getLastConnectionDate() {
    return lastConnectionDate;
  }

  public void setLastConnectionDate(Date lastConnectionDate) {
    this.lastConnectionDate = lastConnectionDate;
  }

  public boolean isDeleted() {
    return deleted;
  }

  public void setDeleted(boolean deleted) {
    this.deleted = deleted;
  }
}
