package ua.kpi.course.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

import static ua.kpi.course.util.ConnectionProperties.*;

@WebServlet(name = "PasswordChangeServlet", urlPatterns = {"/change_password"})
public class PasswordChangeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        final String userLogin = (String) request.getSession().getAttribute("user_login");
        final String userOldPassword = request.getParameter("old_password");
        final String userNewPassword = request.getParameter("new_password");
        final String userRepeatPassword = request.getParameter("new_password_2");

        if (userNewPassword.equals(userRepeatPassword)) {
            try {
                Class.forName(DRIVER);

                try (Connection connection = DriverManager.getConnection(URL, LOGIN, PASSWORD)) {
                    CallableStatement statement = connection.prepareCall(
                            "{call UPDATEPERSONALPAGE(?,?,?,?,?,?,?,?,?,?)}");
                    statement.setString(1, userLogin);
                    statement.setString(2, userOldPassword);
                    statement.setString(3, null);
                    statement.setString(4, null);
                    statement.setString(5, null);
                    statement.setString(6, null);
                    statement.setString(7, null);
                    statement.setString(8, null);
                    statement.setString(9, userNewPassword);

                    statement.registerOutParameter(10, Types.VARCHAR);

                    statement.executeQuery();

                    final String updateStatus = (String) statement.getObject(10);

                    if ("ok".equalsIgnoreCase(updateStatus)) {
                        statement.close();
                        getServletContext().getRequestDispatcher("/about.jsp").forward(request, response);
                    } else {
                        statement.close();
                        request.setAttribute("problem", updateStatus);
                        getServletContext().getRequestDispatcher("/error.jsp").forward(request, response);
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
        }
    }

}
