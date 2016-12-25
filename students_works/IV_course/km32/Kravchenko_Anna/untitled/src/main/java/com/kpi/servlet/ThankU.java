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

/**
 * Created by Ann on 25.12.2016.
 */
@WebServlet("/thankU")
public class ThankU extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
               String kartinochka = req.getParameter("kartinochka");
        String tempName = (String) req.getSession().getAttribute("userName1");

        try (Connection connection = ConnectDataBase.connect("java:/comp/env", "jdbc/HRDB").getConnection();
             CallableStatement statement = connection.prepareCall("{call SENDKARTINOCHKA(?,?,?)}")) {
            statement.setString(1, tempName);
            statement.setString(2, kartinochka);

            statement.registerOutParameter(3, Types.VARCHAR);

            statement.executeQuery();

            final String registrationStatus = (String) statement.getObject(3);

            String srt = "Thank you!";
                            req.setAttribute("ans", srt);
                getServletContext().getRequestDispatcher("/mypage.jsp").forward(req, resp);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

