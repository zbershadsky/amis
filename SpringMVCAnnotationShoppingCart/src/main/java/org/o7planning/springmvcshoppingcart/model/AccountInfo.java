package org.o7planning.springmvcshoppingcart.model;
 
import javax.persistence.Column;

//import org.o7planning.springmvcshoppingcart.entity.Product;
import org.o7planning.springmvcshoppingcart.entity.Account;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
 
public class AccountInfo {
    private String userName;
    private String password;
    private boolean active;
    private String userRole;
    private boolean newAccount=false;
 
    // Upload file.
   // private CommonsMultipartFile fileData;
 
    public AccountInfo() {
    }
 
    public AccountInfo(Account account) {
        this.userName = account.getUserName();
        this.password = account.getPassword();
        this.active = account.isActive();
        this.userRole = account.getUserRole();

    }
 
    // Không thay đổi Constructor này,
    // nó được sử dụng trong Hibernate query.
    public AccountInfo(String userName, String password, boolean active, String userRole) {
        this.userName = userName;
        this.password = password;
        this.active = active;
        this.userRole = userRole;

    }
    
     public String getUserName() {
        return userName;
    }
 
    public void setUserName(String userName) {
        this.userName = userName;
    }
 
    public String getPassword() {
        return password;
    }
 
    public void setPassword(String password) {
        this.password = password;
    }
 
    public boolean isActive() {
        return active;
    }
 
    public void setActive(boolean active) {
        this.active = active;
    }
    
    public String getUserRole() {
        return userRole;
    }
 
    public void setUserRole(String userRole) {
        this.userRole = userRole;
    }
 
    public boolean isNewAccount() {
        return newAccount;
    }
 
    public void setNewProduct(boolean newAccount) {
        this.newAccount = newAccount;
    }
 
}




