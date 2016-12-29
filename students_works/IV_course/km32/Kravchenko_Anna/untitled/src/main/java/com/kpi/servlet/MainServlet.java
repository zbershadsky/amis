package com.kpi.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Ann on 16.12.2016.
 */
@WebServlet("/main")
public class MainServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<String> result = new ArrayList<>();
        try {
            try (Connection connection = ConnectDataBase.connect("java:/comp/env", "jdbc/HRDB").getConnection();
                 Statement statement = connection.createStatement();
                 ResultSet resultSet = statement.executeQuery("Select * from Users")) {

                System.out.println("text");
                while (resultSet.next()) {
                    result.add(resultSet.getString("user_name"));
                    result.add(resultSet.getString("user_pass"));
                    result.add(resultSet.getString("user_mail"));
                    result.add(resultSet.getString("user_status"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        req.setAttribute("result", result);
        req.getRequestDispatcher("mypage.jsp").forward(req, resp);

    }

}