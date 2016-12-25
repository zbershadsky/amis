package ua.kpi.course.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

import static ua.kpi.course.util.ConnectionProperties.*;

@WebServlet(name = "NewCeremonyServlet", urlPatterns = {"/new_ceremony"})
public class NewCeremonyServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        final String userLogin = (String) session.getAttribute("user_login");
        try {
            Class.forName(DRIVER);

            try (Connection connection = DriverManager.getConnection(URL, LOGIN, PASSWORD);
                 CallableStatement statement = connection.prepareCall("{call CHANGECEREMONYDATE(?,?,?)}")) {
                loadCeremonyDate(req, resp, userLogin, connection, statement);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    private void loadCeremonyDate(HttpServletRequest req, HttpServletResponse resp, String userLogin, Connection connection, CallableStatement statement) throws SQLException, ServletException, IOException {
        statement.setString(1, userLogin);
        statement.setDate(2, Date.valueOf(req.getParameter("cer_date")));

        statement.registerOutParameter(3, Types.VARCHAR);

        statement.executeQuery();

        final String ceremonyDateStatus = (String) statement.getObject(3);

        if ("ok".equals(ceremonyDateStatus)) {
            loadRestaurant(req, resp, userLogin, connection);
        } else {
            req.setAttribute("problem", ceremonyDateStatus);
            getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }

    private void loadRestaurant(HttpServletRequest req, HttpServletResponse resp, String userLogin, Connection connection) throws SQLException, ServletException, IOException {
        CallableStatement restaurantStatement = connection.prepareCall("{CALL CHANGERESTAURANT(?,?,?)}");
        restaurantStatement.setString(1, userLogin);
        restaurantStatement.setString(2, req.getParameter("rest_number"));

        restaurantStatement.registerOutParameter(3, Types.VARCHAR);

        restaurantStatement.executeQuery();

        final String restaurantStatus = (String) restaurantStatement.getObject(3);

        if ("ok".equals(restaurantStatus)) {
            restaurantStatement.close();
            loadArtist(req, resp, userLogin, connection);
        } else {
            restaurantStatement.close();
            req.setAttribute("problem", restaurantStatus);
            getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }

    private void loadArtist(HttpServletRequest req, HttpServletResponse resp, String userLogin, Connection connection) throws SQLException, ServletException, IOException {
        CallableStatement artistStatement = connection.prepareCall("{CALL CHANGEARTIST(?,?,?)}");
        artistStatement.setString(1, userLogin);
        artistStatement.setString(2, req.getParameter("art_number"));

        artistStatement.registerOutParameter(3, Types.VARCHAR);

        artistStatement.executeQuery();

        final String artistStatus = (String) artistStatement.getObject(3);

        if ("ok".equals(artistStatus)) {
            artistStatement.close();
            getServletContext().getRequestDispatcher("/ceremony_info").forward(req, resp);
        } else {
            artistStatement.close();
            req.setAttribute("problem", artistStatus);
            getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }
}
