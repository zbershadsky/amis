package com.devcolibri.servlet;

import database.DBWorker;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.ResultSet;

/**
 * Created by DELL on 25.12.2016.
 */

@WebServlet("/blank")
public class Blank extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        String role = null;
        String column1= request.getParameter("column1");
        String column2= request.getParameter("column2");
        String column3 = request.getParameter("column3");
        String column4 = request.getParameter("column4");
        String column5 = request.getParameter("column5");
        String column6 = request.getParameter("column6");
        String column7 = request.getParameter("column7");
        String column8 = request.getParameter("column8");
        String column9 = request.getParameter("column9");
        String column10 = request.getParameter("column10");
        String column11 = request.getParameter("column11");
        String column12 = request.getParameter("column12");
        String column13 = request.getParameter("column13");
        String column14 = request.getParameter("column14");
        String column15 = request.getParameter("column15");
        String column16 = request.getParameter("column16");
        String column17 = request.getParameter("column17");

        DBWorker dbWorker = new DBWorker();
        String query = "INSERT INTO DIVORCE(COLUMN1, COLUMN2, COLUMN3, COLUMN4" +
                ", COLUMN5, COLUMN6, COLUMN7, COLUMN8, COLUMN9, COLUMN10, COLUMN11" +
                ", COLUMN12, COLUMN13, COLUMN14, COLUMN15, COLUMN16, COLUMN17) " +
                "VALUES('"+ column1 +"','"+column2+"',"+column3+","+column4 +
                ",'"+column5+"','"+column6+"','"+column7+"','"+column8+"','"+column9+"'" +
                ",'"+column10+"','"+column11+"','"+column12+"','"+column13+"','"+column14+"'" +
                ","+column15+","+column16+",'"+column17+"')";

//        String query = "Select PASS, ROLE from USERS where email = '" + email + "'";
        ResultSet resultSet = dbWorker.executeQuery(query);
        RequestDispatcher dispatcher = request.getRequestDispatcher("mypayment.jsp");
        try {
            dispatcher.forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        new DBWorker().blank(request, response, "mypayment");
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");

        RequestDispatcher dispatcher = request.getRequestDispatcher("pages/login.jsp");
        dispatcher.forward(request, response);
    }
}

