package ua.kpi.course.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

import static ua.kpi.course.util.ConnectionProperties.*;

@WebServlet(name = "PromotionServlet", urlPatterns = "/promotion")
public class PromotionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Class.forName(DRIVER);

            try (Connection connection = DriverManager.getConnection(URL, LOGIN, PASSWORD)) {
                CallableStatement statement = connection.prepareCall("{call CHANGEROLE(?, ?, ?)}");
                String userName = req.getParameter("new_man");
                String managerName = (String) req.getSession().getAttribute("user_login");

                System.out.println(userName);
                System.out.println(managerName);
                statement.setString(1, userName);
                statement.setString(2, managerName);

                statement.registerOutParameter(3, Types.VARCHAR);

                statement.executeQuery();

                String promotionStatus = (String) statement.getObject(3);

                if ("ok".equalsIgnoreCase(promotionStatus)) {
                    req.getSession().invalidate();
                    getServletContext().getRequestDispatcher("/login.jsp").forward(req, resp);
                } else {
                    req.setAttribute("problem", promotionStatus);
                    getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
                }

                statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

}
