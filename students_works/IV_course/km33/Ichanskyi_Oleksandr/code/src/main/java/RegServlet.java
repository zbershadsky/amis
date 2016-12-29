/*
import Databases.SQLiteClass;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

*/
/**
 * Created by Sascha on 19.12.2016.
 *//*

@WebServlet(name = "RegServlet")
public class RegServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String command = request.getParameter("command");



        System.out.println("1");
        Object kode_reg_obj = request.getParameter("kode_logIn");
        Object password_reg_obj = request.getParameter("pass_logIn");
        String kode_reg = (String) kode_reg_obj;
        String password_reg = (String) password_reg_obj;
        System.out.println("2");
        System.out.println(kode_reg);

        if (("1111").equals(kode_reg)&&("admin").equals(password_reg)) {
            System.out.println("22");
            HttpSession session = request.getSession();
            session.setAttribute("user", kode_reg);
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter printWriter = response.getWriter();
            System.out.println("3");
            response.sendRedirect("admin.jsp");
            System.out.println("finish admin");
        }
        try {
            if (kode_reg != null&password_reg!=null&&true == GetRegistrationUser(kode_reg, password_reg)){
             HttpSession session = request.getSession();
             session.setAttribute("user", kode_reg);
              response.sendRedirect("index.jsp");
              System.out.println("finish");
              }else {
              response.sendRedirect("error_logIn.html");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        Object exit_obj = request.getParameter("exit");
        String exit_str = (String) exit_obj;
        if ("exit".equals(exit_str)) {
            System.out.println("exxiiitttt");
            request.getSession().invalidate();
        }

    }
    private Boolean GetRegistrationUser(String kode_reg, String password_reg) throws SQLException {
        System.out.println("step1");
        System.out.println(kode_reg);
        System.out.println(password_reg);
        Statement statement = SQLiteClass.getDBConnection().createStatement();
        ResultSet rs = statement.executeQuery("SELECT CUST_NALOGCODE, CUST_PASS FROM ICHANSKIYOLEXANDR.CUSTOMERS");
        System.out.println("step2");
        Boolean a = null;

        while (rs.next()) {
            String nalogcode =  rs.getString("CUST_NALOGCODE");
            String cust_pass = rs.getString("CUST_PASS");
            if (kode_reg.equals(nalogcode) && password_reg.equals(cust_pass)) {
                 a = true;
                 break;
            } else {
                 a = false;
            }
        }rs.close();
        System.out.println("step3");
        System.out.println(a);
        return a;
    }
    String html_welcome_admin = "<!DOCTYPE html>\n" +
            "<html lang=\"en\">\n" +
            "<head>\n" +
            "    <meta charset=\"UTF-8\">\n" +
            "    <title>Title</title>\n" +
            "</head>\n" +
            "<body>\n" +
            "heeeloooooooooooo\n" +
            "</body>\n" +
            "</html>";
    }

*/
