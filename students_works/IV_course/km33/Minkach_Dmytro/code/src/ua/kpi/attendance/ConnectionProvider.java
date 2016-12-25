package ua.kpi.attendance;

/**
 * Created by azaza on 24.12.2016.
 */
import java.sql.*;
import static ua.kpi.attendance.Provider.*;

public class ConnectionProvider {
    private static Connection con=null;
    static{
        try{
            Class.forName(DRIVER);
            con=DriverManager.getConnection(CONNECTION_URL,USERNAME,PASSWORD);
        }catch(Exception e){}
    }

    public static Connection getCon(){
        return con;
    }

}
