<%
    request.getSession();
    request.getAttribute("name");
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Contact</title>
    <link rel="stylesheet" href="css/firstcss.css" type="text/css"/>
    <link rel="stylesheet" href="css/menu.css" type="text/css"/>
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
        #inner {
            width: 50%;
            position: absolute;
            top: 40%;
            left: 25%;
            height: 50%;
            text-align: center;
            background-color: #222222;
        }
    </style>
    <div id="inner">
<CENTER>
    <b><h2><gradient>Контакти</gradient></h2></b>
</CENTER>
<article>

    <font color= #e5ffdf>Поштова адреса:</font> <font size="2" color="#ffbf8b" face="Arial"><i> 03056, м. Київ, Солом'янський район, пр-т Перемоги, 37 </i></font></p>
    <font color="white"> Адреса електронної пошти:</font> <i><font size="2" color="#ffbf8b" face="Arial">ichanskiy.olexandr@gmail.com</font></i></p>
    <font color="white">Замовлення за телефоном: </font>		<font size="2" color="#ffbf8b" face="Arial"><b><i>(+38 044) 153-95-44</i></b></font>
         <br>  <br> <font color="white">Інформаційний відділ:</font> <i><b><font size="2" color="#ffbf8b" face="Arial">(+38 044) 236-79-89</font></b></i></p>
    <a href="mailto:saschamessi@gmail.com"><font color="white">Відправити лист контактній групі</font></a>
    <br /><br><br>
    <img src="css/images/fon.jpg" class="tel" width="5%" style="position: absolute; left: -100px">
    </article>
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