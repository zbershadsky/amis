package fpm.entities;

/**
 * Created by Guest on 24.12.2016.
 */
public class Card {

    private String cardNo;
    private String token;
    private String cardName;

    public Card(String cardNo, String cardName, String token) {
        this.cardNo=cardNo;
        this.cardName=cardName;
        this.token = token;
    }



    public Card(String cardNo, String cardName) {
        this.cardNo=cardNo;
        this.cardName=cardName;
    }

    public String getCardNo() {
        return cardNo;
    }

    public String getName() {
        return cardName;
    }

    public String getToken() {
        return token;
    }

}
