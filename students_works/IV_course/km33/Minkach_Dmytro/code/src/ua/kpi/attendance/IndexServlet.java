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
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

/**
 * Created by azaza on 24.12.2016.
 */
@WebServlet(name = "IndexServlet", urlPatterns = {"/index"})
public class IndexServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        if(session.getAttribute("user_login")==null) {
            response.sendRedirect("login.jsp");
        }

        String date = request.getParameter("date");

//        PrintWriter out = response.getWriter();
//        response.setContentType("text/plain");

         try{
            Connection con=ConnectionProvider.getCon();

            CallableStatement ps=con.prepareCall("{call updateattendance(?, ?, ?)}");

             List<Integer> presences = new ArrayList<Integer>();

            Enumeration<String> parameterNames = request.getParameterNames();
            String paramName = parameterNames.nextElement();
             while (parameterNames.hasMoreElements()) {

                 paramName = parameterNames.nextElement();
                 String[] paramValues = request.getParameterValues(paramName);
                 Integer paramValue = Integer.parseInt(paramValues[paramValues.length-1]);
                 ps.setString(1, paramName);
                 ps.setString(2, date);
                 ps.setInt(3, paramValue);
                 presences.add(paramValue);

                 ResultSet rs=ps.executeQuery();
             }
             ps.close();
             session.setAttribute("presences", presences);
             request.setAttribute("changed", "success");
             getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);



        }catch(Exception e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
