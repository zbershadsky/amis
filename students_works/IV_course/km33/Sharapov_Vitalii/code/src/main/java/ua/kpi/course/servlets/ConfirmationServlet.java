package ua.kpi.course.servlets;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

import static ua.kpi.course.util.ConnectionProperties.*;

@WebServlet(name = "ConfirmationServlet", urlPatterns = "/confirm")
public class ConfirmationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String command = req.getParameter("command");

        switch (command) {
            case "artist":
                try {
                    Class.forName(DRIVER);

                    try (Connection connection = DriverManager.getConnection(URL, LOGIN, PASSWORD)) {
                        CallableStatement statement = connection.prepareCall("{call MANAGEARTIST(?, ?, ?, ?, ?)}");
                        String login = (String) req.getSession().getAttribute("user_login");
                        statement.setString(1, req.getParameter("user_name"));
                        statement.setString(2, login);
                        statement.setInt(3, Integer.parseInt(req.getParameter("art_number")));
                        statement.setInt(4, Integer.parseInt(req.getParameter("art_status")));

                        statement.registerOutParameter(5, Types.VARCHAR);

                        statement.executeQuery();

                        String authorizationStatus = (String) statement.getObject(5);

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
                        CallableStatement statement = connection.prepareCall("{call MANAGERESTAURANT(?, ?, ?, ?, ?)}");
                        String login = (String) req.getSession().getAttribute("user_login");
                        statement.setString(1, req.getParameter("user_name"));
                        statement.setString(2, login);
                        statement.setInt(3, Integer.parseInt(req.getParameter("rest_number")));
                        statement.setInt(4, Integer.parseInt(req.getParameter("rest_status")));

                        statement.registerOutParameter(5, Types.VARCHAR);

                        statement.executeQuery();

                        String authorizationStatus = (String) statement.getObject(5);

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
            case "bill":

                break;
            default:
                getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
                break;
        }

    }

}
