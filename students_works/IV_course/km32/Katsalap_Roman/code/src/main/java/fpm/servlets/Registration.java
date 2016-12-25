package fpm.servlets;

import fpm.crypt.Crypt;
import fpm.dao.interfaces.UserDAO;
import fpm.dao.oracle.OracleDAOFactory;
import fpm.entities.Status;
import fpm.entities.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/reg")

public class Registration extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String email = req.getParameter("email");
        String pass = req.getParameter("password");
        String login = req.getParameter("login");
        String[] hashSalt = Crypt.crypt(pass);
        User newUser = new User(login,email,hashSalt[0],hashSalt[1],Status.UNCONFIRMED);
        OracleDAOFactory oracleDaoFactory = new OracleDAOFactory();
        UserDAO userDao = oracleDaoFactory.getUserDAO();
        if (userDao.isAlreadyExists(login)) {
            return;
        }

        int newUserNo = userDao.insertUserWithPassword(newUser,hashSalt[0],hashSalt[1]);





    }
}
