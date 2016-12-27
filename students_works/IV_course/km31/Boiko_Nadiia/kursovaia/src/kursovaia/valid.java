/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package kursovaia;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author Надя
 */
public class valid {
    
    public static boolean checkFIO(String name){  
        Pattern p = Pattern.compile("^[а-яА-Я-]{3,40}$");  
        Matcher m = p.matcher(name);  
        return m.matches();  
    }  
    
    public static boolean checkGroup(String groupn){  
        Pattern p = Pattern.compile("^[а-яА-Я]{2}[-]{1}[0-9]{2}$");  
        Matcher m = p.matcher(groupn);  
        return m.matches();  
    }  
    
    public static boolean checkPBook(String pbookn){  
        Pattern p = Pattern.compile("^[а-яА-Я]{2}[0-9]{4}$");  
        Matcher m = p.matcher(pbookn);  
        return m.matches();  
    }  
    
    public static boolean checkWBook(String pbookn){  
        Pattern p = Pattern.compile("^[а-яА-Я]{2}[0-9]{6}$");  
        Matcher m = p.matcher(pbookn);  
        return m.matches();  
    } 
    
    public static boolean checkLogin(String login){  
        Pattern p = Pattern.compile("^[a-zA-Z0-9_-]{3,15}$");  
        Matcher m = p.matcher(login);  
        return m.matches();  
    }  
    
}
