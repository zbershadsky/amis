package ua.kpi.course.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

import static ua.kpi.course.util.ConnectionProperties.*;

@WebServlet(name = "RestorationServlet", urlPatterns = {"/restore"})
public class RestorationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String login = req.getParameter("user_login");
        final String email = req.getParameter("user_email");

        try {
            Class.forName(DRIVER);

            try (Connection connection = DriverManager.getConnection(URL, LOGIN, PASSWORD)) {
                CallableStatement statement = connection.prepareCall("{call RESTOREPASSWORD(?,?,?,?)}");
                statement.setString(1, login);
                statement.setString(2, email);

                statement.registerOutParameter(3, Types.VARCHAR);
                statement.registerOutParameter(4, Types.VARCHAR);

                statement.executeQuery();

                final String restorationStatus = (String) statement.getObject(3);

                if ("ok".equalsIgnoreCase(restorationStatus)) {
                    final String password = (String) statement.getObject(4);
                    req.setAttribute("password", password);
                    getServletContext().getRequestDispatcher("/restoration_complete.jsp").forward(req, resp);
                } else {
                    req.setAttribute("problem", restorationStatus);
                    getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

    }

}
