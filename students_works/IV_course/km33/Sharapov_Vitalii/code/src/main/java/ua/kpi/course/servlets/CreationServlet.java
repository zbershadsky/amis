package ua.kpi.course.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

import static ua.kpi.course.util.ConnectionProperties.*;

@WebServlet(name = "CreationServlet", urlPatterns = "/create")
public class CreationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String command = req.getParameter("command");

        switch (command) {
            case "artist":
                try {
                    Class.forName(DRIVER);

                    try (Connection connection = DriverManager.getConnection(URL, LOGIN, PASSWORD)) {
                        CallableStatement statement = connection.prepareCall("{call UPDATEARTIST(?, ?, ?, ?, ?, ?)}");
                        String login = (String) req.getSession().getAttribute("user_login");
                        statement.setString(1, login);
                        statement.setString(2, req.getParameter("new_name"));
                        statement.setString(3, req.getParameter("new_email"));
                        statement.setString(4, req.getParameter("new_other"));
                        statement.setString(5, req.getParameter("new_price"));

                        statement.registerOutParameter(6, Types.VARCHAR);

                        statement.executeQuery();

                        String authorizationStatus = (String) statement.getObject(6);

                        if ("ok".equalsIgnoreCase(authorizationStatus)) {
                            getServletContext().getRequestDispatcher("/ceremony_info").forward(req, resp);
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
            case "restaurant":
                try {
                    Class.forName(DRIVER);

                    try (Connection connection = DriverManager.getConnection(URL, LOGIN, PASSWORD)) {
                        CallableStatement statement = connection.prepareCall("{call UPDATErestaurants(?, ?, ?, ?, ?, ?)}");
                        String login = (String) req.getSession().getAttribute("user_login");
                        statement.setString(1, login);
                        statement.setString(2, req.getParameter("new_name"));
                        statement.setString(3, req.getParameter("new_email"));
                        statement.setString(4, req.getParameter("new_other"));
                        statement.setString(5, req.getParameter("new_price"));

                        statement.registerOutParameter(6, Types.VARCHAR);

                        statement.executeQuery();

                        String authorizationStatus = (String) statement.getObject(6);

                        if ("ok".equalsIgnoreCase(authorizationStatus)) {
                            getServletContext().getRequestDispatcher("/ceremony_info").forward(req, resp);
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
            default:
                getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
                break;
        }
    }

}
