package com.kpi.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

/**
 * Created by Ann on 25.12.2016.
 */
@WebServlet("/a_work_status")
public class Work_status extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String NAME = req.getParameter("userName");
        String STATUS = req.getParameter("status");
        try (Connection connection = ConnectDataBase.connect("java:/comp/env", "jdbc/HRDB").getConnection();
             CallableStatement statement = connection.prepareCall("{call UPDATETABLE (?,?,?)}")) {
            /*String tempName = (String) req.getSession().getAttribute("userName1");
            */
            statement.setString(1, NAME);
            statement.setString(2, STATUS);

            statement.registerOutParameter(3, Types.VARCHAR);

            statement.executeQuery();

            final String changePassStatus = (String) statement.getObject(3);
            if ("ok".equalsIgnoreCase(changePassStatus)) {

                String ans = "Update successfully";
                req.getSession().setAttribute("a_ststus", ans);
                getServletContext().getRequestDispatcher("/adminpage.jsp").forward(req, resp);
            }
            else {
                String ans = "User not found";
                req.getSession().setAttribute("a_ststus", ans);
                getServletContext().getRequestDispatcher("/adminpage.jsp").forward(req, resp);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
