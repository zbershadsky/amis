import Databases.SQLiteClass;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;

import static Databases.SQLiteClass.getDBConnection;

@WebServlet(name = "MainServlet")

public class MainServlet extends HttpServlet {



    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        if (dispatcher != null) {
            dispatcher.forward(request, response);
        }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("00000");

        //витягуємо команду
        String command_str = request.getParameter("command");
        int command = Integer.parseInt(command_str);
        System.out.println(command);

        switch (command) {

            //закриваєм сесію, натиснувши на кнопку "вихід"
            case 0: {
                request.getSession().invalidate();
                response.sendRedirect("error_logIn.html");
            }
            break;

            //процес реєстрації
            case 1: {

                //витягуєм із запиту параметри полів
                Object kode_reg_obj = request.getParameter("kode_reg");
                Object password_reg_obj = request.getParameter("password_reg");
                Object name_reg_obj = request.getParameter("name_reg");
                Object email_reg_obj = request.getParameter("email_reg");
                Object tel_reg_obj = request.getParameter("tel_reg");

                String kode_reg = (String) kode_reg_obj;
                String password_reg = (String) password_reg_obj;
                String name_reg = (String) name_reg_obj;
                String email_reg = (String) email_reg_obj;
                String tel_reg = (String) tel_reg_obj;
                System.out.printf("успішно");

                //HttpSession session = request.getSession();
                try {
                    //функція на порівння інд. коду та додавання в таблицю
                    if (add_toDB(kode_reg, password_reg, name_reg, email_reg, tel_reg) == false) {
                        //відповідь
                        response.sendRedirect("error_registration.html");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                response.setContentType("text/html;charset=UTF-8");
                PrintWriter printWriter = response.getWriter();
                printWriter.println(html_welcome);
            }
            break;


            //вхід на сайт
            case 2: {

                System.out.println("виймаємо логін і пароль");
                Object kode_reg_obj = request.getParameter("kode_logIn");
                Object password_reg_obj = request.getParameter("pass_logIn");
                String kode_reg = (String) kode_reg_obj;
                String password_reg = (String) password_reg_obj;
                System.out.println("успішно вийняли логін і пароль");
                System.out.println(kode_reg);

                //перевірка на адміністратора
                if (("1111").equals(kode_reg) && ("admin").equals(password_reg)) {
                    System.out.println("22");
                    response.setContentType("text/html;charset=UTF-8");
                    //PrintWriter printWriter = response.getWriter();
                    System.out.println("успішно створили сесію адміністратора");
                    response.sendRedirect("admin.jsp");
                    System.out.println("finish admin (надіслали сторінку йому)");
                } else {

                    //виконуємо вхід корисутвача якщо він не адмін
                    try {
                        if (kode_reg != null & password_reg != null && true == GetRegistrationUser(kode_reg, password_reg)) {
                            HttpSession session = request.getSession();
                            session.setAttribute("user", kode_reg);
                            response.sendRedirect("index.jsp");
                            System.out.println("Створено сесію користувача");
                        } else {
                            response.sendRedirect("error_logIn.html");
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }


                }
            }
            break;

            //купуємо гост
            case 3: {

                Object kode_reg_objj = request.getParameter("info");
                String ppp = (String) kode_reg_objj;
                System.out.println("123");
                System.out.println(ppp);

                String user_session = (String) request.getSession().getAttribute("user");
                System.out.println("user in site =" + user_session);

                try {
                    Statement statement = null;
                    statement = getDBConnection().createStatement();
                    ResultSet rs = statement.executeQuery("SELECT GENORDERS.NEXTVAL FROM DUAL");

                    int count = 0;
                    while (rs.next()) {
                        count = rs.getInt(1);
                    }

                    System.out.println("count " + count);
                    //Integer key_num = Integer.valueOf(String.valueOf(count + 1));
                    Connection connection;
                    connection = getDBConnection();
                    connection.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
                    PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO " +
                            "ORDERS (CUST_NALOGCODE,ORDER_DATE,ORDER_NUM) " +
                            "VALUES (?,?,?)");

                    preparedStatement.setString(1, user_session);
                    preparedStatement.setString(2, getDate());
                    preparedStatement.setInt(3, count);
                    preparedStatement.executeUpdate();
                    preparedStatement.close();
                    connection.commit();
                    connection.close();

                    System.out.println("insert order");

                    System.out.println(count);
                    System.out.println(getDate());
                    System.out.println(String.valueOf(1));
                    System.out.println(String.valueOf(100000));
                    preparedStatement = null;
                    connection = getDBConnection();
                    connection.setTransactionIsolation(Connection.TRANSACTION_READ_COMMITTED);
                    preparedStatement = connection.prepareStatement("INSERT INTO " +
                            "ORDERITEMS (ORDER_NUM,CAR_ID,QUANTITY,ITEM_PRICE) " +
                            "VALUES (?,?,?,?)");
                    preparedStatement.setInt(1, count);
                    preparedStatement.setString(2, "2");
                    preparedStatement.setString(3, String.valueOf(1));
                    preparedStatement.setString(4, String.valueOf(130000));
                    preparedStatement.executeUpdate();
                    preparedStatement.close();
                    connection.commit();
                    connection.close();

                    System.out.println("insert orderItems");

                } catch (SQLException e) {
                    e.printStackTrace();
                }
                System.out.println("step2");
                response.sendRedirect("insert_order.jsp");
            }
            break;

            //купуємо фантом
            case 4: {

                Object kode_reg_objj = request.getParameter("info");
                String ppp = (String) kode_reg_objj;
                System.out.println("123");

                String user_session = (String) request.getSession().getAttribute("user");
                System.out.println("user in site =" + user_session);

                try {
                    Statement statement = null;

                    statement = getDBConnection().createStatement();
                    ResultSet rs = statement.executeQuery("SELECT GENORDERS.NEXTVAL FROM DUAL");

                    int count = 0;
                    while (rs.next()) {
                        count = rs.getInt(1);
                    }

                    System.out.println("count " + count);
                    Connection connection;
                    connection = getDBConnection();
                    connection.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
                    PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO " +
                            "ORDERS (CUST_NALOGCODE,ORDER_DATE,ORDER_NUM) " +
                            "VALUES (?,?,?)");
                    System.out.println("1");
                    preparedStatement.setString(1,user_session);
                    System.out.println("2");
                    preparedStatement.setString(2, (String) getDate());
                    System.out.println("3");
                    preparedStatement.setInt(3, count);
                    System.out.println("4");

                    System.out.println("5");
                   preparedStatement.executeUpdate();
                    System.out.println("55");
                    preparedStatement.close();
                    connection.commit();
                    System.out.println("6");
                    connection.close();
                    System.out.println("7");

                    connection = getDBConnection();
                    connection.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
                    preparedStatement = connection.prepareStatement("INSERT INTO " +
                            "ORDERITEMS (ORDER_NUM,CAR_ID,QUANTITY,ITEM_PRICE) " +
                            "VALUES (?,?,?,?)");
                    System.out.println("8");
                    preparedStatement.setInt(1, count);
                    System.out.println("9");
                    preparedStatement.setString(2, "1");
                    System.out.println("10");

                    preparedStatement.setString(3, String.valueOf(1));
                    System.out.println("11");

                    preparedStatement.setString(4, String.valueOf(130000));
                    System.out.println("12");

                    preparedStatement.executeUpdate();
                    System.out.println("13");

                    preparedStatement.close();
                    System.out.println("14");

                    connection.commit();
                    System.out.println("15");

                    connection.close();
                    System.out.println("16");

                } catch (SQLException e) {
                    e.printStackTrace();
                    try {
                        getDBConnection().rollback();
                    } catch (SQLException e1) {
                        e1.printStackTrace();
                    }
                }
                System.out.println("step2");
                response.sendRedirect("insert_order.jsp");

            }
            break;


            //змінюємо нформацію про користувача користувача
            case 5: {
                String user_session = (String) request.getSession().getAttribute("user");
                Object new_pass_obj = request.getParameter("new_pass");
                String new_pass = (String) new_pass_obj;
                try {
                    if (new_pass != null && UpdatUserPass(new_pass, user_session)) {
                        response.sendRedirect("delete_user_commit.html");
                        System.out.println("Пароль оновлено");
                    } else {
                        response.sendRedirect("error_logIn.html");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }


            }
            break;

            case 6:{
                System.out.println("delete order");
                 String user_session = (String) request.getSession().getAttribute("user");
                String pas_valid_delete = (String)request.getParameter("pas_valid_delete");

                System.out.println(user_session);
                System.out.println(pas_valid_delete);
                try {

                    if (GetRegistrationUser(user_session,pas_valid_delete)){

                          System.out.println("пароль співпав");
                        int codes = Integer.parseInt(user_session);
                        Connection connection;
                        connection = SQLiteClass.getDBConnection();
                        connection.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
                        PreparedStatement preparedStatement = connection.prepareStatement("delete from ORDERITEMS\n" +
                                "where ORDERITEMS.CAR_ID = 1 \n" +
                                "and ORDER_NUM in\n" +
                                "(select ORDERS.ORDER_NUM \n" +
                                "from ORDERS\n" +
                                "join CUSTOMERS on CUSTOMERS.CUST_NALOGCODE = ORDERS.CUST_NALOGCODE\n" +
                                "where ORDERS.CUST_NALOGCODE = (?))");

                          preparedStatement.setString(1, String.valueOf(codes));
                          preparedStatement.executeUpdate();
                          System.out.println("2222222222");
                          preparedStatement.close();
                          System.out.println("видалення із Orderitem успішне");
                          connection.commit();
                          System.out.println("commit");
                          connection.close();
                          System.out.printf("finish");

                        System.out.println("12345432");
                        preparedStatement = null;
                        connection = SQLiteClass.getDBConnection();
                        connection.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
                         preparedStatement = connection.prepareStatement("DELETE FROM Orders  \n" +
                                 " WHERE Orders.CUST_NALOGCODE = (?)\n" +
                                 " AND Orders.order_num NOT IN\n" +
                                 "  (SELECT OrderItems.order_num FROM OrderItems WHERE OrderItems.order_num = Orders.order_num)");
                        System.out.println("11111111");
                        preparedStatement.setString(1, String.valueOf(codes));
                        preparedStatement.executeUpdate();
                        System.out.println("2222222222");
                        preparedStatement.close();
                        System.out.println("видалення із Ордерітемс успішне");
                        connection.commit();
                        connection.close();
                        System.out.printf("finish");
                        response.sendRedirect("delete_user_commit.html");
                    } else {
                        System.out.println("error pas");
                        response.sendRedirect("error_verificate_pass.html");}
                } catch (SQLException e) {
                    e.printStackTrace();
                }
               // response.sendRedirect("delete_user_commit.html");
            }
            break;
            //видаляємо замовлення госта
            case 7:{
                System.out.println("delete with order  gost");
                String user_session = (String) request.getSession().getAttribute("user");
                String pas_valid_delete = (String)request.getParameter("pas_valid_delete");

                System.out.println(user_session);
                System.out.println(pas_valid_delete);
                try {

                    if (GetRegistrationUser(user_session,pas_valid_delete)){
                        System.out.println("пароль співпав");
                        int codes = Integer.parseInt(user_session);
                        Connection connection;
                        connection = SQLiteClass.getDBConnection();
                        connection.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
                        PreparedStatement preparedStatement = connection.prepareStatement("delete from ORDERITEMS\n" +
                                "where ORDERITEMS.CAR_ID = 2 \n" +
                                "and ORDER_NUM in\n" +
                                "(select ORDERS.ORDER_NUM \n" +
                                "from ORDERS\n" +
                                "join CUSTOMERS on CUSTOMERS.CUST_NALOGCODE = ORDERS.CUST_NALOGCODE\n" +
                                "where ORDERS.CUST_NALOGCODE = (?))");

                        preparedStatement.setString(1, String.valueOf(codes));
                        preparedStatement.executeUpdate();
                        System.out.println("2222222222");
                        preparedStatement.close();
                        System.out.println("видалення із Order успішне");
                        connection.commit();
                        System.out.println("commit");
                        connection.close();
                        System.out.printf("finish");

                        System.out.println("12345432");
                        preparedStatement = null;
                        connection = SQLiteClass.getDBConnection();
                        connection.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
                        preparedStatement =connection.prepareStatement("DELETE FROM Orders  \n" +
                                " WHERE Orders.CUST_NALOGCODE = (?)\n" +
                                " AND Orders.order_num NOT IN\n" +
                                "  (SELECT OrderItems.order_num FROM OrderItems WHERE OrderItems.order_num = Orders.order_num)");
                        System.out.println("11111111");
                        preparedStatement.setString(1, String.valueOf(codes));
                        preparedStatement.executeUpdate();
                        System.out.println("2222222222");
                        preparedStatement.close();
                        System.out.println("видалення із Ордерітемс успішне");
                        connection.commit();
                        connection.close();
                        System.out.printf("finish");
                        response.sendRedirect("delete_user_commit.html");
                    } else {
                        System.out.println("error pas");
                        response.sendRedirect("error_verificate_pass.html");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            break;
            //якщо адімін
            case 8:{
                System.out.println("step1");
                Statement statement = null;
                PrintWriter out = response.getWriter();

                try {
                    Connection connection;
                    connection = SQLiteClass.getDBConnection();
                    connection.setTransactionIsolation(Connection.TRANSACTION_READ_COMMITTED);
                    statement = connection.createStatement();
                    ResultSet rs = statement.executeQuery("SELECT NAMES, CODE, PHOHE, EMAIL FROM CUST_FOR_ADMIN ");
                    System.out.println("step2");
                    response.setContentType("text/html;charset=UTF-8");
                    out.println("<html>");
                    out.println("<head>");
                    out.println("<title>admin</title>");
                    out.println("</head>");
                    out.println("<body>");
                    out.println("<center>");
                    out.println("<h1>USERS INFO</h1>");
                    out.println("</center>");
                    out.println("<table  border='1' align='center'>");
                    out.println("<tr>");
                    out.println("<td>CODE</td>");
                    out.println("<td>NAME</td>");
                    out.println("<td>PHONE</td>");
                    out.println("<td>EMAIL</td>");
                    out.println("</tr>");
                    while (rs.next()) {

                        String nalogcode_user =  rs.getString("CODE");
                        String name_user = rs.getString("NAMES");
                        String phone_user = rs.getString("PHOHE");
                        String email_user = rs.getString("EMAIL");

                        out.println("<tr>");
                        out.println("<td>"+nalogcode_user +"</td>");
                        out.println("<td>"+name_user +"</td>");
                        out.println("<td>"+phone_user +"</td>");
                        out.println("<td>"+email_user +"</td>");
                        out.println("</tr>");

                    }
                    out.println("</table>");
                    out.println("<center>");
                    out.println("<h1>ORDERS INFO</h1>");
                    out.println("</center>");
                    out.println("<table  border='1' align='center'>");
                    out.println("<tr>");
                    out.println("<td>NAME</td>");
                    out.println("<td>DATE</td>");
                    out.println("<td>CAR_ID</td>");
                    out.println("<td>QUANTITY</td>");
                    out.println("</tr>");
                    statement.close();
                    connection.close();
                    Statement statement1;

                    connection = SQLiteClass.getDBConnection();
                    connection.setTransactionIsolation(Connection.TRANSACTION_READ_COMMITTED);
                    statement1 = connection.createStatement();

                    ResultSet rerset = statement1.executeQuery("SELECT NAMES, ORDEEDATE, NUMBERS, QUANTITY FROM ORDER_FOR_ADMIN");
                    System.out.println("step4");
                    while (rerset.next()) {
                        String name_user_order = rerset.getString("NAMES");
                        String order_date = rerset.getString("ORDEEDATE");
                        String numbers_user = rerset.getString("NUMBERS");
                        String quantity = rerset.getString("QUANTITY");

                        out.println("<tr>");
                        out.println("<td>"+name_user_order+"</td>");
                        out.println("<td>"+order_date +"</td>");
                        out.println("<td>"+numbers_user +"</td>");
                        out.println("<td>"+quantity +"</td>");
                        out.println("</tr>");

                    }
                    out.println("</table>");
                    out.println("<a  href=\"admin.jsp\" title=\"Назад\">Back</a>");
                    out.println("</body>");
                    out.println("</html>");
                    statement1.close();
                    connection.close();
                    rerset.close();
                        } catch (SQLException e) {
                    e.printStackTrace();
                }finally {
                    out.close();
                }
            }break;
            //udate name
            case 9: {
                String user_session = (String) request.getSession().getAttribute("user");
                Object new_name_obj = request.getParameter("new_name");
                String new_name = (String) new_name_obj;
                try {
                    if (new_name != null && UpdateUserName(new_name, user_session)) {
                        response.sendRedirect("delete_user_commit.html");
                        System.out.println("Name оновлено_");
                    } else {
                        response.sendRedirect("error_logIn.html");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }break;

            //змінюємо пошту
            case 10: {
                String user_session = (String) request.getSession().getAttribute("user");
                Object new_name_obj = request.getParameter("new_email");
                String new_email = (String) new_name_obj;
                try {
                    if (new_email != null && UpdatUserEmail(new_email, user_session)) {
                        response.sendRedirect("delete_user_commit.html");
                        System.out.println("Email оновлено_");
                    } else {
                        response.sendRedirect("error_logIn.html");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }break;

            }
    }

    private boolean UpdatUserEmail(String new_email, String user_session) throws SQLException {
        System.out.println("step1 ");
        System.out.println(new_email);
        System.out.println(user_session);
        try {
            System.out.println("починаємо змінювати ");
            Connection connection = SQLiteClass.getDBConnection();
            connection.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
            PreparedStatement preparedStatement = getDBConnection().prepareStatement("UPDATE CUSTOMERS" +
                    " SET CUST_EMAIL = (?) WHERE CUST_NALOGCODE = ?");

            preparedStatement.setString(1, new_email);
            preparedStatement.setString(2, user_session);
            preparedStatement.executeUpdate();
            preparedStatement.close();

            System.out.println("зміна успішна");
            connection.commit();
            connection.close();
            System.out.printf("finish");
        } catch (Exception e) {
            System.out.println(e);
            getDBConnection().rollback();
            return false;
        }
        System.out.println("метод відпрацював");
        return true;
    }

    private boolean UpdateUserName(String new_name, String user_session) throws SQLException {
        System.out.println("step1");
        System.out.println(new_name);
        System.out.println(user_session);
        try {
            System.out.println("починаємо змінювати");

            Connection connection = SQLiteClass.getDBConnection();
            connection.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE CUSTOMERS" +
                    " SET CUST_NAME = (?) WHERE CUST_NALOGCODE = ?");

            preparedStatement.setString(1, new_name);
            preparedStatement.setString(2, user_session);
            preparedStatement.executeUpdate();
            preparedStatement.close();

            System.out.println("зміна успішна");
            connection.commit();
            connection.close();
            System.out.printf("finish");
        } catch (Exception e) {
            System.out.println(e);
            getDBConnection().rollback();
            return false;
        }
        System.out.println("метод відпрацював");
        return true;
    }


    private boolean UpdatUserPass(String new_pass, String user_session) throws SQLException {
        System.out.println("step1");
        System.out.println(new_pass);
        System.out.println(user_session);
        try {
            System.out.println("починаємо змінювати");
            Connection connection;
            connection = SQLiteClass.getDBConnection();
            connection.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE CUSTOMERS" +
                    " SET CUST_PASS = (?) WHERE CUST_NALOGCODE = ?");

            preparedStatement.setString(1, new_pass);
            preparedStatement.setString(2, user_session);
            preparedStatement.executeUpdate();
            preparedStatement.close();

            System.out.println("зміна успішна");
            connection.commit();
            connection.close();
            System.out.printf("finish");
        } catch (Exception e) {
            System.out.println(e);
            getDBConnection().rollback();
            return false;
        }
        System.out.println("метод відпрацював");
        return true;
    }


    public String getDate (){
        Date d = new Date();
        SimpleDateFormat format1 = new SimpleDateFormat("dd.MM.yyyy hh:mm");
        return format1.format(d);
    }

    private Boolean GetRegistrationUser(String kode_reg, String password_reg) throws SQLException {
        System.out.println("step1");
        System.out.println(kode_reg);
        System.out.println(password_reg);
        Connection connection;
        connection = getDBConnection();
        connection.setTransactionIsolation(Connection.TRANSACTION_READ_COMMITTED);
        Statement statement = connection.createStatement();
        ResultSet rs = statement.executeQuery("SELECT CUST_NALOGCODE, CUST_PASS FROM ICHANSKIYOLEXANDR.CUSTOMERS");
        System.out.println("step2");
        Boolean a = false;

        while (rs.next()) {
            String nalogcode =  rs.getString("CUST_NALOGCODE");
            String cust_pass = rs.getString("CUST_PASS");
            System.out.println(nalogcode);
            System.out.println(cust_pass);
            if (kode_reg.equals(nalogcode) && password_reg.equals(cust_pass)) {
                System.out.println(nalogcode);
                System.out.println(cust_pass);
                a = true;
                break;
            } else {
                a = false;
            }
        }rs.close();
        connection.commit();
        connection.close();
        System.out.println("step3");
        System.out.println(a);
        return a;
    }

        public static boolean add_toDB (String kode_reg, String password_reg, String name_reg, String email_reg, String
        tel_reg) throws SQLException {
                System.out.println("step0");
                PreparedStatement preparedStatement = null;
                //SQLiteClass.getDBConnection().setTransactionIsolation(Connection.);
                Connection connection;
                connection = getDBConnection();
                connection.setTransactionIsolation(Connection.TRANSACTION_READ_COMMITTED);
                Statement statement = connection.createStatement();
                ResultSet rs = statement.executeQuery("SELECT CUST_NALOGCODE FROM ICHANSKIYOLEXANDR.CUSTOMERS");
                while (rs.next()) {
                    String nalogcode = rs.getString("CUST_NALOGCODE");

                    if (nalogcode.equals(kode_reg)) {
                        return false;
                    }
                }
                rs.close();
                connection.commit();
                connection.close();
                try {
                    System.out.println("step1");
                    connection = getDBConnection();
                    connection.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
                    preparedStatement = connection.prepareStatement("INSERT INTO " +
                            "CUSTOMERS (CUST_NALOGCODE,CUST_PASS,CUST_NAME,CUST_EMAIL,CUST_PHONE) " +
                            "VALUES (?,?,?,?,?)");

                    preparedStatement.setString(1, kode_reg);
                    preparedStatement.setString(2, password_reg);
                    preparedStatement.setString(3, name_reg);
                    preparedStatement.setString(4, email_reg);
                    preparedStatement.setString(5, tel_reg);
                    preparedStatement.executeUpdate();
                    preparedStatement.close();
                    connection.commit();
                    connection.close();
                    System.out.printf("finish");
                } catch (Exception e) {
                    System.out.println(e);
                    connection.rollback();
                }

                return true;
            }




    String html_welcome = "<head>\n" +
            "    <link rel=\"stylesheet\" href=\"css\firstcss.css\" type=\"text/css\"/>\n" +
            "    <link rel=\"stylesheet\" href=\"css/menu.css\" type=\"text/css\"/>\n" +
            "    <link rel=\"stylesheet\" href=\"css/Phantom.css\" type=\"text/css\"/>\n" +
            "    <meta charset=\"UTF-8\">\n" +
            "    <title>WELCOME</title>\n" +
            "</head>\n" +
            "<body class=\"main\">\n" +
            "<div>\n" +
            "    <div>\n" +
            "        <ul class=\"navigation\">\n" +
            "            <li><a href=\"index.jsp\" title=\"Головна\">Головна</a></li>\n" +
            "            <li><a href=\"Galery.jsp\" title=\"Галерея\">Галерея</a></li>\n" +
            "            <li><a href=\"\" title=\"Каталог\">Каталог</a>\n" +
            "                <ul>\n" +
            "                    <li><a href=\"Phantom.jsp\" title=\"Phantom\">Phantom</a></li>\n" +
            "                    <li><a href=\"Ghost.jsp\" title=\"Ghost\">Ghost</a></li>\n" +
            "                    <li><a href=\"\" title=\"Wraith\">Wraith</a></li>\n" +
            "                    <li><a href=\"\" title=\"Tavriya Nova\">Tavriya Nova</a></li>\n" +
            "                </ul>\n" +
            "            </li>\n" +
            "            <li><a href=\"Contact.jsp\" title=\"Contact\">Контакти</a></li>\n" +
            "            <li><a href=\"ayuthorisaton.jsp\" title=\"authorization\">Авторизація</a></li>\n" +
            "\n" +
            "        </ul>\n" +
            "    </div>\n" +
            "\n" +
            "    <style>\n" +
            "        #inner {\n" +
            "            width: 50%;\n" +
            "            position: absolute;\n" +
            "            top: 15%;\n" +
            "            left: 25%;\n" +
            "            height: 40%;\n" +
            "            padding: 10px; /* Поля вокруг текста */\n" +
            "            text-align: center;\n" +
            "\n" +
            "        }\n" +
            "    </style>\n" +
            "    <div align=\"center\" id=\"inner\" >\n" +
            "        <p ><b>Вітаємо!</b>\n" +
            "        <p align=\"center\" class=\"pText\">Шановний користувач, ви успішно зареєстровані. " +
            "Тепер ви можете <a href=\"ayuthorisaton.jsp\" title=\"Увійти\">увійти</a>\n  \n" +
            "\n" +
            "    </div>\n" +
            "</div>\n" +
            "</body>\n" +
            "\n" +
            "</html>\n";
}