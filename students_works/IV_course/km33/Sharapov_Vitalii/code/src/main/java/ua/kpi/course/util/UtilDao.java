package ua.kpi.course.util;

import javax.servlet.http.HttpServletRequest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import java.util.TreeMap;

public class UtilDao {

    public static void retrieveRestaurants(HttpServletRequest req, Connection connection) throws SQLException {
        Map<Integer, String> restaurantMap = new TreeMap<>();
        PreparedStatement restaurantStatement = connection.prepareStatement(
                "SELECT r_contract, r_name, r_address, r_price_per_day FROM viewrestaurants ORDER BY 1 ASC");

        restaurantStatement.executeQuery();

        ResultSet restaurantResultSet = restaurantStatement.getResultSet();
        while (restaurantResultSet.next()) {
            String restaurantInfo = restaurantResultSet.getString(2) + ", " +
                    restaurantResultSet.getString(3) + ", " +
                    restaurantResultSet.getString(4) + " money units per day";

            restaurantMap.put(restaurantResultSet.getInt(1), restaurantInfo);
        }
        restaurantStatement.close();
        req.setAttribute("restMap", restaurantMap);
    }

    public static void retrieveArtists(HttpServletRequest req, Connection connection) throws SQLException {
        Map<Integer, String> artistMap = new TreeMap<>();
        PreparedStatement artistStatement = connection.prepareStatement(
                "SELECT a_contract, a_name, a_genre, a_price_per_day FROM viewartists ORDER BY 1 ASC");
        artistStatement.executeQuery();
        ResultSet artistResultSet = artistStatement.getResultSet();
        while (artistResultSet.next()) {
            String artistInfo = artistResultSet.getString(2) + ", " +
                    artistResultSet.getString(3) + ", " +
                    artistResultSet.getString(4) + " money units per day";

            artistMap.put(artistResultSet.getInt(1), artistInfo);
        }
        req.setAttribute("artMap", artistMap);
    }
}
