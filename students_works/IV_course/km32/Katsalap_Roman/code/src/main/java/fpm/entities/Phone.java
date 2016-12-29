package fpm.entities;

/**
 * Created by Roma on 29.12.2016.
 */
public class Phone {

    private String phoneNumber;
    private String phoneName;

    public Phone(String phoneNumber, String phoneName) {
        this.phoneName = phoneName;
        this.phoneNumber = phoneNumber;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }
    public String getPhoneName() {
        return phoneName;
    }

}
