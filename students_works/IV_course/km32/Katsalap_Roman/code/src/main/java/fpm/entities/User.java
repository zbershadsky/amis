package fpm.entities;

public class User {

    private String login;
    private String email;
    private String hash;
    private String salt;
    private Status status;

    public User() {

    }

    public User(String login,String email,String hash, String salt, Status status) {
        this.email=email;
        this.login=login;
        this.status = status;
        this.salt = salt;
        this.hash = hash;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getHash() {
        return hash;
    }
    public String getLogin() {
        return login;
    }
    public Status getStatus() {
        return status;
    }
    public void setPassword(String password) {
        this.hash = password;
    }
    public String getSalt() {return salt;}
}
