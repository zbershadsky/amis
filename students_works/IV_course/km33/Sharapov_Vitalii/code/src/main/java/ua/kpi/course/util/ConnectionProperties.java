package ua.kpi.course.util;

import java.io.*;
import java.util.Properties;

public class ConnectionProperties {

    public static final String DRIVER;
    public static final String URL;
    public static final String LOGIN;
    public static final String PASSWORD;

    static {
        Properties properties = new Properties();
        try {
            ClassLoader classloader = Thread.currentThread().getContextClassLoader();
            InputStream input = classloader.getResourceAsStream("connection.properties");
            properties.load(input);
        } catch (IOException e) {
            e.printStackTrace();
        }

        DRIVER = properties.getProperty("driver");
        URL = properties.getProperty("url");
        LOGIN = properties.getProperty("login");
        PASSWORD = properties.getProperty("password");

        System.out.println(DRIVER);
        System.out.println(URL);
        System.out.println(LOGIN);
        System.out.println(PASSWORD);
    }

    public static void main(String[] args) {
        try {
            FileOutputStream file = new FileOutputStream("connection.properties");

            Properties properties = new Properties();

            properties.setProperty("driver", "oracle.jdbc.OracleDriver");
            properties.setProperty("url", "jdbc:oracle:thin:@//localhost:1521/orcl");
            properties.setProperty("login", "vitaly");
            properties.setProperty("password", "q");

            properties.store(file, null);
            file.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
