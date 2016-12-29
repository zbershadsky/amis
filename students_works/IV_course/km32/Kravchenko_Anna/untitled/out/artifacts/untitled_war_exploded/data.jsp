<%--
  Created by IntelliJ IDEA.
  User: Ann
  Date: 16.12.2016
  Time: 1:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit pass</title>
    <style>
        body {
            background-color: rgba(20, 113, 100, 0.8); /* Цвет фона и значение прозрачности */
            color: #000; /* Цвет текста */
        }

        .center {
            width: 350px; /* Ширина элемента в пикселах */
            padding: 20px; /* Поля вокруг текста */
            margin: auto; /* Выравниваем по центру */

        }

        .form-container {
            border: 1px solid #0019b8;
            background: #105e30;
            background: -webkit-gradient(linear, left top, left bottom, from(#6dacbf), to(#105e34));
            background: -webkit-linear-gradient(top, #6dacbf, #105e34);
            background: -moz-linear-gradient(top, #6dacbf, #105e34);
            background: -ms-linear-gradient(top, #6dacbf, #105e34);
            background: -o-linear-gradient(top, #6dacbf, #105e34);
            background-image: -ms-linear-gradient(top, #6dacbf 0%, #105e34 100%);
            -webkit-border-radius: 30px;
            -moz-border-radius: 30px;
            border-radius: 30px;
            -webkit-box-shadow: rgba(000, 000, 000, 0.9) 0 1px 2px, inset rgba(255, 255, 255, 0.4) 0 1px 0;
            -moz-box-shadow: rgba(000, 000, 000, 0.9) 0 1px 2px, inset rgba(255, 255, 255, 0.4) 0 1px 0;
            box-shadow: rgba(000, 000, 000, 0.9) 0 1px 2px, inset rgba(255, 255, 255, 0.4) 0 1px 0;
            font-family: 'Helvetica Neue', Helvetica, sans-serif;
            text-decoration: none;
            vertical-align: middle;
            min-width: 98%;
            padding: 20px;
            width: 98%;
        }

        .form-field {
            border: 1px solid #0d20f7;
            background: #d9d9d9;
            -webkit-border-radius: 15px;
            -moz-border-radius: 15px;
            border-radius: 15px;
            color: #010808;
            -webkit-box-shadow: rgba(255, 255, 255, 0.4) 0 0px 0, inset rgba(000, 000, 000, 0.7) 0 1px 1px;
            -moz-box-shadow: rgba(255, 255, 255, 0.4) 0 0px 0, inset rgba(000, 000, 000, 0.7) 0 1px 1px;
            box-shadow: rgba(255, 255, 255, 0.4) 0 0px 0, inset rgba(000, 000, 000, 0.7) 0 1px 1px;
            padding: 8px;
            margin-bottom: 20px;
            width: 330px;
        }

        .form-field:focus {
            background: #fff;
            color: #000000;
        }

        .form-container h2 {
            text-shadow: #000000 0 1px 0;
            font-size: 18px;
            margin: 0 0 10px 0;
            font-weight: bold;
            text-align: center;
        }

        .form-title {
            margin-bottom: 10px;
            color: #ffffff;
            text-shadow: #000000 0 1px 0;
        }

        .submit-container {
            margin: 8px 0;
            text-align: right;
        }

        .submit-button {
            border: 1px solid #000000;
            background: #31404d;
            background: -webkit-gradient(linear, left top, left bottom, from(#7fabe0), to(#31404d));
            background: -webkit-linear-gradient(top, #7fabe0, #31404d);
            background: -moz-linear-gradient(top, #7fabe0, #31404d);
            background: -ms-linear-gradient(top, #7fabe0, #31404d);
            background: -o-linear-gradient(top, #7fabe0, #31404d);
            background-image: -ms-linear-gradient(top, #7fabe0 0%, #31404d 100%);
            -webkit-border-radius: 30px;
            -moz-border-radius: 30px;
            border-radius: 30px;
            -webkit-box-shadow: rgba(255, 255, 255, 0.4) 0 0px 0, inset rgba(255, 255, 255, 0.4) 0 1px 0;
            -moz-box-shadow: rgba(255, 255, 255, 0.4) 0 0px 0, inset rgba(255, 255, 255, 0.4) 0 1px 0;
            box-shadow: rgba(255, 255, 255, 0.4) 0 0px 0, inset rgba(255, 255, 255, 0.4) 0 1px 0;
            text-shadow: #998fe3 0 1px 0;
            color: #000000;
            font-family: helvetica, serif;
            padding: 8.5px 18px;
            font-size: 14px;
            text-decoration: none;
            vertical-align: middle;
        }

        .submit-button:hover {
            border: 1px solid #153773;
            text-shadow: #1d0c52 0 1px 0;
            background: #367da3;
            background: -webkit-gradient(linear, left top, left bottom, from(#5a9fbf), to(#367da3));
            background: -webkit-linear-gradient(top, #5a9fbf, #367da3);
            background: -moz-linear-gradient(top, #5a9fbf, #367da3);
            background: -ms-linear-gradient(top, #5a9fbf, #367da3);
            background: -o-linear-gradient(top, #5a9fbf, #367da3);
            background-image: -ms-linear-gradient(top, #5a9fbf 0%, #367da3 100%);
            color: #fff;
        }

        .submit-button:active {
            text-shadow: #0c5246 0 1px 0;
            border: 1px solid #15735b;
            background: #5aa7bf;
            background: -webkit-gradient(linear, left top, left bottom, from(#36a37f), to(#367da3));
            background: -webkit-linear-gradient(top, #36a37f, #5aa7bf);
            background: -moz-linear-gradient(top, #36a37f, #5aa7bf);
            background: -ms-linear-gradient(top, #36a37f, #5aa7bf);
            background: -o-linear-gradient(top, #36a37f, #5aa7bf);
            background-image: -ms-linear-gradient(top, #36a37f 0%, #5aa7bf 100%);
            color: #fff;
        }

    </style>
</head>
<body>

<div class="center">

    <form class="form-container" action="/equals" method="POST">

        <div class="form-title"><h2>Change password</h2></div>
        <div class="form-title">Old password</div>
        <input class="form-field" type="password" name="old_pass" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
               title="I need at least one number and one uppercase and lowercase letter, and at least 8 or more characters (but the blood of innocent children can keep to yourself)"
               required> <br/>
        <div class="form-title">New password</div>
        <input class="form-field" type="password" name="new_pass" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
               title="I need at least one number and one uppercase and lowercase letter, and at least 8 or more characters (but the blood of innocent children can keep to yourself)"
               required> <br/>
        <div class="form-title">Repeat new password</div>
        <input class="form-field" type="password" name="new_pass2" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
               title="I need at least one number and one uppercase and lowercase letter, and at least 8 or more characters (but the blood of innocent children can keep to yourself)"
               required> <br/>
        <div class="submit-container">
            <input class="submit-button" type="submit" value="Submit"/>
            <br/><br/>
            <input class="submit-button" type="button" value="Return"
                   onClick='location.href="http://localhost:8080/main"'>
        </div>

    </form>

</div>
</body>
</html>
