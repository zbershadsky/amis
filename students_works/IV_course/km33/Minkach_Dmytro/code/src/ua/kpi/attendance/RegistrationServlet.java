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
@WebServlet(name = "RegistrationServlet", urlPatterns = {"/registration"})
public class RegistrationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        if(session.getAttribute("user_login")!=null) {
            response.sendRedirect("choice.jsp");
        }
        String uemail = request.getParameter("email");
        String pwd = request.getParameter("password");
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String group = request.getParameter("groupsel");
        String phone = request.getParameter("phone");
        String isTeacher = request.getParameter("group1");

        boolean status;

        try {
            Connection con = ConnectionProvider.getCon();
            CallableStatement ps;
            if (isTeacher.equals("1")) {
                ps = con.prepareCall("{call registernewteacher(?, ?, ?, ?, ?, ?)}");

                ps.setString(1, uemail);
                ps.setString(2, pwd);
                ps.setString(3, name);
                ps.setString(4, surname);
                ps.setString(5, phone);

                ps.registerOutParameter(6, Types.INTEGER);

                ResultSet rs = ps.executeQuery();
                status = (int) ps.getObject(6) != 1;
                ps.close();
            } else {
                ps = con.prepareCall("{call registernewstudent(?, ?, ?, ?, ?, ?, ?)}");

                ps.setString(1, uemail);
                ps.setString(2, pwd);
                ps.setString(3, name);
                ps.setString(4, surname);
                ps.setString(5, group);
                ps.setString(6, phone);

                ps.registerOutParameter(7, Types.INTEGER);

                ResultSet rs = ps.executeQuery();
                status = (int) ps.getObject(7) != 1;

            }
            ps.close();

            if (status) {
                request.setAttribute("status", "reg_success");
                getServletContext().getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                request.setAttribute("status", "reg_success");
                getServletContext().getRequestDispatcher("registration.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
