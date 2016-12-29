package fpm.entities;

/**
 * Created by Guest on 25.12.2016.
 */
public enum Status {
    UNCONFIRMED("UNCONFIRMED") ,
    CONFIRMED("CONFIRMED"),
    BANNED("BANNED"),
    ACTIVE("ACTIVE"),
    RESET("RESET");
    private String state;

    private Status(String state) {
        this.state=state;
    }


    @Override
    public String toString(){
        return state;
    }


    }
