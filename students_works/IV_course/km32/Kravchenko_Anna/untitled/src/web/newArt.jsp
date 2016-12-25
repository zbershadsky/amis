<%--
  Created by IntelliJ IDEA.
  User: Ann
  Date: 24.12.2016
  Time: 1:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>New Art Cretion</title>
</head>
<style>
    .ribbon {
        width: 394px;
        position: absolute;
        text-align: center;
        font-size: 23px !important;
        background: #36a1ff;
        background: -webkit-gradient(linear, left top, left bottom, from(#36a1ff), to(#bf8fdb));
        background: -webkit-linear-gradient(top, #36a1ff, #bf8fdb);
        background: -moz-linear-gradient(top, #36a1ff, #bf8fdb);
        background: -ms-linear-gradient(top, #36a1ff, #bf8fdb);
        background: -o-linear-gradient(top, #36a1ff, #bf8fdb);
        background-image: -ms-linear-gradient(top, #36a1ff 0%, #bf8fdb 100%);
        -webkit-box-shadow: rgba(000, 000, 000, 0.3) 0 1px 1px;
        -moz-box-shadow: rgba(000, 000, 000, 0.3) 0 1px 1px;
        box-shadow: rgba(000, 000, 000, 0.3) 0 1px 1px;
        font-family: 'Helvetica Neue', Helvetica, sans-serif;
    }

    .ribbon h1 {
        font-size: 34px !important;
        color: #ffffff;
        text-shadow: #000759 0 1px 0;
        margin: 0px;
        padding: 15px 10px;
    }

    .ribbon:before, .ribbon:after {
        content: '';
        position: absolute;
        display: block;
        bottom: -1em;
        border: 1.5em solid #693ac2;
        z-index: -1;
    }

    .ribbon:before {
        left: -2em;
        border-right-width: 1.5em;
        border-left-color: transparent;
        -webkit-box-shadow: rgba(000, 000, 000, 0.4) 1px 1px 1px;
        -moz-box-shadow: rgba(000, 000, 000, 0.4) 1px 1px 1px;
        box-shadow: rgba(000, 000, 000, 0.4) 1px 1px 1px;
    }

    .ribbon:after {
        right: -2em;
        border-left-width: 1.5em;
        border-right-color: transparent;
        -webkit-box-shadow: rgba(000, 000, 000, 0.4) -1px 1px 1px;
        -moz-box-shadow: rgba(000, 000, 000, 0.4) -1px 1px 1px;
        box-shadow: rgba(000, 000, 000, 0.4) -1px 1px 1px;
    }

    .ribbon .ribbon-content:before, .ribbon .ribbon-content:after {
        border-color: #1c1a42 transparent transparent transparent;
        position: absolute;
        display: block;
        border-style: solid;
        bottom: -1em;
        content: '';
    }

    .ribbon .ribbon-content:before {
        left: 0;
        border-width: 1em 0 0 1em;
    }

    .ribbon .ribbon-content:after {
        right: 0;
        border-width: 1em 1em 0 0;
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

    .center {
        width: 430px; /* Ширина элемента в пикселах */
        padding: 85px; /* Поля вокруг текста */
        margin: auto;
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

    body {
        background-color: rgba(20, 113, 100, 0.8); /* Цвет фона и значение прозрачности */
    }
</style>
<body>
<div class="center">
    <div class="ribbon">
        <div class="ribbon-stitches-top"></div>
        <strong class="ribbon-content">
            <h1>Coming soon</h1></strong>
        <div class="ribbon-stitches-bottom"></div>
    </div>
</div>
<br/><br/>
<form class="form-container" action="/thankU" method="POST">
    Here you can leave a link to especially great kartinochki. Administration always appreciate your contribution to the
    development of the site.
    <input class="form-field" type="text" name="kartinochka" title="Whatever you like"
           placeholder="Past link. E.g. https://pp.vk.me/c638927/jF5qHH1GWtE.jpg" required>
    <input class="submit-button" type="submit" value="Sent"/>

</form>
</body>
</html>
