package fpm.servlets;

import fpm.dao.interfaces.UserDAO;
import fpm.dao.oracle.OracleDAOFactory;
import fpm.entities.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by Guest on 25.12.2016.
 */

@WebServlet("/restore")
public class Restore extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");

        boolean logged = true;
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("loggedInUser") == null) {
            logged = false;
        }

        req.setAttribute("logged",logged);
        resp.setHeader("Cache-Control", "no-cache");
        resp.setHeader("Pragma","no-cache");
        req.getRequestDispatcher("restore.jsp").forward(req,resp);
    }


    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        String login = req.getParameter("login");

        OracleDAOFactory oracleDaoFactory = new OracleDAOFactory();
        UserDAO userDao = oracleDaoFactory.getUserDAO();
        User user = userDao.getUserByLogin(login);

        if  (user != null) {
            // MAIL CONFIRMATION LINK
        }

    }

}
