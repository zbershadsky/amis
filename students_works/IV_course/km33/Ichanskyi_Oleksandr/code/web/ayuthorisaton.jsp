<%
request.getSession();
request.getAttribute("name");
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>

    <title>authorisation</title>
    <link rel="stylesheet" href="css/firstcss.css" type="text/css"/>
    <link rel="stylesheet" href="css/menu.css" type="text/css"/>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="content-type" content="text/html;charset=UTF-8"/>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
    <script src="jquery.js" type="text/javascript"></script>
    <script src="js/DateBase.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/maskinput.js"></script>
    <script type="text/javascript">
        jQuery(function($){
            $("#tel").mask("+38(999) 999-9999");
        });
    </script>
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

    <script type="text/javascript">
        var visible = true;
        function showFun() {
            if(visible) {
                document.getElementById('inneriner' ).style.display = 'none';
                visible = false;
            } else {
                document.getElementById('inneriner' ).style.display = 'block';
                visible = true;
            }
        }
    </script>
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
            <li><form action="RegServlet" method="get"><input id="exit" title="Exit" style="display:none"  name="exit" value="exit" type="submit"/></form></li>


        </ul>
    </div>
    <style>
        #inner {
            background: blue;
            width: 40%;
            height: 80%;
            position: relative;
            top: 15%;
            left: 31%;
            padding: 30px; /* Поля вокруг текста */
            text-align: center;

        }
    </style>
    <style>
        #inneriner {
            background: #c4ffc0;
            position: absolute;
            left: 0%;
            top: 0%;
          right: 0%;
            bottom: 0%;
            padding: 30px; /* Поля вокруг текста */
                   }
    </style>

    <div id="inner">
        <form class="form-horizontal" role="form" action="MainServlet" method="post">
            <div class="form-group">
                <label for="kode_reg">Індифікаційни код</label>
                <input name="kode_reg"  class="form-control" id="kode_reg"  placeholder="Індифікаційник код (4 цифри)" required pattern="[0-9]{4}">
            </div>
            <div class="form-group">
                <label for="exampleInputPassword1">Пароль</label>
                <input name="password_reg" type="password" class="form-control" id="exampleInputPassword1" placeholder="Пароль (символи і букви не менше 5)" required pattern="[a-zA-Z0-9_]{5,20}">
            </div>
            <div class="form-group">
                <label for="name">Ім'я</label>
                <input name="name_reg"  id="name" class="form-control"  placeholder="Iм'я (лише символи)" required pattern="[A-Za-zА-Яа-я_-]{2,30}[А-Яа-яA-Za-z]{2,30}">
            </div>
            <div class="form-group">
                <label for="email">Пошта</label>
                <input type="email" name="email_reg" id="email" class="form-control" placeholder="Пошта" required pattern="(\W|^)[\w.+\-]{0,25}@(yahoo|hotmail|gmail|i)\.com(\W|$)">
            </div>
            <div class="form-group">
                <label for="email">Номер телефону</label>
                <input type="tel" name="tel_reg" id="tel" class="form-control" placeholder="Мобільний телефон" required>
            </div>
            <input name="command" style="display:none" value="1">

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button  class="btn btn-primar" onclick="showFun()">Назад</button>
                    <button  class="btn btn-primar"  type="submit" >Зареєструватися</button>
                </div>
            </div>
        </form>
        <div id="inneriner" >
            <form class="form-horizontal" role="form" action="MainServlet" method="post">
                <div class="form-group">
                    <label for="kode_logIn">Індифікаційни код</label>
                    <input name="kode_logIn"  class="form-control" id="kode_logIn"  placeholder="Індифікаційник код (4 цифри)" required pattern="[0-9]{4}">
                </div>
                <div class="form-group">
                    <label for="pass_logIn">Пароль</label>
                    <input name="pass_logIn" type="password" class="form-control" id="pass_logIn" placeholder="Пароль (лише цифри і букви - не менше 5)" required pattern="[a-zA-Z0-9_]{5,20}">
                </div>
                <input name="command" style="display:none" value="2">
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="submit" class="btn btn-primar">Увійти</button>
                        <button  class="btn btn-primar" onclick="showFun()">Зареєструватися</button>
                    </div>
                </div>
            </form>


        </div>
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