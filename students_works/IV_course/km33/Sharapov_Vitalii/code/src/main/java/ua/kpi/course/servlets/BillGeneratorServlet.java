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

@WebServlet(name = "BillGeneratorServlet", urlPatterns = "/bill")
public class BillGeneratorServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String userLogin = (String) req.getSession().getAttribute("user_login");
        double artistsAmount = checkoutArtists(req, userLogin);
        double restaurantsAmount = checkoutRestaurants(req, userLogin);

        double organizerAmount = (artistsAmount + restaurantsAmount) * 0.15;
        req.setAttribute("org_sum", organizerAmount);

        double totalAmount = artistsAmount + restaurantsAmount + organizerAmount;
        req.setAttribute("total_sum", totalAmount);

        try {
            Class.forName(ConnectionProperties.DRIVER);

            try (Connection connection = DriverManager.getConnection(URL, LOGIN, PASSWORD)) {
                CallableStatement statement = connection.prepareCall("{call INSERTBILL(?,?,?)}");
                statement.setString(1, userLogin);
                statement.setDouble(2, totalAmount);

                statement.registerOutParameter(3, Types.VARCHAR);

                statement.executeQuery();

                final String billStatus = (String) statement.getObject(3);

                if ("ok".equalsIgnoreCase(billStatus)) {
                    getServletContext().getRequestDispatcher("/bill.jsp").forward(req, resp);
                } else {
                    req.setAttribute("problem", billStatus);
                    getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    private double checkoutRestaurants(HttpServletRequest req, String userLogin) {
        try (Connection connection = DriverManager.getConnection(URL, LOGIN, PASSWORD);
             PreparedStatement statement = connection.prepareStatement(
                     "SELECT sum(r_price_per_day)  " +
                             "FROM ceremonyrestaurant " +
                             "INNER JOIN viewrestaurants on ceremonyrestaurant.r_name = viewrestaurants.r_name " +
                             "WHERE u_name = '" + userLogin + "' and r_is_confirmed > 0")) {
            statement.executeQuery();

            ResultSet set = statement.getResultSet();

            set.next();
            double result = set.getDouble(1);
            req.setAttribute("rest_sum", result);
            return result;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private double checkoutArtists(HttpServletRequest req, String userLogin) {
        try (Connection connection = DriverManager.getConnection(URL, LOGIN, PASSWORD);
             PreparedStatement statement = connection.prepareStatement(
                     "SELECT sum(a_price_per_day) " +
                             "FROM ceremonyartists " +
                             "INNER JOIN viewartists on ceremonyartists.a_name =  viewartists.a_name " +
                             "WHERE u_name = '" + userLogin + "' and p_is_confirmed > 0")) {
            statement.executeQuery();

            ResultSet set = statement.getResultSet();

            set.next();
            double result = set.getDouble(1);
            req.setAttribute("art_sum", result);
            return result;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

}
