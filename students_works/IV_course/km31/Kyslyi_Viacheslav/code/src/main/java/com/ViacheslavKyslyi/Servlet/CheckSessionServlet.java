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

public class CheckSessionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        JSONObject  resultJson = new JSONObject();

        HttpSession session = req.getSession();

        resultJson.put("login", session.getAttribute("userLogin"));

        PrintWriter out = resp.getWriter();
        out.print(resultJson.toString());
    }

}
