package com.devcolibri.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.Locale;

@WebServlet("/")
public class Servletdemo extends HttpServlet
{

    String DRIVER = "oracle.jdbc.driver.OracleDriver";
    String DB_HOST = "localhost";
    String DB_PORT = "1521";
    String DB_SERVICE = "XE";
    String DB_USER = "ira";
    String DB_PASS = "ira";
    String DB_DRIVER = "jdbc:oracle:thin:@";
    public void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {

        String TABLE = request.getParameter("table");


        String SQL = "select * FROM TABLE1";


        try
        {

            Class.forName (DRIVER);
        }
        catch (ClassNotFoundException e)
        {

        }
        try
        {
            Locale.setDefault(Locale.ENGLISH);

            Connection con = DriverManager.getConnection(DB_DRIVER + DB_HOST + ":" + DB_PORT + ":" + DB_SERVICE, DB_USER, DB_PASS);

//            con.setTransactionIsolation( con.TRANSACTION_READ_UNCOMMITTED );
            DatabaseMetaData dma = con.getMetaData ();

            String URL= dma.getURL();
            String DriverName = dma.getDriverName();
            String DriverVersion = dma.getDriverVersion();

            Statement stmt = con.createStatement ();
            ResultSet Rst1 = stmt.executeQuery (SQL);

            ResultSetMetaData rsmd = Rst1.getMetaData ();
            int numCols = rsmd.getColumnCount ();

            response.setContentType("text/html; charset=windows-1251");
            PrintWriter out = response.getWriter();

            out.println("<HTML>");
            out.println("<HEAD>");
            out.println("<TITLE>Таблица</title>");
            out.println("<META http-equiv=\"Content-Type\" content='text/html; charset=windows-1251'>");
            out.println("</head>");
            out.println("<BODY>");
            out.println("<P><H3>Таблица: " + TABLE + "</H3></P>");
            out.println("<P><TABLE border=1  cellSpacing=2 cellPadding=2>");

            int numCols1=numCols+1;
            out.println("<TR>");
            out.println("<TD style=\"font-size:9pt\" align=center colspan="+numCols1+">");
            out.println("Имена полей");
            out.println("</TD>");
            out.println("</TR>");
            out.println("<TR>");

            out.println("<TD style=\"font-size:9pt\" rowspan=3>" + "№ п/п" + "</TD>");

            for (int i=1; i<=numCols; i++)
            {
                out.println("<TD style=\"font-size:9pt\">" +i+". "+ rsmd.getColumnLabel(i) + "</TD>");
            }
            out.println("</TR>");

            out.println("<TR>");
            out.println("<TD style=\"font-size:9pt\" align=center colspan="+numCols+">");
            out.println("Тип поля");
            out.println("</TD>");
            out.println("</TR>");
            out.println("<TR>");
            String typeName = new String("");
            for (int i=1; i<=numCols; i++)
            {
                int iTip = rsmd.getColumnType(i);
                String sTip = "";

                if ( iTip == 93)
                    sTip = "DateTime ";
                if ( iTip == 1 )
                    sTip = "CHAR";
                if ( iTip == 5)
                    sTip = "Int";
                out.println("<TD style=\"font-size:9pt\">" + sTip + "</TD>");
            }
            out.println("</TR>");

            int stringCounter=0;
            stringCounter = 0;
            String[][] fields = new String[0][];
            while (Rst1.next())
            {
                for (int j=1; j<=numCols; j++)
                    fields [stringCounter][j] = Rst1.getString(j);

                stringCounter++;
            }

            for (int i=0; i<stringCounter; i++)
            {

                out.println("<TR>");
                out.println("<TD style=\"font-size:9pt\">" + i + "</TD>");
                for (int j=1; j<=numCols; j++)
                {
                    out.println("<TD style=\"font-size:9pt\">" + fields [i][j] + "</TD>");
                }
                out.println("</TR>");
            }
            out.println("</TABLE></P>");

            out.print("<form id=\"loginForm\" style=\"visibility: visible; color: #6F6D6F\" method=\"post\"\n" +
                    "                                          action=\"/auth\">\n" +
                    "                                        <table>\n" +
                    "                                            <tr>\n" +
                    "                                                <td>Email:</td>\n" +
                    "                                                <td><input name=\"email\" type=\"email\" maxlength=\"40\" id=\"emailLog\"\n" +
                    "                                                           required></td>\n" +
                    "                                            </tr>\n" +
                    "                                            <tr>\n" +
                    "                                                <td>Пароль:</td>\n" +
                    "                                                <td><input name=\"pass\" type=\"password\" pattern=\"^[_A-Za-z0-9]+\"\n" +
                    "                                                           minlength=\"8\" maxlength=\"16\" id=\"passLog\" required></td>\n" +
                    "                                            </tr>\n" +
                    "                                            <tr>\n" +
                    "                                                <td></td>\n" +
                    "                                                <td>\n" +
                    "                                                    <input type=\"submit\" value=\"Вхід\"></td>\n" +
                    "                                            </tr>\n" +
                    "                                        </table>\n" +
                    "                                    </form>" +
                    " <form action=\"/reg\" method=\"post\" enctype=\"text/plain\">\n" +
                    "  <p><input type=\"submit\" class=\"btn btn-success\" value=\"Registration\"></p>\n" +
                    " </form> ");

            out.println("</body>");
            out.println("</html>");
            out.close();

            Rst1.close();

            stmt.close();

            con.close();
        }
        catch (SQLException ex)
        {
            while (ex != null)
            {
                System.out.println ("\n*** Error. SQLException! ***\n");
                System.out.println ("SQLState: " + ex.getSQLState());
                String ErrorMessage = ex.getMessage();
                System.out.println ("Message: " + ErrorMessage);
                System.out.println ("Vendor: " + ex.getErrorCode());
                response.setHeader("Cache-Control","no-cache");
                response.setHeader("Pragma","no-cache");
                response.setHeader("Cache-Control","no-store");
                //*****************************************************************
                response.setContentType("text/html; charset=windows-1251");
                PrintWriter out = response.getWriter();
                out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">");

                out.println("<HTML>");
                out.println("<HEAD>");
                out.println("<TITLE></TITLE>");
                out.println("<META http-equiv=pragma content=no-cashe>");

                out.println("<LINK href=\"../css/\" type=text/css rel=stylesheet>");
                        out.println("<META http-equiv=Content-Type content=\"text/html; charset=windows-1251\">");
                out.println("<META content=\"MSHTML 6.00.2715.400\" name=GENERATOR></HEAD>");
                out.println("<SCRIPT Language=\"JavaScript\">");
                out.println("<!--");
                out.println("//---------------------------------------------------");
                out.println("function before_submiting()");
                out.println("{");
                out.println("document.form01.hindex_poezda.value = document.form01.index_spisok.value.substring(0,15);");
                out.println("document.form01.submit();");
                out.println("}");
                out.println("-->");
                out.println("</script>");
                out.println("</HEAD>");
                out.println("<BODY bottomMargin=0 leftMargin=0 topMargin=0 rightMargin=0 marginwidth=\"0\"");
                out.println("marginheight=\"0\">");
                out.println("<TABLE");
                out.println("class=HeadBg id=Header width=\"100%\" border=0>");
                out.println("<TBODY>");
                out.println("<TR align=top>");
                out.println("<TD style=\"font-size:9pt\" class=SiteLink align=right colSpan=4>");
                out.println("<SPAN style=\"COLOR: silver\">");

                out.println("</SPAN>");
                out.println("&nbsp;");
                out.println("</TD>");
                out.println("</TR>");
                out.println("<TR>");
                out.println("<TD style=\"font-size:9pt\">");
                out.println("<IMG height=44 alt=\"\" src=\"../images/BF2.GIF\" width=206");
                out.println("border=0>");
                out.println("&nbsp;");
                out.println("<A href=\"../index.html\">");
                out.println("Начало");
                out.println("</A>");
                out.println("</TD>");
                out.println("<TD style=\"font-size:9pt\" vAlign=bottom align=left>");
                out.println("<H1>");
                out.println("Поезда");
                out.println("</H1>");
                out.println("</TD>");
                out.println("</TR>");
                out.println("</TBODY>");
                out.println("</TABLE>");
                out.println("<P>");
                out.println("<TABLE class=ttitle width=800 align=center>");
                out.println("<TBODY>");
                out.println("<TR>");
                out.println("<TD style=\"font-size:9pt\">");
                out.println("<TABLE class=ttitle width=800 align=center>");
                out.println("<TBODY>");
                out.println("</tbody>");
                out.println("</TABLE>");
                out.println("</TD>");
                out.println("</TR>");
                out.print("<FORM name=form01 action=\"../index_Demo.htm\" ");
                out.print("method=\"post\">");
                out.println("<P>");
                out.println("Сообщение об ошибке: "+ErrorMessage);
                out.println("</FORM>");
                out.println("</BODY>");
                out.println("</HTML>");
                ex = ex.getNextException ();
            }
        }
    }
}