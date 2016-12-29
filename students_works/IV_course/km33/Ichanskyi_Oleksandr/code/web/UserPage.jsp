<!--<%
    request.getSession();
    request.getAttribute("name");
%>;
Created by IntelliJ IDEA.
User: Sascha
Date: 22.12.2016
Time: 23:48
To change this template use File | Settings | File Templates.
<%@ page contentType="text/html;charset=UTF-8" language="java" %>-->
<html>
<head>
    <title>Ообистий кабінет</title>

    <meta charset="UTF-8">
    <title>Contact</title>
    <link rel="stylesheet" href="css/firstcss.css" type="text/css"/>
    <link rel="stylesheet" href="css/menu.css" type="text/css"/>
    link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <!-- Optional theme -->
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
    <script src="jquery.js" type="text/javascript"></script>
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
    <!-- Latest compiled and minified JavaScript -->
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
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
<body>
<div class="main">
    <div>
        <ul class="navigation">
            <li><a href="index.jsp" title="Головна">Головна</a></li>
            <li><a href="Galery.jsp" title="Галерея">Галерея</a></li>
            <li><a href="" title="Каталог">Каталог</a>
                <ul>
                    <li><a href="Phantom.jsp" title="Phantom">Phantom</a></li>
                    <li><a href="Ghost.jsp" title="Ghost">Ghost</a></li>
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
                </form></li>

        </ul>
    </div>
    <style>
        #inneriner {
            width: 50%;
            position: absolute;
            top: 17%;
            left: 25%;
            height: 75%;
            text-align: center;
            background-color: #dcff9f;
        }
    </style>
    <div id="inneriner" >
        <br>

        <label><h3>Змінити дані:</h3> </label>

        <br><br><br>

        <label>Ви можете змінити пароль:</label>
        <form role="form" action="MainServlet" class="form-inline" method="post">
            <div class="form-group">
                <input name="new_pass" type="password" class="form-control" id="pass"alt="Пароль має містити лише символи і букви" placeholder="Новий пароль" pattern="[a-zA-Z0-9_]{5,20}">
                <input name="command" style="display:none" value="5">
            </div>
            <button type="submit" class="btn btn-success">Змінити</button>
        </form>

            <br><br>

        <form role="form" action="MainServlet" class="form-inline" method="post">
        <label>Ви можете змінити ім'я</label><br>
            <div class="form-group">
                <input name="new_name" type="text" class="form-control" id="pas" alt="Ім'я має містити лише латинські букви" placeholder="Нове ім'я" pattern="[a-zA-Z0-9_]{5,20}">
                <input name="command" style="display:none" value="9">
            </div>
            <button type="submit" class="btn btn-success">Змінити</button>
        </form>
            <br> <br>
        <form role="form" action="MainServlet" class="form-inline" method="post">
        <label>Ви можете змінити пошту</label><br>
            <div class="form-group">
                <input type="email" name="new_email" id="email" class="form-control" alt="Пошта має бути введена згідно стандарту" placeholder="Пошта"  pattern="(\W|^)[\w.+\-]{0,25}@(yahoo|hotmail|gmail|i)\.com(\W|$)">
                <input name="command" style="display:none" value="10">
            </div>
            <button type="submit" class="btn btn-success">Змінити</button>
        </form>
        <br><br><br>
        <form  action="UserPageOrder.jsp" class="form-inline">
            <label>Ви можете перейти до видалення замовлень</label><br>
            <button type="submit" class="btn btn-success">Перейти</button>
        </form>

    </div>
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
