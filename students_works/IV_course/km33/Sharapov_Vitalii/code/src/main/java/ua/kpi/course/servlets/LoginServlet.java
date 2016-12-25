package ua.kpi.course.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static ua.kpi.course.util.ConnectionProperties.*;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String command = req.getParameter("command");
        switch (command) {
            case "login":
                try {
                    Class.forName(DRIVER);

                    try (Connection connection = DriverManager.getConnection(URL, LOGIN, PASSWORD)) {
                        CallableStatement statement = connection.prepareCall("{call authorizeuser(?, ?, ?, ?)}");
                        String login = req.getParameter("user_login");
                        String password = req.getParameter("user_password");

                        statement.setString(1, login);
                        statement.setString(2, password);

                        statement.registerOutParameter(3, Types.VARCHAR);
                        statement.registerOutParameter(4, Types.INTEGER);

                        statement.executeQuery();

                        String authorizationStatus = (String) statement.getObject(3);
                        boolean isManager = (int) statement.getObject(4) != 0;

                        if ("ok".equalsIgnoreCase(authorizationStatus)) {
                            HttpSession session = req.getSession();
                            session.setAttribute("user_login", login);
                            session.setAttribute("user_is_manager", isManager);
                            getServletContext().getRequestDispatcher("/about.jsp").forward(req, resp);
                        } else {
                            req.setAttribute("problem", authorizationStatus);
                            getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
                        }

                        statement.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                }
                break;
            case "logout":
                req.getSession().invalidate();
                getServletContext().getRequestDispatcher("/login.jsp").forward(req, resp);
                break;
            default:
                getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
                break;
        }
    }

}
