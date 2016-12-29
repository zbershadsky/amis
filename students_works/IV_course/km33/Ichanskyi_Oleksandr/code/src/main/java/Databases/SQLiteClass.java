package Databases;

import java.sql.*;

public class SQLiteClass {
    public static Connection getDBConnection() throws SQLException {

        try {
            //реєструємо драйвео
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (ClassNotFoundException e) {
            System.out.println(e.getMessage());
        }
            //встановлюємо з'єднання з БД
            Connection dbConnection = null;
            dbConnection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "ICHANSKIYOLEXANDR", "1111");
            return dbConnection;
    }
}

