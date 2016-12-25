/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package kursovaia;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.*;

/**
 *
 * @author Надя
 */
public class Kursovaia {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args)  {
        Connection con = null;
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            con = DriverManager.getConnection("jdbc:oracle:thin:@HP.WORKGROUP:1521:nadia", "NadiaAdmin", "Nadia95");
            if (con != null) {
                System.out.println("--------------------------------------------------------------------------");
                System.out.println("Connection is open");
                System.out.println("--------------------------------------------------------------------------");
            }
            Statement s = con.createStatement();
            ResultSet rs = s.executeQuery("select * from gavno");
            if (rs.next()) {
                System.out.print(rs.getString(1) + " ");//ебать я даун, комит забыл сделать
                System.out.print(rs.getString(2) + " ");//ебать я даун, комит забыл сделать
                System.out.print(rs.getString(3));//ura
                System.out.println("");
            }
        } catch (Exception ex) {
            System.out.println("gavno");
        }

    }

}
