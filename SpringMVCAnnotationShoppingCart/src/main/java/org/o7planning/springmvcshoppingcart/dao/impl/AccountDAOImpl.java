package org.o7planning.springmvcshoppingcart.dao.impl;
 
import java.util.Date;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.o7planning.springmvcshoppingcart.dao.AccountDAO;
import org.o7planning.springmvcshoppingcart.dao.impl.AccountDAOImpl;
import org.o7planning.springmvcshoppingcart.entity.Account;
import org.o7planning.springmvcshoppingcart.entity.Product;
import org.o7planning.springmvcshoppingcart.model.ProductInfo;
import org.o7planning.springmvcshoppingcart.model.AccountInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
 
// Transactional for Hibernate
@Transactional
public class AccountDAOImpl implements AccountDAO {
    
    @Autowired
    private SessionFactory sessionFactory;
 
    @Override
    public Account findAccount(String userName ) {
        Session session = sessionFactory.getCurrentSession();
        Criteria crit = session.createCriteria(Account.class);
        crit.add(Restrictions.eq("userName", userName));
        return (Account) crit.uniqueResult();
    }
 
   
    @Override
    public AccountInfo findAccountInfo(String userName) {
        Account account = this.findAccount(userName);
        if (account == null) {
            return null;
        }
        return new AccountInfo(account.getUserName(), account.getPassword(),account.isActive(), account.getUserRole());
    }
 

    @Override
    public void save(AccountInfo accountInfo) {
	    String userName = accountInfo.getUserName();
	    String userRole = "USER";
	    boolean active = true;
	    Account account = null;
	
	    boolean isNew = false;
	    if (userName != null) {
	        account = this.findAccount(userName);
	    }
	    if (account == null) {
	        isNew = true;
	        account = new Account();
	        //account.setCreateDate(new Date());
	    }
	    account.setUserName(userName);
	    account.setPassword(accountInfo.getPassword());
	    account.setActive(true);
	    account.setUserRole(userRole);
	
	    
	    if (isNew) {
	        this.sessionFactory.getCurrentSession().persist(account);
	    }
	    // If error in DB, Exceptions will be thrown out immediately
	    this.sessionFactory.getCurrentSession().flush();
    }
    @Override
    public void saveUser(String username, String password) {
        String sql = "INSERT INTO ACCOUNTS (USER_NAME, ACTIVE, PASSWORD, USER_ROLE) VALUES (:username, 1, :password, 'USER')";
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createSQLQuery(sql);
        try {
        	 query.setParameter("username", username);
        	 query.setParameter("password", password);
        	 query.executeUpdate();
        } catch (Exception e) {
        	System.out.print(e.getMessage());
        }
    }
}