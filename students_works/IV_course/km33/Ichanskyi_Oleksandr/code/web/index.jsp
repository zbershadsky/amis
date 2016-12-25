<%
    request.getSession();
    request.getAttribute("name");
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>

    <title>Виготовлення автомобіля</title>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="content-type" content="text/html;charset=UTF-8"/>

    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <script type="text/javascript" src="https://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css"
          rel="stylesheet" type="text/css">
    <link href="https://pingendo.github.io/pingendo-bootstrap/themes/default/bootstrap.css"
          rel="stylesheet" type="text/css">

    <link rel="stylesheet" href="css/firstcss.css" type="text/css"/>
    <link rel="stylesheet" href="css/menu.css" type="text/css"/>

    <link href="//fonts.googleapis.com/css?family=Roboto:300,400,500,700" rel="stylesheet" type="text/css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

    <link rel="stylesheet" type="text/css" href="css/main.css">

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

    <script src="js/script.js"></script>

    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>

</head>

<body class="main">
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
                </button>
            </form></li>

    </ul>
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