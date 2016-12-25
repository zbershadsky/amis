package fpm.servlets;

import fpm.crypt.Crypt;
import fpm.dao.interfaces.PaymentDAO;
import fpm.dao.interfaces.UserDAO;
import fpm.dao.oracle.OracleDAOFactory;
import fpm.entities.Card;
import fpm.entities.Payment;
import fpm.entities.Status;
import fpm.entities.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;

import java.time.OffsetDateTime;
import java.sql.Timestamp;

/**
 * Created by Guest on 25.12.2016.
 */

@WebServlet("/pay")
public class PayProcess extends HttpServlet {


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String phone = req.getParameter("phone_input");
        String amountString = req.getParameter("amoun_input");
        String cardNo = req.getParameter("card_select");
        if (cardNo.equals("")) {
            cardNo = req.getParameter("card_input");
            String month = req.getParameter("month_select");
            String year = req.getParameter("year_select");
            String cvv = req.getParameter("cvv_input");
        }



        // connecting to bank;
        // retrieving paydate.

        //if OK
        boolean success = true;
        String token = "";    // token from bank response
        if (success) {

            OracleDAOFactory oracleDaoFactory = new OracleDAOFactory();
            PaymentDAO paymentDao = oracleDaoFactory.getPaymentDAO();

            OffsetDateTime now = OffsetDateTime.now();
            Payment payment = new Payment(now,Float.parseFloat(amountString),phone,new Card(cardNo,"",token));

            paymentDao.insertPayment(payment);

        }






    }


}
