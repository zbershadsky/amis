package fpm.servlets;

import fpm.crypt.Crypt;
import fpm.dao.interfaces.UserDAO;
import fpm.dao.oracle.OracleDAOFactory;
import fpm.entities.User;
import fpm.util.Validation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/login")

public class Login extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        resp.setContentType("text/html");
        String login = req.getParameter("login");
        String pass = req.getParameter("password");

        if (!Validation.isValidLogin(login)) {
            req.setAttribute("showErrorMsg",true);
        }
        else {
            OracleDAOFactory oracleDaoFactory = new OracleDAOFactory();
            UserDAO userDao = oracleDaoFactory.getUserDAO();
            User user = userDao.getUserByLogin(login);
            if (user.getHash().equals(Crypt.getHash(pass,user.getSalt()))) {
                req.getSession().setAttribute("loggedInUser", user.getLogin());
                resp.sendRedirect("/services?action=payments");
                return;
            }else {
                req.setAttribute("showErrorMsg",true);
            }
        }

        req.getRequestDispatcher("start.jsp").forward(req, resp);

    }
}
