package fpm.servlets;

import fpm.crypt.Crypt;
import fpm.dao.interfaces.CardDAO;
import fpm.dao.interfaces.PaymentDAO;
import fpm.dao.interfaces.PhoneDAO;
import fpm.dao.interfaces.UserDAO;
import fpm.dao.oracle.OracleDAOFactory;
import fpm.entities.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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

        HttpSession session = req.getSession(false);
        String login = session.getAttribute("loggedInUser").toString();

        String phone = req.getParameter("phone_input");
        String amountString = req.getParameter("amount_input");
        String cardNo = req.getParameter("card_select");
        String token;
        Card payCard;

        OracleDAOFactory oracleDaoFactory = new OracleDAOFactory();
        CardDAO cardDao = oracleDaoFactory.getCardDAO();

        if (cardNo.equals("")) {
            cardNo = req.getParameter("card_input");
            String month = req.getParameter("month_select");
            String year = req.getParameter("year_select");
            String cvv = req.getParameter("cvv_input");

            //check card in bank.....
            //if bank responses status ok, then insert cart

            token = "tokenString";
            payCard = new Card(cardNo,"",token);
            cardDao.insertCard(payCard,login);
        }
        else {



            Card[] cards = cardDao.selectCardsByLogin(req.getSession(false).getAttribute("loggedInUser").toString());

            payCard = null;
            for (Card card : cards ) {
                if (card.getCardNo().equals(cardNo)) {
                    payCard = card;
                    break;
                }
            }
            if (payCard == null) {
                //No such card
            }

            token = payCard.getToken();  // token from bank response

        }



        // connecting to bank;
        // retrieving paydate.

        //if OK
        boolean success = true;

        if (success) {


            PaymentDAO paymentDao = oracleDaoFactory.getPaymentDAO();
            PhoneDAO phoneDao = oracleDaoFactory.getPhoneDAO();
            Phone userPhone = new Phone(phone,"");



            OffsetDateTime now = OffsetDateTime.now();
            phoneDao.insertPhone(userPhone, login);
            Payment payment = new Payment(now,Float.parseFloat(amountString),phone,payCard);
            paymentDao.insertPayment(payment);

        }






    }


}
