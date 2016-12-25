package ua.kpi.course.servlets;

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

@WebServlet(name = "ContactServlet", urlPatterns = {"/contact"})
public class ContactServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Class.forName(DRIVER);

            try (Connection connection = DriverManager.getConnection(URL, LOGIN, PASSWORD)) {
                CallableStatement statement = connection.prepareCall("{call SENDMESSAGE(?, ?, ?, ?)}");
                String sender = (String) req.getSession().getAttribute("user_login");
                String receiver = req.getParameter("send_to");
                String content = req.getParameter("new_msg");

                statement.setString(1, sender);
                statement.setString(2, receiver);
                statement.setString(3, content);

                statement.registerOutParameter(4, Types.VARCHAR);

                statement.executeQuery();

                String messageStatus = (String) statement.getObject(4);
                System.out.println("here");
                if ("ok".equalsIgnoreCase(messageStatus)) {
                    System.out.println("here");
                    getServletContext().getRequestDispatcher("/about.jsp").forward(req, resp);
                } else {
                    req.setAttribute("problem", messageStatus);
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

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        final String userLogin = (String) session.getAttribute("user_login");
        try {
            Class.forName(DRIVER);

            try (Connection connection = DriverManager.getConnection(URL, LOGIN, PASSWORD);
                 PreparedStatement statement = connection.prepareStatement(
                         "(SELECT m_from, m_to, m_content, m_timestamp FROM messageHistory WHERE m_from = '" + userLogin + "' " +
                                 "UNION SELECT m_from, m_to, m_content, m_timestamp FROM messageHistory WHERE m_to = '" + userLogin + "') " +
                                 "ORDER BY m_timestamp DESC ")) {
                statement.executeQuery();

                ResultSet set = statement.getResultSet();

                StringBuilder builder = new StringBuilder();
                while (set.next()) {
                    builder.append("from: ")
                            .append(set.getString(1))
                            .append(System.lineSeparator())
                            .append("to: ")
                            .append(set.getString(2))
                            .append(System.lineSeparator())
                            .append("at: ")
                            .append(set.getString(4))
                            .append(System.lineSeparator())
                            .append("content: ")
                            .append(set.getString(3))
                            .append(System.lineSeparator())
                            .append(System.lineSeparator());
                }
                req.setAttribute("hist", builder.toString());
                loadRegularUsers(req);
                getServletContext().getRequestDispatcher("/contact.jsp").forward(req, resp);
            } catch (SQLException e) {
                e.printStackTrace();
                getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }

    private void loadRegularUsers(HttpServletRequest req) throws SQLException {
        Connection innerConnection = DriverManager.getConnection(URL, LOGIN, PASSWORD);
        PreparedStatement preparedStatement = innerConnection.prepareStatement("SELECT u_name FROM userstatus");
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
}
