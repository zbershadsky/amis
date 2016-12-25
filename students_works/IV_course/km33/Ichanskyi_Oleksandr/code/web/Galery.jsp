<%
    request.getSession();
    request.getAttribute("name");
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="css/firstcss.css" type="text/css"/>
    <link rel="stylesheet" href="css/menu.css" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="fancybox/jquery.fancybox.css" media="screen" />
    <script type="text/javascript" src="fancybox/jquery-1.3.2.min.js"></script>
    <script type="text/javascript" src="fancybox/jquery.easing.1.3.js"></script>
    <script type="text/javascript" src="fancybox/jquery.fancybox-1.2.1.pack.js"></script>
    <meta charset="UTF-8">

    <script type="text/javascript">
        $(document).ready(function() {
            $("a.gallery").fancybox();
        });
    </script>
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
<table width="30%" border="0" align="center">
    <tr>
        <td>
            <p><a class="gallery" rel="group" title="Rolls Rouse" href="css/images/fon.jpg"><img src="css/images/fon.jpg" width="400px" height="230px" class='photo'></a>
        <a class="gallery" rel="group" title="Rolls Rouse" href="css/images/rolls-royce-phantom-05.jpg"><img src="css/images/rolls-royce-phantom-05.jpg" width="400px" height="230px"   class='photo'></a>
        </td></p>
        <td>
            <a class="gallery" rel="group" title="Rolls Rouse" href="css/images/fon1.jpg"><img src="css/images/fon1.jpg" width="400px" height="230px"  class='photo'></a>
            <a class="gallery" rel="group" title="Rolls Rouse"  href="css/images/fon2.jpg"><img src="css/images/fon2.jpg" width="400px" height="230px"  class='photo'></a>
        </td>
            <br><br>
        </td>
    </tr>
</table>
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