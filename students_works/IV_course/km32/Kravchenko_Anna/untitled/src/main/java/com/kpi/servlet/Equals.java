package com.kpi.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;

import static com.sun.xml.internal.bind.v2.schemagen.Util.equal;

/**
 * Created by Ann on 20.12.2016.
 */
@WebServlet("/equals")
public class Equals extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("mypage.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String oldPassWord = req.getParameter("old_pass");
        String newPassWord = req.getParameter("new_pass");
        String newPassAgain = req.getParameter("new_pass2");
        if (!equal(newPassWord, newPassAgain)) {
            String mess = "Passw are njt equels!";
            req.setAttribute("problem", mess);
            getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);


        } else {

            try (Connection connection = ConnectDataBase.connect("java:/comp/env", "jdbc/HRDB").getConnection();
                 CallableStatement statement = connection.prepareCall("{call NEWPASSWORD (?,?,?,?,?)}")) {
                String tempName = (String) req.getSession().getAttribute("userName1");
                statement.setString(1, tempName);
                statement.setString(2, oldPassWord);
                statement.setString(3, newPassAgain);


                statement.registerOutParameter(4, Types.VARCHAR);
                statement.registerOutParameter(5, Types.VARCHAR);

                statement.executeQuery();

                final String changePassStatus = (String) statement.getObject(4);
                if ("ok".equalsIgnoreCase(changePassStatus)) {

                    req.getSession().setAttribute("status", changePassStatus);
                    getServletContext().getRequestDispatcher("/index.jsp").forward(req, resp);
                } else {
                    req.setAttribute("problem", changePassStatus);
                    getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}