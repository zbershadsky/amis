<%--
  Created by IntelliJ IDEA.
  User: Sascha
  Date: 19.12.2016
  Time: 14:53
  To change this template use File | Settings | File Templates.
--%><%
    request.getSession();
    request.getAttribute("name");
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>

    <link rel="stylesheet" href="css/firstcss.css" type="text/css"/>
    <link rel="stylesheet" href="css/menu.css" type="text/css"/>
    <link rel="stylesheet" href="css/Phantom.css" type="text/css"/>
    <script src = "js/DateBase.js" ></script>
    <meta charset="UTF-8">
    <title>Phantom</title>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
    <script src="jquery.js" type="text/javascript"></script>
    <script src="js/DateBase.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/maskinput.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <script type="text/javascript" src="https://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css"
          rel="stylesheet" type="text/css">
    <link href="https://pingendo.github.io/pingendo-bootstrap/themes/default/bootstrap.css"
          rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="css/firstcss.css" type="text/css"/>
    <link href="//fonts.googleapis.com/css?family=Roboto:300,400,500,700" rel="stylesheet" type="text/css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script src="js/script.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>
</head>
<body class="main">
<div>
    <div>
        <ul class="navigation">
            <li><a href="index.jsp" title="Головна">Головна</a></li>
            <li><a href="Galery.jsp" title="Галерея">Галерея</a></li>
            <li><a href="" title="Каталог">Каталог</a>
                <ul>
                    <li><a  href="Phantom.jsp" title="Phantom">Phantom</a></li>
                    <li><a  href="Ghost.jsp" title="Ghost">Ghost</a></li>
                    <li><a href="" title="Wraith">Wraith</a></li>
                    <li><a href="" title="Tavriya Nova">Tavriya Nova</a></li>
                </ul>
            </li>
            <li><a href="Contact.jsp" title="Contact">Контакти</a></li>
            <li><a id="aut" href="ayuthorisaton.jsp" style="display:block" title="authorization">Авторизація</a></li>
            <li id="tmp" style="display:block"> <%= "Ви увійшли як: "+ session.getAttribute("user")%> </li>
            <li>
                <form action="MainServlet" method="post">
                    <input name="command" style="display:none" value="0">
                    <button  value="buygost" type="submit" id="exit" style="display:none">
                        Exit
                    </button></p>
                </form></li>        </ul>
    </div>

    <style>
        #inner {
            width: 50%;
            position: absolute;
            top: 15%;
            left: 25%;
            height: 40%;
            padding: 10px; /* Поля вокруг текста */
            text-align: center;

        }
    </style>
    <div align="center" id="inner" >
        <form action="MainServlet" method="post">
        <p><img width="256" height="256" align="center" src="css/images/female-user-info-icon.png" alt="info" ></p>
            <button type="submit"   class="btn btn-danger">Переглянути інформацію про клієнтів</button>
            <input name="command" style="display:none" value="8">
        </form></div>
</div>
</body>

<script>

    if ('<%= session.getAttribute("user") %>' == 'null')
    {
        document.getElementById('tmp').style.display = "none";
        document.getElementById('tmp2').style.display = "none";
    }
    else
    {
        document.getElementById('exit').style.display = "block";
        document.getElementById('aut').style.display = "none";
    }
</script>
</html>