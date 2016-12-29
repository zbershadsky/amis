package ua.kpi.attendance;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

/**
 * Created by azaza on 24.12.2016.
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends javax.servlet.http.HttpServlet {
    protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        String uemail = request.getParameter("email");
        String pwd = request.getParameter("password");
        HttpSession session = request.getSession();
        if(session.getAttribute("user_login")!=null) {
            response.sendRedirect("choice");
        }
        try{
            Connection con=ConnectionProvider.getCon();

            CallableStatement ps=con.prepareCall("{call authorize(?, ?, ?, ?)}");

            ps.setString(1, uemail);
            ps.setString(2, pwd);

            ps.registerOutParameter(3, Types.INTEGER);
            ps.registerOutParameter(4, Types.INTEGER);

            ResultSet rs=ps.executeQuery();
            boolean status = (int) ps.getObject(3) != 1;
            boolean isTeacher = (int) ps.getObject(4) != 0;
            ps.close();
            if (status) {
                session.setAttribute("user_is_manager", isTeacher);
                session.setAttribute("user_login", uemail);
                getServletContext().getRequestDispatcher("/choice.jsp").forward(request, response);
            } else {
                request.setAttribute("status", "pass_wrong");
                getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
            }

        }catch(Exception e) {
            e.printStackTrace();
        }

    }
}
