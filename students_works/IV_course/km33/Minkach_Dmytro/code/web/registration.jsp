<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>Облік відвідуваності</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/materialize.min.css">
    <link rel="stylesheet" type="text/css" href="css/login.css"> </head>

<body>
    <div class="section"></div>
    <main>
        <% session=request.getSession(false);
            if(session.getAttribute("user_login")!=null) {
                response.sendRedirect("choice.jsp");
            }
        %>
        <center>
            <div class="section"></div>
            <h5 class="orange-text">Реєстрація</h5>
            <div class="section"> </div>
            <div class="container">
                <div class="z-depth-1 grey lighten-4 row" style="display: inline-block; padding: 32px 48px 0px 48px; border: 1px solid #EEE;">
                    <form class="col s12" method="post" action="registration">
                        <div class='row'>
                            <div class='col s12'>Ви:
                                <p>
                                    <input required name="group1" type="radio" id="test1" value="0"/>
                                    <label for="test1">Студент</label>
                                </p>
                                <p>
                                    <input name="group1" type="radio" id="test2" value="1"/>
                                    <label for="test2">Викладач</label>
                                </p>
                            </div>
                        </div>
                        <div class='row'>
                            <div class='input-field col s12'>
                                <input required class='validate' type='email' name='email' id='email' pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,63}$" />
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
                                <input required class='validate' type='text' name='name' id='name' maxlength="20" pattern="[ґҐІіЄєЇїа-яА-Я-]+" />
                                <label for='name'>Ім'я</label>
                            </div>
                        </div>
                        <div class='row'>
                            <div class='input-field col s12'>
                                <input required class='validate' type='text' name='surname' id='surname' maxlength="20" pattern="[ґҐІіЄєЇїа-яА-Я-]+" />
                                <label for='surname'>Прізвище</label>
                            </div>
                        </div>
                        <div class='row'>
                            <div class='input-field col s12' name="group" id="group" style="display: none">
                                <select id="groupsel" name="groupsel" selected="" searchable="search here..">
                                    <option value="" disabled selected>Оберіть групу</option>
                                    <option value="КМ-31">КМ-31</option>
                                    <option value="КМ-32">КМ-32</option>
                                    <option value="КМ-33">КМ-33</option>
                                </select>
                                <label>Група</label>
                            </div>
                        </div>
                        <div class='row'>
                            <div class='input-field col s12 phone'>
                                <input required class='validate' type='text' name='phone' id='phone' />
                                <label for='phone'>Номер телефону</label>
                            </div>
                        </div>
                        <br />
                        <center>
                            <div class='row'>
                                <button type='submit' name='btn_login' class='col s12 btn btn-large waves-effect orange'>Створити</button>
                            </div>
                        </center>
                    </form>
                </div>
            </div> <a href="login.jsp" class="indigo-text">У мене вже є аккаунт</a> </center>
        <div class="section"></div>
        <div class="section"></div>
    </main>
    <script src="js/jquery-2.1.1.min.js"></script>
    <script src="js/materialize.js"></script>
    <script src="js/jquery.maskedinput.min.js"></script>
    <script src="js/utils.js"></script>
</body>

</html>