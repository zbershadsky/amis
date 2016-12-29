package fpm.servlets;

import fpm.crypt.Crypt;
import fpm.dao.interfaces.UserDAO;
import fpm.dao.oracle.OracleDAOFactory;
import fpm.entities.Status;
import fpm.entities.User;
import fpm.util.Validation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/reg")
public class Registration extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        resp.setContentType("text/plain");
        String check = req.getParameter("check");
        String field = req.getParameter(check);
        OracleDAOFactory oracleDaoFactory = new OracleDAOFactory();
        UserDAO userDao = oracleDaoFactory.getUserDAO();
        PrintWriter out = resp.getWriter();


            if (userDao.isAlreadyExists(field,"login".equals(check))) {
                out.write("exists");
            }
            else {
                out.write("ok");

            }
        out.close();
    return;


    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        String email = req.getParameter("email");
        String pass = req.getParameter("password");
        String login = req.getParameter("login");

        if (!Validation.isValidLogin(login)) {
            req.setAttribute("isValidLogin","invalid");
        }

        if (!Validation.isValidEmail(email)) {
            req.setAttribute("isValidEmail","invalid");
        }

        if (!Validation.isValidPass(pass)) {
            req.setAttribute("isValidPass","invalid");
        }

        String[] hashSalt = Crypt.crypt(pass);
        User newUser = new User(login,email,hashSalt[0],hashSalt[1],Status.UNCONFIRMED);
        OracleDAOFactory oracleDaoFactory = new OracleDAOFactory();
        UserDAO userDao = oracleDaoFactory.getUserDAO();
        if (userDao.isAlreadyExists(login,true)) {
            return;
        }

        int newUserNo = userDao.insertUserWithPassword(newUser,hashSalt[0],hashSalt[1]);
        if (newUserNo>0) {

            PrintWriter out = resp.getWriter();
            out.write("success");

        }
        else {
            PrintWriter out = resp.getWriter();
            out.write("fail");
        }




    }
}
