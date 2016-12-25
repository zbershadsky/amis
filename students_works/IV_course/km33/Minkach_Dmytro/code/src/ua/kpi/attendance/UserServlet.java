package ua.kpi.attendance;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;


/**
 * Created by azaza on 24.12.2016.
 */
@WebServlet(name = "UserServlet", urlPatterns = {"/user"})
public class UserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if(session.getAttribute("user_login")==null) {
            response.sendRedirect("login.jsp");
        }
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String uemail = request.getParameter("email");

        try{
            Connection con=ConnectionProvider.getCon();

            CallableStatement ps=con.prepareCall("{call viewstudent(?, ?, ?, ?, ?, ?, ?)}");

            ps.setString(1, uemail);

            ps.registerOutParameter(2, Types.VARCHAR);
            ps.registerOutParameter(3, Types.VARCHAR);
            ps.registerOutParameter(4, Types.VARCHAR);
            ps.registerOutParameter(5, Types.VARCHAR);
            ps.registerOutParameter(6, Types.INTEGER);
            ps.registerOutParameter(7, Types.INTEGER);

            ResultSet rs=ps.executeQuery();
            String name = (String) ps.getObject(2);
            String surname = (String) ps.getObject(3);
            String group = (String) ps.getObject(4);
            String phone = (String) ps.getObject(5);
            boolean status = (int) ps.getObject(6) != 1;
            boolean isTeacher = (int) ps.getObject(7) != 0;

            if (!status) {
                ps=con.prepareCall("{call viewteacher(?, ?, ?, ?, ?, ?)}");

                ps.setString(1, uemail);

                ps.registerOutParameter(2, Types.VARCHAR);
                ps.registerOutParameter(3, Types.VARCHAR);
                ps.registerOutParameter(4, Types.VARCHAR);
                ps.registerOutParameter(5, Types.INTEGER);
                ps.registerOutParameter(6, Types.INTEGER);

                rs=ps.executeQuery();
                name = (String) ps.getObject(2);
                surname = (String) ps.getObject(3);
                phone = (String) ps.getObject(4);
                status = (int) ps.getObject(5) != 1;
                isTeacher = (int) ps.getObject(6) != 0;
            }

            ps.close();

            if (status) {

                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<h1>"+name+"</h1>");
                out.println("<h1>"+surname+"</h1>");
                if (!isTeacher) out.println("<h1>"+group+"</h1>");
                out.println("<h1>"+phone+"</h1>");




            } else {
                // Set response content type
                response.setContentType("text/html");

                // Actual logic goes here.
                PrintWriter out = response.getWriter();
                out.println(uemail);
                out.println("<h1>ERROR! NOT FOUND</h1>");

            }

        }catch(Exception e) {
            e.printStackTrace();
        }
    }
}
