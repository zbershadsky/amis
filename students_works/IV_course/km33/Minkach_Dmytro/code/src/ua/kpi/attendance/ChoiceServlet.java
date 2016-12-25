package ua.kpi.attendance;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by azaza on 24.12.2016.
 */
@WebServlet(name = "ChoiceServlet", urlPatterns = {"/choice"})
public class ChoiceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        if(session.getAttribute("user_login")==null) {
            response.sendRedirect("login.jsp");
        }

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String group = request.getParameter("group");
        String subject = request.getParameter("subject");
        String date = request.getParameter("date");
        session.setAttribute("date", date);

        List<String> names = new ArrayList<String>();
        List<Integer> presences = new ArrayList<Integer>();
        List<String> emails = new ArrayList<String>();

        try{
            Connection con=ConnectionProvider.getCon();
            PreparedStatement ps;
                con.setTransactionIsolation(Connection.TRANSACTION_READ_COMMITTED);
                ps = con.prepareStatement("SELECT COUNT(*) FROM STUDENTS WHERE s_group=?");
                ps.setString(1, group);

                ps.executeQuery();

                ResultSet resultSet = ps.getResultSet();
                resultSet.next();
                Integer amount = resultSet.getInt(1);

                session.setAttribute("amount", amount);

                ps = con.prepareStatement("SELECT s_name, s_surname, s_email, att_presence " +
                        "FROM Attendance inner join students on s_email_fk= s_email " +
                        "WHERE s_group=? and subj_name_fk=? and sch_date_fk=? " +
                        "ORDER BY SCH_DATE_fk, S_SURNAME");

                ps.setString(1, group);
                ps.setString(2, subject);
                ps.setString(3, date);

                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    names.add(rs.getString(2) + " " + rs.getString(1));
                    presences.add(rs.getInt(4));
                    emails.add(rs.getString(3));
                }

                session.setAttribute("names", names);
                session.setAttribute("presences", presences);
                session.setAttribute("emails", emails);
                ps.close();
                getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);

//                response.setContentType("text/html");
//
//                // Actual logic goes here.
//                PrintWriter out = response.getWriter();
//                out.println(amount);
//                out.println("<h1>ERROR! NOT FOUND</h1>");

//                ps.registerOutParameter(6, Types.INTEGER);
//
//                status = (int) ps.getObject(7) != 1;



        }catch(Exception e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
