package ua.kpi.course.servlets;

import ua.kpi.course.util.ConnectionProperties;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

import static ua.kpi.course.util.ConnectionProperties.*;

@WebServlet(name = "RegistrationServlet", urlPatterns = {"/registration"})
public class RegistrationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String login = req.getParameter("user_login");
        final String password = req.getParameter("user_password");
        final String secondPassword = req.getParameter("user_password_2");
        final String email = req.getParameter("user_email");

        if (password.equals(secondPassword)) {
            try {
                Class.forName(ConnectionProperties.DRIVER);

                try (Connection connection = DriverManager.getConnection(URL, LOGIN, PASSWORD)) {
                    CallableStatement statement = connection.prepareCall("{call REGISTERNEWUSER(?,?,?,?)}");
                    statement.setString(1, login);
                    statement.setString(2, password);
                    statement.setString(3, email);

                    statement.registerOutParameter(4, Types.VARCHAR);

                    statement.executeQuery();

                    final String registrationStatus = (String) statement.getObject(4);

                    if ("ok".equalsIgnoreCase(registrationStatus)) {
                        getServletContext().getRequestDispatcher("/login.jsp").forward(req, resp);
                    } else {
                        req.setAttribute("problem", registrationStatus);
                        getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
                }
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
                getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
            }
        } else {
            req.setAttribute("problem", "password does not match");
            getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }

}
