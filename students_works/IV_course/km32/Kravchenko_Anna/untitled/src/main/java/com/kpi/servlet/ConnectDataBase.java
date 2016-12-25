package com.kpi.servlet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.SQLException;

public class ConnectDataBase {
    public static DataSource connect(String path, String source) throws SQLException {
        DataSource dataSource = null;
        try {
            Context context = (Context) new InitialContext().lookup(path);
            dataSource = (DataSource) context.lookup(source);
        } catch (NamingException e) {
            e.printStackTrace();
        }

        return dataSource;
    }
}
