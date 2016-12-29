<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0" />
    <title>Облік відвідуваності</title>
    <link rel="shortcut icon" type="image/x-icon" href="favicon.ico" />
    <!-- CSS  -->
    <link href="css/materialize.min.css" type="text/css" rel="stylesheet" media="screen,projection" />
    <link href="css/style.css" type="text/css" rel="stylesheet" media="screen,projection" />
    <link rel="stylesheet" media="screen" href="handsontable/handsontable.full.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"> </head>

<body>
    <main>
        <% session=request.getSession(false);
            if(session.getAttribute("user_login")==null) {
                response.sendRedirect("login.jsp");
            }
        %>
        <nav class="indigo" role="navigation">
            <div class="nav-wrapper container">
                <ul class="left">
                    <li> <a href="#">До обліку відвідування</a> </li>
                </ul>
                <ul class="right">
                    <li> <a href="#"><i class="material-icons">power_settings_new</i></a> </li>
                </ul>
                <ul class="right"> <img src="img/avatar.jpeg" alt="" width="60px" class="circle responsive-img">
                    <li> <a href="#">Mnkach</a> </li>
                </ul>
            </div>
        </nav>
        <div class="section no-pad-bot" id="index-banner">
            <div class="container">
                <h1 class="header center orange-text">Персональний кабінет</h1>
                <br>
                <form class="col s12" method="get" action="user">
                        <div class='row'>
                        </div>
                        <div class='row'>
                            <div class='input-field col s12'>
                                <input required class='validate' type='email' name='email' id='email' pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,63}$" value="dmnkach@gmail.com" />
                                <label for='email'>Електронна пошта</label>
                            </div>
                        </div>
                        <div class='row'>
                            <div class='input-field col s12'>
                                <input required class='validate' type='password' name='password' id='password' minlength="6" maxlength="20" pattern="[0-9a-zA-zґҐІіЄєЇїа-яА-Я]+" />
                                <label for='password'>Пароль</label>
                            </div>
                        </div>
                        <div class='row'>
                            <div class='input-field col s12'>
                                <input required class='validate' type='password' name='password2' id='password2' minlength="6" maxlength="20" />
                                <label for='password2'>Підтвердження паролю</label>
                            </div>
                        </div>
                        <div class='row'>
                            <div class='input-field col s12'>
                                <input readonly class='validate' type='text' name='name' id='name' maxlength="20" pattern="[ґҐІіЄєЇїа-яА-Я-]+" value="Василина" />
                                <label for='name'>Ім'я</label>
                            </div>
                        </div>
                        <div class='row'>
                            <div class='input-field col s12'>
                                <input readonly required class='validate' type='text' name='surname' id='surname' maxlength="20" pattern="[ґҐІіЄєЇїа-яА-Я-]+" value="Нечуйвітер" />
                                <label for='surname'>Прізвище</label>
                            </div>
                        </div>
                        <div class='row'>
                            <div class='input-field col s12 phone'>
                                <input required class='validate' type='text' name='phone' id='phone' value="+38(067)8131212" />
                                <label for='phone'>Номер телефону</label>
                            </div>
                        </div>
                        <br />
                        <center>
                            <div class='row'>
                                <button type='submit' name='btn_login' class='col s12 btn btn-large waves-effect orange'>Змінити</button>
                            </div>
                        </center>
                    </form>
                <br> </div>
        </div>
    </main>
    <footer class="page-footer indigo" style="padding-top: 0px;">
        <div class="container"> Ready </div>
        </div>
        <div class="footer-copyright">
            <div class="container"> Made by <a class="indigo-text text-lighten-3" href="http://materializecss.com">Materialize</a> </div>
        </div>
    </footer>
    <!--  Scripts-->
    <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script src="js/materialize.js"></script>
</body>

</html>