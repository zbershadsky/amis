<%--
  Created by IntelliJ IDEA.
  User: Ann
  Date: 16.12.2016
  Time: 1:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>My page</title>
    <style>
        body {
            background-color: rgba(20, 113, 100, 0.8); /* Цвет фона и значение прозрачности */
            color: #C0CED7;
        }

        .tags a {
            display: inline-block;
            height: 21px;
            margin: 0 10px 0 0;
            padding: 0 7px 0 14px;
            white-space: nowrap;
            position: relative;

            background: -moz-linear-gradient(top, #0591ba 0%, #998fe3 100%);
            background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #0591ba), color-stop(100%, #998fe3));
            background: -webkit-linear-gradient(top, #0591ba 0%, #998fe3 100%);
            background: -o-linear-gradient(top, #0591ba 0%, #998fe3 100%);
            background: linear-gradient(to bottom, #0591ba 0%, #998fe3 100%);
            background-color: #0591ba;

            color: #1d0c52;
            font: bold 11px/20px Arial, Tahoma, sans-serif;
            text-decoration: none;
            text-shadow: 0 1px rgba(255, 255, 255, 0.4);

            border-top: 1px solid #7fabe0;
            border-bottom: 1px solid #0d20f7;
            border-right: 1px solid #00a1d2;
            border-radius: 1px 3px 3px 1px;
            box-shadow: inset 0 1px #00a1d2, 0 1px 2px rgba(0, 0, 0, 0.21);
        }

        .tags a:before {
            content: '';
            position: absolute;
            top: 5px;
            left: -6px;
            width: 10px;
            height: 10px;

            background: -moz-linear-gradient(45deg, #998fe3 0%, #35a2b5 100%);
            background: -webkit-gradient(linear, left bottom, right top, color-stop(0%, #998fe3), color-stop(100%, #35a2b5));
            background: -webkit-linear-gradient(-45deg, #998fe3 0%, #35a2b5 100%);
            background: -o-linear-gradient(45deg, #998fe3 0%, #35a2b5 100%);
            background: linear-gradient(135deg, #998fe3 0%, #35a2b5 100%);
            background-color: #35a2b5;

            border-left: 1px solid #7fabe0;
            border-bottom: 1px solid #153773;
            border-radius: 0 0 0 2px;
            box-shadow: inset 1px 0 #35a2b5, 0 2px 2px -2px rgba(0, 0, 0, 0.33);
        }

        .tags a:before {
            -webkit-transform: scale(1, 1.5) rotate(45deg);
            -moz-transform: scale(1, 1.5) rotate(45deg);
            -ms-transform: scale(1, 1.5) rotate(45deg);
            transform: scale(1, 1.5) rotate(45deg);
        }

        .tags a:after {
            content: '';
            position: absolute;
            top: 7px;
            left: 1px;
            width: 5px;
            height: 5px;
            background: #FFF;
            border-radius: 4px;
            border: 1px solid #153773;
            box-shadow: 0 1px 0 rgba(255, 255, 255, 0.2), inset 0 1px 1px rgba(0, 0, 0, 0.21);
        }

        .tags a:hover {
            color: #FFF;
            text-shadow: -1px -1px 0 rgba(153, 102, 51, 0.3);
        }
        .center {
            width: 200px; /* Ширина элемента в пикселах */
            padding: 85px; /* Поля вокруг текста */
            margin: auto;

        }

    </style>
</head>
<div class="center">
   <h3> Welcome, ${sessionScope.userName1}!</h3>

    <hr width="200" align="center"/>

    ${ans}
    <br/><br/>
    Press to <br/><br/>
    <div class="tags">
        <a href="/edit">change pass</a> <br/>
        <a href="/newArt">create new art</a> <br/>
        <a href="/viewMyArts">view my arts</a> <br/>
        <a href="/viewAllArts">view arts</a> <br/>
        <a href="/index">exit </a> <br/>
    </div>
</div>
</body>
</html>