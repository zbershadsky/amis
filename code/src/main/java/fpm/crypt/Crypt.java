package fpm.crypt;

import java.io.UnsupportedEncodingException;
import java.security.SecureRandom;

/**
 * Created by Guest on 25.12.2016.
 */
public class Crypt {

    private static String localParam = "HappyNewYear";

    public static String[] crypt(String password) throws UnsupportedEncodingException {


        String salt = BCrypt.gensalt(12);
        String fullsalt = salt.concat(localParam);
        String hash = BCrypt.hashpw(password,fullsalt);
        String arr[] = new String[2];
        arr[0] = hash;
        arr[1] = salt;
        return arr;

    }

    public static String getHash(String password,String salt) {
        String fullsalt = salt.concat(localParam);
        String hash = BCrypt.hashpw(password,fullsalt);
        return hash;
    }


}
