package com.kpi.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;

/**
 * Created by Ann on 16.12.2016.
 */
@WebServlet("/login")
public class Login extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("login.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String passWord = req.getParameter("pass");
        String userName = req.getParameter("userName");

        try (Connection connection = ConnectDataBase.connect("java:/comp/env", "jdbc/HRDB").getConnection();
             CallableStatement statement = connection.prepareCall("{call AUTHORIZEUSER(?,?,?,?,?)}")) {
            statement.setString(1, userName);
            statement.setString(2, passWord);

            statement.registerOutParameter(3, Types.VARCHAR);
            statement.registerOutParameter(4, Types.VARCHAR);
            statement.registerOutParameter(5, Types.VARCHAR);

            statement.executeQuery();

            final String authorizationStatus = (String) statement.getObject(3);
            final boolean isBanned =  ((String) statement.getObject(4)).equals("1");
            final boolean isAdmin =  ((String) statement.getObject(5)).equals("1");

            if ("ok".equalsIgnoreCase(authorizationStatus)) {

                System.out.println(isBanned);
                System.out.println(isAdmin);

                if (isBanned) {
                    req.setAttribute("problem", authorizationStatus);
                    getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
                } if (isAdmin) {
                    getServletContext().getRequestDispatcher("/adminpage.jsp").forward(req, resp);
                }
                req.getSession().setAttribute("userName1", userName);
                getServletContext().getRequestDispatcher("/mypage.jsp").forward(req, resp);
            } else {
                req.setAttribute("problem", authorizationStatus);
                getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}