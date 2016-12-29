package fpm.entities;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.OffsetDateTime;

/**
 * Created by Guest on 24.12.2016.
 */
public class Payment {

    private OffsetDateTime paydate;
    private float amount;
    private String phone;
    private Card card;
    private int id;

    public Payment(OffsetDateTime paydate,float amount,String phone,Card card) {
        this.paydate=paydate;
        this.amount=amount;
        this.phone=phone;
        this.card=card;
    }

    public Payment(OffsetDateTime paydate,float amount,String phone,Card card, int id) {
        this.paydate=paydate;
        this.amount=amount;
        this.phone=phone;
        this.card=card;
        this.id = id;
    }


    public int getID() {
        return this.id;
    }


    public String getPhone() {
        return phone;
    }

    public float getAmount() {
        return amount;
    }

    public OffsetDateTime getDateTime() {
        return paydate;
    }

    public Timestamp getSqlDate() {


        Timestamp ts = Timestamp.from( paydate.toInstant() );
        return ts;
    }

    public Card getCard() {
        return card;
    }




}
