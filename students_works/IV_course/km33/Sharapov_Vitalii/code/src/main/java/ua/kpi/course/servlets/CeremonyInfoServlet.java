package ua.kpi.course.servlets;

import ua.kpi.course.util.UtilDao;

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

@WebServlet(name = "CeremonyInfoServlet", urlPatterns = "/ceremony_info")
public class CeremonyInfoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        final String userLogin = (String) session.getAttribute("user_login");
        try {
            Class.forName(DRIVER);

            try (Connection connection = DriverManager.getConnection(URL, LOGIN, PASSWORD);
                 PreparedStatement statement = connection.prepareStatement(
                         "SELECT u_name,\n" +
                                 "    u_groom_name, u_groom_surname, u_groom_birthday,\n" +
                                 "    u_bride_name, u_bride_surname, u_bride_birthday,\n" +
                                 "    c_date,\n" +
                                 "    r_name, r_address, r_is_confirmed " +
                                 "FROM ceremonyrestaurant " +
                                 "WHERE u_name = '" + userLogin + "'")) {
                statement.executeQuery();

                ResultSet set = statement.getResultSet();

                boolean isManager = (boolean) session.getAttribute("user_is_manager");
                if (isManager) {
                    loadRegularUsers(req);
                    loadUnassignedUsers(req);
                    loadRestaurantsToConfirm(req);
                    loadArtistsToConfirm(req);
                    getServletContext().getRequestDispatcher("/ceremony_info.jsp").forward(req, resp);
                } else if (set.next()) {
                    String groomInfo = set.getString(2) + " " + set.getString(3) + ", " + set.getDate(4);
                    req.setAttribute("cer_groom", groomInfo);

                    String brideInfo = set.getString(5) + " " + set.getString(6) + ", " + set.getDate(7);
                    req.setAttribute("cer_bride", brideInfo);

                    Date ceremonyDate = set.getDate(8);
                    req.setAttribute("cer_date", ceremonyDate);

                    String confirmationStatus = set.getInt(11) > 0 ? "confirmed" : "not confirmed";
                    String restaurantInfo = set.getString(9) + ", " + set.getString(10) + "," + confirmationStatus;
                    req.setAttribute("cer_rest", restaurantInfo);

                    loadCeremonyArtists(req, userLogin);

                    UtilDao.retrieveRestaurants(req, connection);
                    UtilDao.retrieveArtists(req, connection);
                    getServletContext().getRequestDispatcher("/ceremony_info.jsp").forward(req, resp);
                } else {
                    req.setAttribute("problem", "failed to load ceremony");
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
    }

    private void loadArtistsToConfirm(HttpServletRequest req) throws SQLException {
        Connection innerConnection = DriverManager.getConnection(URL, LOGIN, PASSWORD);
        PreparedStatement preparedStatement = innerConnection.prepareStatement(
                "SELECT ceremonyartists.u_name, ceremonyartists.a_name, a_contract, ceremonyartists.p_is_confirmed " +
                        "FROM ceremonyartists INNER JOIN managerAssignments ON ceremonyartists.u_name = managerAssignments.u_name " +
                        "INNER JOIN viewartists ON viewartists.a_name = ceremonyartists.a_name " +
                        "WHERE managerAssignments.manager_fk = '" + req.getSession().getAttribute("user_login") + "'");
        preparedStatement.executeQuery();

        ResultSet resultSet = preparedStatement.getResultSet();
        List<String[]> tokenList = new ArrayList<>();
        while (resultSet.next()) {
            String[] tokens = new String[4];
            tokens[0] = resultSet.getString(1);
            tokens[1] = resultSet.getString(2);
            tokens[2] = resultSet.getString(3);
            tokens[3] = resultSet.getString(4);
            tokenList.add(tokens);
        }
        System.out.println(tokenList);
        req.setAttribute("art_tokens", tokenList);
        preparedStatement.close();
        innerConnection.close();
    }

    private void loadRestaurantsToConfirm(HttpServletRequest req) throws SQLException {
        Connection innerConnection = DriverManager.getConnection(URL, LOGIN, PASSWORD);
        PreparedStatement preparedStatement = innerConnection.prepareStatement(
                "SELECT ceremonyrestaurant.u_name, ceremonyrestaurant.r_name, r_contract, ceremonyrestaurant.r_is_confirmed " +
                        "FROM ceremonyrestaurant INNER JOIN managerAssignments ON ceremonyrestaurant.u_name = managerAssignments.u_name " +
                        "INNER JOIN viewrestaurants ON viewrestaurants.r_name = ceremonyrestaurant.r_name " +
                        "WHERE managerAssignments.manager_fk = '" + req.getSession().getAttribute("user_login") + "'");
        preparedStatement.executeQuery();

        ResultSet resultSet = preparedStatement.getResultSet();
        List<String[]> tokenList = new ArrayList<>();
        while (resultSet.next()) {
            String[] tokens = new String[4];
            tokens[0] = resultSet.getString(1);
            tokens[1] = resultSet.getString(2);
            tokens[2] = resultSet.getString(3);
            tokens[3] = resultSet.getString(4);
            tokenList.add(tokens);
        }
        System.out.println(tokenList);
        req.setAttribute("rest_tokens", tokenList);
        preparedStatement.close();
        innerConnection.close();
    }

    private void loadRegularUsers(HttpServletRequest req) throws SQLException {
        Connection innerConnection = DriverManager.getConnection(URL, LOGIN, PASSWORD);
        PreparedStatement preparedStatement = innerConnection.prepareStatement("SELECT u_name FROM userstatus WHERE u_is_manager = 0");
        preparedStatement.executeQuery();

        ResultSet resultSet = preparedStatement.getResultSet();
        List<String> userList = new ArrayList<>();
        while (resultSet.next()) {
            userList.add(resultSet.getString(1));
        }
        req.setAttribute("user_list", userList);
        preparedStatement.close();
        innerConnection.close();
    }

    private void loadUnassignedUsers(HttpServletRequest req) throws SQLException {
        Connection innerConnection = DriverManager.getConnection(URL, LOGIN, PASSWORD);
        PreparedStatement preparedStatement = innerConnection.prepareStatement("SELECT u_name " +
                "FROM managerAssignments " +
                "WHERE manager_fk IS NULL AND u_name IN (SELECT u_name FROM userstatus WHERE u_is_manager = 0)");
        preparedStatement.executeQuery();

        ResultSet resultSet = preparedStatement.getResultSet();
        List<String> userList = new ArrayList<>();
        while (resultSet.next()) {
            userList.add(resultSet.getString(1));
        }
        req.setAttribute("unassigned_user", userList);
        preparedStatement.close();
        innerConnection.close();
    }

    private void loadCeremonyArtists(HttpServletRequest req, String userLogin) throws ServletException, IOException {
        try (Connection connection = DriverManager.getConnection(URL, LOGIN, PASSWORD);
             PreparedStatement statement = connection.prepareStatement(
                     "SELECT a_name, a_genre, p_is_confirmed  FROM ceremonyartists WHERE u_name = '" + userLogin + "'")) {
            statement.executeQuery();

            ResultSet set = statement.getResultSet();

            List<String> artistList = new ArrayList<>();
            while (set.next()) {
                String artistConfirmationStatus = set.getInt(3) > 0 ? "confirmed" : "not confirmed";
                String artistInfo = set.getString(1) + ", " + set.getString(2) + "," + artistConfirmationStatus;
                artistList.add(artistInfo);
            }

            req.setAttribute("cer_art", artistList);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
