package com.kpi.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Ann on 20.12.2016.
 */
@WebServlet("/index") /*где он сам живет*/
public class Index extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getSession().invalidate();

        req.getRequestDispatcher("index.jsp").forward(req, resp); /*куда отправляет он всех*/
    }
}
