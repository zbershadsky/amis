package fpm.servlets;

import fpm.dao.interfaces.PaymentDAO;
import fpm.dao.interfaces.UserDAO;
import fpm.dao.oracle.OracleDAOFactory;
import fpm.entities.Payment;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/services")

public class Userpage extends HttpServlet{


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        resp.setContentType("text/html");
        String actionParam = req.getParameter("action");
        String login = session.getAttribute("loggedInUser").toString();

        if (actionParam.equals("payments")) {
            OracleDAOFactory oracleDaoFactory = new OracleDAOFactory();
            PaymentDAO paymentDao = oracleDaoFactory.getPaymentDAO();
            Payment[] userPayments = paymentDao.selectPaymentsByLogin(login);
            req.setAttribute("payments",userPayments);

        }

        else if (actionParam.equals("cards")) {


        }


        else if (actionParam.equals("settings")) {


        }






        req.setAttribute("menu_item",actionParam);
        req.getRequestDispatcher("services.jsp").forward(req,resp);







    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
