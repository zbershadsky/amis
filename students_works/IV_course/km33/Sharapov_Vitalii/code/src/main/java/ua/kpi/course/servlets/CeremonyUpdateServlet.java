package ua.kpi.course.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

import static ua.kpi.course.util.ConnectionProperties.*;

@WebServlet(name = "CeremonyUpdateServlet", urlPatterns = {"/update_ceremony"})
public class CeremonyUpdateServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String command = req.getParameter("command");
        final String userLogin = (String) req.getSession().getAttribute("user_login");

        switch (command) {
            case "edit rest":
                doEditRestaurant(req, resp, userLogin);
                break;
            case "add artist":
                doAddArtist(req, resp, userLogin);
                break;
            case "edit date":
                doEditCeremonyDate(req, resp, userLogin);
                break;
            default:
                getServletContext().getRequestDispatcher("/error.jsp");
                break;
        }
    }

    private void doAddArtist(HttpServletRequest req, HttpServletResponse resp, String userLogin) throws ServletException, IOException {
        try (Connection connection = DriverManager.getConnection(URL, LOGIN, PASSWORD);
             CallableStatement statement = connection.prepareCall("{CALL CHANGEARTIST(?,?,?)}")) {
            statement.setString(1, userLogin);
            statement.setString(2, req.getParameter("art_number"));

            statement.registerOutParameter(3, Types.VARCHAR);

            statement.executeQuery();

            final String artistStatus = (String) statement.getObject(3);

            if ("ok".equals(artistStatus)) {
                getServletContext().getRequestDispatcher("/ceremony_info").forward(req, resp);
            } else {
                req.setAttribute("problem", artistStatus);
                getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }

    private void doEditRestaurant(HttpServletRequest req, HttpServletResponse resp, String userLogin) throws ServletException, IOException {
        try (Connection connection = DriverManager.getConnection(URL, LOGIN, PASSWORD);
             CallableStatement statement = connection.prepareCall("{CALL CHANGERESTAURANT(?,?,?)}")) {
            statement.setString(1, userLogin);
            statement.setInt(2, Integer.parseInt(req.getParameter("rest_number")));

            statement.registerOutParameter(3, Types.VARCHAR);

            statement.executeQuery();

            final String restaurantStatus = (String) statement.getObject(3);

            if ("ok".equals(restaurantStatus)) {
                getServletContext().getRequestDispatcher("/ceremony_info").forward(req, resp);
            } else {
                req.setAttribute("problem", restaurantStatus);
                getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }

    private void doEditCeremonyDate(HttpServletRequest req, HttpServletResponse resp, String userLogin) throws ServletException, IOException {
        try (Connection connection = DriverManager.getConnection(URL, LOGIN, PASSWORD);
             CallableStatement statement = connection.prepareCall("{call CHANGECEREMONYDATE(?,?,?)}")) {
            statement.setString(1, userLogin);
            statement.setDate(2, Date.valueOf(req.getParameter("cer_date")));

            statement.registerOutParameter(3, Types.VARCHAR);

            statement.executeQuery();

            final String ceremonyDateStatus = (String) statement.getObject(3);

            if ("ok".equals(ceremonyDateStatus)) {
                getServletContext().getRequestDispatcher("/ceremony_info").forward(req, resp);
            } else {
                req.setAttribute("problem", ceremonyDateStatus);
                getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }

}
