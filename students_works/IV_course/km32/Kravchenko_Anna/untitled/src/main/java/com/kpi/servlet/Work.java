package com.kpi.servlet;

import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Ann on 25.12.2016.
 */
@WebServlet("/work")
public class Work extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<String> result1 = new ArrayList<>();
        List<String> result2 = new ArrayList<>();
        List<String> result3 = new ArrayList<>();
        List<String> result4 = new ArrayList<>();

        try {
            try (Connection connection = ConnectDataBase.connect("java:/comp/env", "jdbc/HRDB").getConnection();
                 Statement statement = connection.createStatement();
                 ResultSet resultSet1 = statement.executeQuery("Select u_name from a_work")) {

                while (resultSet1.next()) {
                    result1.add(resultSet1.getString("u_name"));
                }
            }
        } catch (SQLException f) {
            f.printStackTrace();}
/*second element*/
            try {
                try (Connection connection = ConnectDataBase.connect("java:/comp/env", "jdbc/HRDB").getConnection();
                     Statement statement = connection.createStatement();
                     ResultSet resultSet2 = statement.executeQuery("Select u_status from a_work")) {

                    while (resultSet2.next()) {
                        result2.add(resultSet2.getString("u_status"));
                    }
                }
            } catch (SQLException s) {
                s.printStackTrace();}
/*third element*/

        try {
            try (Connection connection = ConnectDataBase.connect("java:/comp/env", "jdbc/HRDB").getConnection();
                 Statement statement = connection.createStatement();
                 ResultSet resultSet3 = statement.executeQuery("Select u_pass from a_work")) {

                while (resultSet3.next()) {
                    result3.add(resultSet3.getString("u_pass"));
                }
            }
        } catch (SQLException t) {
            t.printStackTrace();}

        try {
            try (Connection connection = ConnectDataBase.connect("java:/comp/env", "jdbc/HRDB").getConnection();
                 Statement statement = connection.createStatement();
                 ResultSet resultSet4 = statement.executeQuery("Select u_mail from a_work")) {

                while (resultSet4.next()) {
                    result4.add(resultSet4.getString("u_mail"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();}

        System.out.println(result1);
        System.out.println(result2);
        System.out.println(result3);
        System.out.println(result4);
        req.setAttribute("result1", result1);
        req.setAttribute("result2", result2);
        req.setAttribute("result3", result3);
        req.setAttribute("result4", result4);
        req.getRequestDispatcher("a_work.jsp").forward(req, resp);

    }

}