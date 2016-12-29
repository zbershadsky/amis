package fpm.dao.oracle;


import fpm.dao.interfaces.PaymentDAO;
import fpm.entities.Card;
import fpm.entities.Payment;
import fpm.entities.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.ZoneId;
import java.util.ArrayList;
import java.time.OffsetDateTime;
import java.util.List;

public class OraclePaymentDAO implements
        PaymentDAO {

    public OraclePaymentDAO() {
        // initialization
    }

    private Connection con;

    @Override
    public Payment[] selectPaymentsByLogin(String login) {

        ArrayList<Payment> paymentsList = new ArrayList<Payment>();
        this.con = OracleDAOFactory.open();

        try {



            PreparedStatement select = con.prepareStatement("Select * from cardspayments where login = ?");
                select.setString(1,login);
                ResultSet rs = select.executeQuery();
                if (!rs.isBeforeFirst()) {
                return null;
                }
                while(rs.next()) {
                    paymentsList.add(new Payment(OffsetDateTime.ofInstant(rs.getTimestamp(2).toInstant(), ZoneId.of("Europe/Paris")),rs.getFloat(3),rs.getString(4),new Card(rs.getString(6),rs.getString(8)), rs.getInt(1)));
                }


        } catch (SQLException e) {
            e.printStackTrace();
        }
        OracleDAOFactory.close(con);
        return paymentsList.toArray(new Payment[paymentsList.size()]);

    }

    @Override
    public int insertPayment(Payment payment) {

        this.con = OracleDAOFactory.open();
        PreparedStatement ins = null;
        int id = -1;
        try {
            ins = con.prepareStatement("insert into payment (paydate,amount,phone_number,CardNo) values (?,?,?,?)");
            ins.setTimestamp(1,payment.getSqlDate());
            ins.setFloat(2,payment.getAmount());
            ins.setString(3,payment.getPhone());
            ins.setString(4,payment.getCard().getCardNo());
            id = ins.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        OracleDAOFactory.close(con);
        return id;


    }





}