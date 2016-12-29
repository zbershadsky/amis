package com.ViacheslavKyslyi.Servlet;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.tools.Tool;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;

public class SearchServlet extends HttpServlet {

    private HashMap<Integer, Integer> relevancyMap;
    private Connection connection;

    private JSONArray restaurantsResult;

    private void searchMealsFromWord(String word) throws SQLException{

        String searchReq = "select ID from mealView " +
                "  where lower(\"Name\") like '%"+ word.trim().toLowerCase() +"%' " +
                "     or lower(\"Description\") like '%"+ word.trim().toLowerCase() +"%'";

        Statement searchStatement = connection.createStatement();

        ResultSet rs = searchStatement.executeQuery(searchReq);

        while (rs.next()) {
            int id = rs.getInt("ID");

            if (relevancyMap.containsKey(id)) {
                relevancyMap.replace(id, relevancyMap.get(id) + 1);
            } else {
                relevancyMap.put(id, 1);
            }
        }

    }

    private int addQueryToDB(int user_id, String query) throws Exception{
        CallableStatement addQueryCall = connection.prepareCall("{call addQuery(?, ?, ?)}");

        addQueryCall.setString(1, query);
        addQueryCall.setInt(2, user_id);

        addQueryCall.registerOutParameter(3, Types.INTEGER);

        addQueryCall.execute();

        return addQueryCall.getInt(3);
    }

    private ArrayList<String> getWords(String query){
        ArrayList<String> resultArray;
        resultArray = new ArrayList<>();

        String[] array = query.replace(".", "").replace(",", "").replace("?", "").replace("!","").split(" ");

        for (int i=0 ; i<array.length ; i++) {
            if (array[i].trim().toCharArray().length >= 3) {
                resultArray.add(array[i].trim());
            }
        }

        return  resultArray;
    }

    private void addToMealResult(int queryID, int mealID) throws Exception{
        CallableStatement addMealResultCall = connection.prepareCall("{call addToMealQueryLink(?, ?)}");

        addMealResultCall.setInt(1, queryID);
        addMealResultCall.setInt(2, mealID);

        addMealResultCall.execute();
    }

    private void addToRestResult(int queryID, int restID) throws Exception{
        CallableStatement addMealResultCall = connection.prepareCall("{call addToRestQueryLink(?, ?)}");

        addMealResultCall.setInt(1, queryID);
        addMealResultCall.setInt(2, restID);

        addMealResultCall.execute();
    }

    private void processMealsResults(Set<Integer> results){

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        restaurantsResult = new JSONArray();
        relevancyMap = new HashMap<>();

        HttpSession session = req.getSession();

        try {

            int userSessionID = Integer.parseInt(String.valueOf(session.getAttribute("userID")));

            Class.forName("oracle.jdbc.OracleDriver");

            connection = DriverManager.getConnection(
                    "jdbc:oracle:thin:@//localhost:1521", "slava", "Ron4swanson");

            connection.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
            connection.setAutoCommit(false);

            String query = String.valueOf(req.getParameter("query"));

            int query_id = addQueryToDB(1, query);
            ArrayList<String> words = getWords(query);

            for(String word : words) {
                searchMealsFromWord(word);
            }

            Set<Integer> ids = relevancyMap.keySet();
            Iterator iter = ids.iterator();

            String meal_list = "(";

            while (iter.hasNext()) {
                int id = (int) iter.next();
                addToMealResult(query_id, id);
                meal_list += (id + ",");
            }

            meal_list = meal_list.substring(0, meal_list.length()-1);
            meal_list += ")";

            String restaurantQuery = "select rest_id, \"Name\", \"Description\", \"Address\" \n" +
                                     "  from restaurant_meal where meal_id in "+ meal_list +" \n" +
                                     "  group by rest_id, \"Name\", \"Description\", \"Address\"";

            Statement searchStatement = connection.createStatement();

            ResultSet rs = searchStatement.executeQuery(restaurantQuery);

            JSONObject restOdj;

            while (rs.next()) {
                int id = rs.getInt("rest_id");
                addToRestResult(query_id, id);

                restOdj = new JSONObject();

                restOdj.put("id", Tools.function(id));
                restOdj.put("name", rs.getString("Name"));
                restOdj.put("description", rs.getString("Description"));

                restaurantsResult.add(restOdj);
            }

            connection.commit();

        } catch (Exception e) {
            e.printStackTrace();
        }

        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();
        out.print(restaurantsResult.toString());
    }

    public static void main(String[] args) {
        //new SearchServlet().search("");
    }

}
