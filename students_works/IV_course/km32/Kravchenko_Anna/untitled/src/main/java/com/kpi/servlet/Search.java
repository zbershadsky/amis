package com.kpi.servlet;

import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Ann on 25.12.2016.
 */
@WebServlet("/search")
public class Search extends HttpServlet {
/*
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("index.jsp").forward(req, resp);

    }
*/

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String tag_1 = req.getParameter("tag1");
        String tag_2 = req.getParameter("tag2");
        List<String> imageCodeArray = new ArrayList<>();
        String answ = ("It seems we do not have such arts...");

        try {
            Connection connection = ConnectDataBase.connect("java:/comp/env", "jdbc/HRDB").getConnection(); /*создание связи*/
            PreparedStatement statement = connection.prepareStatement("SELECT img FROM viewallarts WHERE tag_main = ? or tag = ?", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            {
                statement.setString(1, tag_1);
                statement.setString(2, tag_2);
                ResultSet resultSet = statement.executeQuery();
                while (resultSet.next()) {
                    Blob b = resultSet.getBlob("img");
                    String nameVariable = "data:image/jpg;base64," + Base64.encode(b.getBytes(1, (int) b.length()));
                    imageCodeArray.add(nameVariable);
                    answ = null;
                }
                resultSet.close();
            }
            statement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        req.setAttribute("answ", answ);
        req.setAttribute("imageCodeArray", imageCodeArray);
        req.getRequestDispatcher("viewAllArts.jsp").forward(req, resp);
    }
}

