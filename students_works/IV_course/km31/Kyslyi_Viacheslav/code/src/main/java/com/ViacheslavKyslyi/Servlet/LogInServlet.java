package com.ViacheslavKyslyi.Servlet;

import org.json.simple.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Types;

public class LogInServlet extends HttpServlet {
    private static final int AUTORIZED = 1;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        JSONObject  resultJson = new JSONObject();
        int         userID;

        try {
            Class.forName("oracle.jdbc.OracleDriver");

            Connection con = DriverManager.getConnection(
                    "jdbc:oracle:thin:@//localhost:1521", "slava", "Ron4swanson");

            con.setTransactionIsolation(Connection.TRANSACTION_READ_COMMITTED);

            CallableStatement checkUserCall = con.prepareCall("{call checkUser(?, ?, ?, ?)}");

            checkUserCall.setString(1, req.getParameter("login"));
            checkUserCall.setString(2, req.getParameter("pass"));;

            checkUserCall.registerOutParameter(3, Types.INTEGER);
            checkUserCall.registerOutParameter(4, Types.INTEGER);

            checkUserCall.execute();

            if (checkUserCall.getInt(3) == AUTORIZED) {
                userID = checkUserCall.getInt(4);
                HttpSession session = req.getSession(true);
                session.setAttribute("userID", userID);
                session.setAttribute("userLogin", req.getParameter("login"));
                resultJson.put("autorized", "true");
            } else {
                resultJson.put("autorized", "false");
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
