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

@WebServlet(name = "PersonalPageServlet", urlPatterns = "/personal_page")
public class PersonalPageServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String command = req.getParameter("command");

        switch (command) {
            case "load":
                doPersonalInfoLoad(req, resp);
                break;
            case "update":
                doPersonalInfoUpdate(req, resp);
                break;
            default:
                getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
                break;
        }
    }

    private void doPersonalInfoUpdate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Class.forName(DRIVER);

            try (Connection connection = DriverManager.getConnection(URL, LOGIN, PASSWORD)) {
                CallableStatement statement = connection.prepareCall(
                        "{call UPDATEPERSONALPAGE(?,?,?,?,?,?,?,?,?,?)}");
                statement.setString(1, req.getParameter("user_name"));
                statement.setString(2, req.getParameter("user_password"));
                statement.setString(3, req.getParameter("user_groom_name"));
                statement.setString(4, req.getParameter("user_groom_surname"));
                statement.setString(5, req.getParameter("user_groom_birthday"));
                statement.setString(6, req.getParameter("user_bride_name"));
                statement.setString(7, req.getParameter("user_bride_surname"));
                statement.setString(8, req.getParameter("user_bride_birthday"));
                statement.setString(9, null);

                statement.registerOutParameter(10, Types.VARCHAR);

                statement.executeQuery();

                final String updateStatus = (String) statement.getObject(10);

                if ("ok".equalsIgnoreCase(updateStatus)) {
                    doPersonalInfoLoad(req, resp);
                    statement.close();
                } else {
                    statement.close();
                    req.setAttribute("problem", updateStatus);
                    getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    private void doPersonalInfoLoad(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        final String userLogin = (String) session.getAttribute("user_login");
        try {
            Class.forName(DRIVER);

            try (Connection connection = DriverManager.getConnection(URL, LOGIN, PASSWORD)) {
                PreparedStatement statement = connection.prepareStatement(
                        "SELECT u_name, u_email, u_is_manager," +
                                "    u_groom_name, u_groom_surname, u_groom_birthday, " +
                                "    u_bride_name, u_bride_surname, u_bride_birthday " +
                                "FROM PersonalInfo " +
                                "WHERE u_name = '" + userLogin + "'");
                statement.executeQuery();

                ResultSet resultSet = statement.getResultSet();

                if (resultSet.next()) {
                    req.setAttribute("user_name", resultSet.getString(1));
                    req.setAttribute("user_email", resultSet.getString(2));
                    String userStatus = resultSet.getInt(3) > 0 ? "manager" : "regular";
                    req.setAttribute("user_status", userStatus);

                    req.setAttribute("user_groom_name", resultSet.getString(4));
                    req.setAttribute("user_groom_surname", resultSet.getString(5));
                    req.setAttribute("user_groom_birthday", resultSet.getDate(6));

                    req.setAttribute("user_bride_name", resultSet.getString(7));
                    req.setAttribute("user_bride_surname", resultSet.getString(8));
                    req.setAttribute("user_bride_birthday", resultSet.getDate(9));
                    statement.close();
                    getServletContext().getRequestDispatcher("/personal_page.jsp").forward(req, resp);
                } else {
                    req.setAttribute("problem", "failed to get personal data");
                    statement.close();
                    getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

}
