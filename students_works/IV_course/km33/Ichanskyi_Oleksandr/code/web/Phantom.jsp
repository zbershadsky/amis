<%
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
</head>
<body class="main">
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
                <form action="UserPage.jsp">
                    <button  value="buygost"  href="UserPage.jsp" id="user_page" style="display:none">
                        Кабінет
                    </button>
                </form>
            </li>
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
        #hz{
            color: greenyellow;
            font-size: 40px;
        }
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
        <p id="hz">Phantom</p>
        <p><img src="css/images/rolls-royce-phantom-05.jpg" alt="Phantom" align="center" width="500" height="382"></p>
        <p align="center" class="pText">Rolls-Royce Phantom — заднеприводный седан класса F. Дебют Ролс-Ройс Фантом состоялся в 2003 году. В 2005 году на автосалоне в Женеве был представлен Ролс-Ройс Фантом с удлиненной колёсной базой «Extended Wheel Base Phantom». Фейслифтинг — 2009 год.

            Габаритные размеры Rolls-Royce Phantom (Ролс-Ройс Фантом)
            длина: 5834 мм, ширина: 1990 мм, высота: 1632 мм, клиренс: мм, база: 3750 мм
            <p align="center">




        <form action="MainServlet" method="post">
            <input name="command" style="display:none" value="4">
        <p align="center"><button  value="buygost" type="submit" id="tmp2" style="display:block">
            <img src="css/images/US-dollar.png" align="center" width="80px" height="35px" alt="buy"
                 style="vertical-align: middle">Купить
        </button></p>
        </form>


    </p>
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
        document.getElementById('user_page').style.display = "block";

    }
</script>
</html>