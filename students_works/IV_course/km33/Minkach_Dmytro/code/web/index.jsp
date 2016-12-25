<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0" />
    <title>Облік відвідуваності</title>
    <link rel="shortcut icon" type="image/x-icon" href="favicon.ico" />
    <!-- CSS  -->
    <link href="css/materialize.min.css" type="text/css" rel="stylesheet" media="screen,projection" />
    <link href="css/style.css" type="text/css" rel="stylesheet" media="screen,projection" />
    <link rel="stylesheet" media="screen" href="handsontable/handsontable.full.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"> </head>

<body>
    <main>
        <% session=request.getSession(false);
            if(session.getAttribute("user_login")==null) {
                response.sendRedirect("login.jsp");
            }
        %>
        <form method="post" action="logout" id="logout"></form>
        <nav class="indigo" role="navigation">
            <div class="nav-wrapper container">
                <ul class="right">
                    <li> <a onclick="document.getElementById('logout').submit()"><i class="material-icons">power_settings_new</i></a> </li>
                </ul>
                <ul class="right">
                    <li> <a href="#"><%= session.getAttribute("user_login")%></a> </li>
                </ul>
            </div>
        </nav>
        <div class="section no-pad-bot" id="index-banner">
            <div class="container">
                <h1 class="header center orange-text">Облік відвідуваності</h1>
                <%--<h5 class="header left indigo-text">Предмет</h5>--%>
                <%--<h5 class="header right indigo-text">Викладач</h5>--%>
                <br>
                <br> </div>
        </div>
        <div class="container">
            <div class="row center">
                <%--<div style="display: inline-block;" id="example"></div>--%>

<form id="form" method="post" action="index">
    <input type="text" id="itemPrice1" maxlength="5" size="5" style="border:none;" name="date" value="<%= session.getAttribute("date")%>" readonly/>
                    <table>
                        <tr>
                            <th>Surname</th>
                            <th>Presence</th>
                        </tr>
                            <%

                                if (session.getAttribute("amount") != null) {
                                Integer amount = (int) session.getAttribute("amount");
                                    List<String> names = (List<String>) session.getAttribute("names");
                                    List<Integer> presences = (List<Integer>) session.getAttribute("presences");
                                    List<String> emails = (List<String>) session.getAttribute("emails");
                                for (int i = 0; i < amount; i++) {
                            %>
                            <tr>
                            <td>
                                <input type="text" style="border:none;" readonly><a href="/user?email=<%= emails.get(i)%>" target="_blank"> <%= names.get(i)%> </a></input>
                            </td>
                                <td>
                                    <input type="text" style="border:none;" name="<%= emails.get(i)%>" value="0" />
                                    <input type="checkbox" id="<%= emails.get(i)%>" name="<%= emails.get(i)%>" value="1" <% if (presences.get(i) == 1) { %>
                                                                                                                              checked
                                                                                                                        <% } else { %>
                                                                                                                        <% } %>/>
                                    <label for="<%= emails.get(i)%>"></label>
                                </td>
                            </tr>
                            <% }} %>

                    </table>

<%--<%= request.getAttribute("date") %>--%>
                <div class="fixed-action-btn" style="bottom: 100px; right: 60px;"> <a class="btn-floating btn-large orange" href="#" onclick="document.getElementById('form').submit()"><i class="material-icons">send</i></a> </div>
</form>
            </div>
        </div>
    </main>
    <footer class="page-footer indigo" style="padding-top: 0px;">
        <div class="container"> Ready </div>
        </div>
        <div class="footer-copyright">
            <div class="container"> Made by <a class="indigo-text text-lighten-3" href="http://materializecss.com">Materialize</a> </div>
        </div>
    </footer>
    <!--  Scripts-->
    <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script src="js/materialize.js"></script>
    <script src="handsontable/handsontable.full.js"></script>
    <script src="js/tablescript.js"></script>

</body>

</html>