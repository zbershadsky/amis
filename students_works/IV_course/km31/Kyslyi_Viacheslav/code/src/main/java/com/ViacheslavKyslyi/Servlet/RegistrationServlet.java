package com.ViacheslavKyslyi.Servlet;

import org.json.simple.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Types;

public class RegistrationServlet extends HttpServlet {

    private static final int DB_INTERNAL_EXCEPTION_STATUS = 0;
    private static final int DB_LOGIN_CHECK_EXCEPTION_STATUS = 2;
    private static final int DB_SUCCESS = 1;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        JSONObject  resultJson = new JSONObject();
        int         addUserResult;

        try {
            Class.forName("oracle.jdbc.OracleDriver");

            Connection con = DriverManager.getConnection(
                    "jdbc:oracle:thin:@//localhost:1521", "slava", "Ron4swanson");

            con.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);

            CallableStatement addUserCall = con.prepareCall("{call addUser(?, ?, ?, ?, ?, ?)}");

            addUserCall.setString(1, req.getParameter("login"));
            addUserCall.setString(2, req.getParameter("pass"));
            addUserCall.setString(3, req.getParameter("first_name"));
            addUserCall.setString(4, req.getParameter("last_name"));
            addUserCall.setString(5, req.getParameter("email"));

            addUserCall.registerOutParameter(6, Types.INTEGER);

            addUserCall.execute();

            addUserResult = addUserCall.getInt(6);

            switch (addUserResult) {
                case DB_SUCCESS :
                    resultJson.put("status", "success");
                    break;
                case DB_INTERNAL_EXCEPTION_STATUS :
                    resultJson.put("status", "failed");
                    resultJson.put("reason", "internal_DB");
                    break;
                case DB_LOGIN_CHECK_EXCEPTION_STATUS :
                    resultJson.put("status", "failed");
                    resultJson.put("reason", "login_exist");
                    break;
            }

            con.close();

        } catch (Exception e) {
            resultJson.put("status", "failed");
            resultJson.put("reason", "server");
        }

        PrintWriter out = resp.getWriter();
        out.print(resultJson.toString());
    }

}
