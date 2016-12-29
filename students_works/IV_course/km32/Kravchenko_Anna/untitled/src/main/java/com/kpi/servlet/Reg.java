package com.kpi.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

/**
 * Created by Ann on 20.12.2016.
 */
@WebServlet("/reg")
public class Reg extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("reg.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userName = req.getParameter("userName");
        String passWord = req.getParameter("pass");
        String email = req.getParameter("email");

        try (Connection connection = ConnectDataBase.connect("java:/comp/env", "jdbc/HRDB").getConnection();
             CallableStatement statement = connection.prepareCall("{call REGISTERNEWUSER(?,?,?,?)}")) {
            statement.setString(1, userName);
            statement.setString(2, passWord);
            statement.setString(3, email);

            statement.registerOutParameter(4, Types.VARCHAR);

            statement.executeQuery();

            final String registrationStatus = (String) statement.getObject(4);

            if ("ok".equalsIgnoreCase(registrationStatus)) {
                req.getSession().setAttribute("userName1", userName);
                getServletContext().getRequestDispatcher("/mypage.jsp").forward(req, resp);
            } else {
                req.setAttribute("problem", registrationStatus);
                getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}