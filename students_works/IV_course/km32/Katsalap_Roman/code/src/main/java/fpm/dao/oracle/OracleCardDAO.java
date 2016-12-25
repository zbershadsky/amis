package fpm.dao.oracle;


import fpm.dao.interfaces.CardDAO;
import fpm.entities.Card;
import fpm.entities.Payment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class OracleCardDAO implements
        CardDAO {

    public OracleCardDAO() {
        // initialization
    }

    private Connection con;

    @Override
    public Card[] selectCardsByLogin(String login) {

        this.con = OracleDAOFactory.open();
        ArrayList<Card> cardsList = new ArrayList<Card>();

        try {

            PreparedStatement select = con.prepareStatement("Select cardno,cardname from Cards where login = ?");
            select.setString(1,login);
            ResultSet rs = select.executeQuery();
            if (!rs.isBeforeFirst()) {
                return null;
            }
            while(rs.next()) {
                cardsList.add(new Card(rs.getString(1),rs.getString(2)));
            }


        } catch (SQLException e) {
            e.printStackTrace();
        }
        OracleDAOFactory.close(con);
        return cardsList.toArray(new Card[cardsList.size()]);







    }

    @Override
    public boolean insertCard(Card card) {
        return false;
    }

    @Override
    public boolean updateCard(Card card) {
        return false;
    }

    @Override
    public boolean deleteCard(Card card) {
        return false;
    }

    @Override
    public Card selectBy() {
        return null;
    }
}