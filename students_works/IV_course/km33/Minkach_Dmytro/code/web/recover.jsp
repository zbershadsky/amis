<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>Облік відвідуваності</title>
    <meta charset="UTF-8" />
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/materialize.min.css">
    <link rel="stylesheet" type="text/css" href="css/login.css"> </head>

<body>
    <div class="section"></div>
    <main>
        <center>
            <div class="section"></div>
            <h5 class="orange-text">Відновлення паролю</h5>
            <div class="section"></div>
            <div class="container">
                <div class="z-depth-1 grey lighten-4 row" style="display: inline-block; padding: 32px 48px 0px 48px; border: 1px solid #EEE;">
                    <form class="col s12" method="post">
                        <div class='row'>
                            <div class='col s12'> </div>
                        </div>
                        <div class='row'>
                            <div class='input-field col s12'>
                                <input class='validate' type='email' name='email' id='email' />
                                <label for='email'>Електронна пошта</label>
                            </div>
                        </div>
                        <br />
                        <center>
                            <div class='row'>
                                <button type='submit' name='btn_login' class='col s12 btn btn-large waves-effect orange'>Відновити</button>
                            </div>
                        </center>
                    </form>
                </div>
            </div> <a href="login.jsp" class="indigo-text">Увійти</a> </center>
        <div class="section"></div>
        <div class="section"></div>
    </main>
    <script src="js/jquery-2.1.1.min.js"></script>
    <script src="js/materialize.min.js"></script>
</body>

</html>