package org.o7planning.springmvcshoppingcart.dao;
 
import org.o7planning.springmvcshoppingcart.entity.Account;
import org.o7planning.springmvcshoppingcart.model.PaginationResult;
import org.o7planning.springmvcshoppingcart.model.AccountInfo;
 
public interface AccountDAO {
 
    
    public Account findAccount(String userName );
    
    public AccountInfo findAccountInfo(String userName) ;
    
    public void saveUser(String username, String password) ;
  
    
   public  void save(AccountInfo accountInfo) ;
	

 
    
}