<%--
  Created by IntelliJ IDEA.
  User: Ann
  Date: 24.12.2016
  Time: 1:48
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>View all Arts</title>
</head>
<style>
    body {
        background-color: rgba(20, 113, 100, 0.1); /* Цвет фона и значение прозрачности */
    }

    .center {
        width: 900px; /* Ширина элемента в пикселах */
        margin: auto;
        padding: 0px;
    }

    img {
        display: block;
        max-width: 100%;
        max-height: 600px;
        margin: 0 auto;
    }

    .ribbon {
        width: 99%;
        position: absolute;
        text-align: center;
        font-size: 20px !important;
        background: #35a2b5;
        background: -webkit-gradient(linear, left top, left bottom, from(#35a2b5), to(#00a1d2));
        background: -webkit-linear-gradient(top, #35a2b5, #00a1d2);
        background: -moz-linear-gradient(top, #35a2b5, #00a1d2);
        background: -ms-linear-gradient(top, #35a2b5, #00a1d2);
        background: -o-linear-gradient(top, #35a2b5, #EE82EE);
        background-image: -ms-linear-gradient(top, #35a2b5 0%, #EE82EE 100%);
        -webkit-box-shadow: rgba(000, 000, 000, 0.3) 0 1px 1px;
        -moz-box-shadow: rgba(000, 000, 000, 0.3) 0 1px 1px;
        box-shadow: rgba(000, 000, 000, 0.3) 0 1px 1px;
        font-family: 'Helvetica Neue', Helvetica, sans-serif;
    }

    .ribbon h1 {
        font-size: 29px !important;
        color: #fff5f5;
        text-shadow: #0745bf 0 1px 0;
        margin: 0px;
        padding: 15px 10px;
    }

    .ribbon-stitches-top {
        margin-top: 2px;
        border-top: 1px dashed rgba(0, 0, 0, 0.2);
        -moz-box-shadow: 0px 0px 2px rgba(0, 0, 0, 0.5);
        -webkit-box-shadow: 0px 0px 2px rgba(0, 0, 0, 0.5);
        box-shadow: 0px 0px 2px rgba(255, 255, 255, 0.5);
    }

    .ribbon-stitches-bottom {
        margin-bottom: 2px;
        border-top: 1px dashed rgba(0, 0, 0, 0.2);
        -moz-box-shadow: 0px 0px 2px rgba(0, 0, 0, 0.3);
        -webkit-box-shadow: 0px 0px 2px rgba(0, 0, 0, 0.3);
        box-shadow: 0px 0px 2px rgba(255, 255, 255, 0.3);
    }

    .submit-button {
        align-items: flex-end;
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
        font-family: hevetica, serif;
        padding: 8px 18px;
        font-size: 18px;
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
        text-shadow: #0c5246 0 2px 0;
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
</style>
<body>
<div class="ribbon">
    <div class="ribbon-stitches-top">

        <div class="ribbon-content">
            <h1> Here you can see all arts in system </h1>
            <div class="ribbon-stitches-bottom"></div>
        </div>
    </div>
</div>
<br/><br/><br/><br/>
<div class="center">
    <form class="form-container" action="/search" method="POST">

        <input class="submit-button" type="button" value="Return"
               onClick='location.href="http://localhost:8080/main"'>
        <input class="form-field" type="text" name="tag1" title="Whatever you like :)"
               placeholder="Object on art. E.g. 'Death Star'">
        <input class="form-field" type="text" name="tag2" title="Whatever you like :)"
               placeholder="Type of art. E.g. 'oil paints'">
        <input class="submit-button" type="submit" value="Search!"/>

    </form>
    <br/>
    <div class="center">
        ${answ}
        <c:forEach items="${imageCodeArray}" var="variable">
            <img src="${variable}"/><br/>
        </c:forEach>
    </div>
</div>

</body>
</html>
