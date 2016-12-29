package fpm.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Validation {



    private static final String PATTERN_EMAIL = "([A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6})";
    private static final String PATTERN_LOGIN = "[A-Za-z0-9_\\.\\-]{4,30}";
    private static final String PATTERN_CARDNO = "[0-9]{16}";
    private static final String PATTERN_NAME = "[0-9a-zA-Z_\\- ]{5,30}";
    //private static final String PATTERN_EMAIL = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@" +
    //       "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
    private static final String PATTERN_PHONE = "[0-9]{10}";
    private static final String PATTERN_PASS = "[^ ]{5,}";


    public static boolean isValidEmail(final String email) {
        return email.matches(PATTERN_EMAIL);
    }

    public static boolean isValidLogin(final String login) {
        return login.matches(PATTERN_LOGIN);
    }

    public static boolean isValidCardNo(final String cardNo) {
        return cardNo.matches(PATTERN_CARDNO);
    }

    public static boolean isValidName(final String name) {
        return name.matches(PATTERN_NAME);
    }

    public static boolean isValidPhone(final String phone) {
        return phone.matches(PATTERN_PHONE);
    }

    public static boolean isValidPass(final String pass) {
        return pass.matches(PATTERN_PASS);
    }


}
