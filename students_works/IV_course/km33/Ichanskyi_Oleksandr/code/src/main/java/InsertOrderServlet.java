import Databases.SQLiteClass;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Sascha on 21.12.2016.
 */
@WebServlet(name = "InsertOrderServlet")
public class InsertOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("1");
        List dataList = new ArrayList();
        HttpSession session = request.getSession();
        System.out.println("2");
        try {
            System.out.println("3");
            Statement statement = SQLiteClass.getDBConnection().createStatement();
            statement.executeQuery("SELECT CUST_NAME FROM CUSTOMERS");
            System.out.println("4");
            ResultSet rs = statement.getResultSet();
            System.out.println("5");
            while (rs.next()) {
                System.out.println("6");
                dataList.add(rs.getString(1));
            }
            rs.close();
            statement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        System.out.println("7");
        session.setAttribute("data", dataList);
        System.out.println("8");
        RequestDispatcher reqDispatcher = getServletConfig().getServletContext().getRequestDispatcher("UserPageOrder.jsp");
        System.out.println("9");
        reqDispatcher.forward(request,response);


      /*  System.out.println("111113");
        //String command = request.getParameter("name");
        Object kode_reg_obj = request.getParameter("info");
        String password_reg = (String) kode_reg_obj;

        System.out.println("123");
        System.out.println(password_reg);

        Object iii = request.getParameter("kode_logIn");
        String bbbb = (String) iii;
        System.out.println(bbbb);*/
       /* switch (command) {

            case "logout": {
                request.getSession().invalidate();
                getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
                break;
            }
            default:{
                getServletContext().getRequestDispatcher("/error.jsp").forward(request, response);
                break;
            }*/
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

}
