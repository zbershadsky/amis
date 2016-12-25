package ua.kpi.course.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

import static ua.kpi.course.util.ConnectionProperties.*;

@WebServlet(name = "AssignmentServlet", urlPatterns = "/assign")
public class AssignmentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Class.forName(DRIVER);

            try (Connection connection = DriverManager.getConnection(URL, LOGIN, PASSWORD)) {
                CallableStatement statement = connection.prepareCall("{call ASSIGNTOUSER(?, ?, ?)}");
                String userName = req.getParameter("assign_to");
                String managerName = (String) req.getSession().getAttribute("user_login");

                statement.setString(1, userName);
                statement.setString(2, managerName);

                statement.registerOutParameter(3, Types.VARCHAR);

                statement.executeQuery();

                String promotionStatus = (String) statement.getObject(3);

                if ("ok".equalsIgnoreCase(promotionStatus)) {
                    getServletContext().getRequestDispatcher("/ceremony_info").forward(req, resp);
                } else {
                    req.setAttribute("problem", promotionStatus);
                    getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
                }

                statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

}
