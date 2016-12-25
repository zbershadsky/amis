package ua.kpi.course.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

import static ua.kpi.course.util.ConnectionProperties.*;
import static ua.kpi.course.util.UtilDao.retrieveArtists;
import static ua.kpi.course.util.UtilDao.retrieveRestaurants;

@WebServlet(name = "CeremonySwitchServlet", urlPatterns = "/ceremony_switch")
public class CeremonySwitchServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String userLogin = (String) req.getSession().getAttribute("user_login");
        try {
            Class.forName(DRIVER);

            try (Connection connection = DriverManager.getConnection(URL, LOGIN, PASSWORD)) {
                PreparedStatement statement = connection.prepareStatement(
                        "SELECT c_date FROM ceremonyDates WHERE u_name = '" + userLogin + "'");
                statement.executeQuery();

                ResultSet resultSet = statement.getResultSet();

                if (resultSet.next()) {
                    getServletContext().getRequestDispatcher("/ceremony_info").forward(req, resp);
                } else {
                    retrieveRestaurants(req, connection);
                    retrieveArtists(req, connection);

                    getServletContext().getRequestDispatcher("/new_ceremony.jsp").forward(req, resp);
                }
            } catch (SQLException e) {
                getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
            e.printStackTrace();
        }
    }

}
