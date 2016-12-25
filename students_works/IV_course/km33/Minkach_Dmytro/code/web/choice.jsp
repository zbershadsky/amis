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
        <form method="post" action="logout" id="logout"></form>
        <% session=request.getSession(false);
            if(session.getAttribute("user_login")==null) {
                response.sendRedirect("login.jsp");
            }
        %>
        <center>
            <div class="section"></div>
            <h5 class="orange-text">Будь ласка, оберіть предмет</h5>
            <div class="section"></div>
            <div class="container">
                <div class="z-depth-1 grey lighten-4 row" style="display: inline-block; padding: 32px 48px 0px 48px; border: 1px solid #EEE;">
                    <form class="col s12" method="post" action="choice">
                        <div class='row'>
                            <div class='col s12'> </div>
                        </div>
                        <div class='row'>
                            <div class='input-field col s12'>
                                <select required id="group" name="group" searchable="search here..">
                                    <option value="" disabled selected>Оберіть групу</option>
                                    <option value="КМ-31">КМ-31</option>
                                    <option value="КМ-32">КМ-32</option>
                                    <option value="КМ-33">КМ-33</option>
                                </select>
                                <label>Група</label>
                            </div>
                        </div>
                        <div class='row'>
                            <div class='input-field col s12' id="discipline">
                                <select required id="subject" name="subject" searchable="search here..">
                                    <option value="" disabled selected>Оберіть предмет</option>
                                    <option value="Математика">Математика</option>
                                    <option value="Біологія">Біологія</option>
                                </select>
                                <label>Предмет</label>
                            </div>
                        </div>
                        <div class='row'>
                            <div class='input-field col s12' id="datepick">
                                <input required id="date" name="date" type="date" class="datepicker">
                                </input>
                                <label>Оберіть дату</label>
                            </div>
                        </div>
                        <br />
                        <center>
                            <div class='row'>
                                <button type='submit' name='btn_login' class='col s12 btn btn-large waves-effect orange'>Вибрати</button>
                            </div>
                        </center>
                    </form>

                    <div class="row">
                        <a onclick="document.getElementById('logout').submit()">Вийти</a>

                    </div>
                </div>
            </div>
        </center>
        <div class="section"></div>
        <div class="section"></div>
    </main>
    <script src="js/jquery-2.1.1.min.js"></script>
    <script src="js/materialize.js"></script>
    <script src="js/choiceutils.js"></script>
    <script>$('.datepicker').pickadate({
        format: 'dd.mm.yyyy',
        selectMonths: true, // Creates a dropdown to control month
        selectYears: 25 // Creates a dropdown of 15 years to control year
    });

    function checkDate() {
        if ($('#date').val() == '') {
            $('#date').addClass('invalid')
        } else {
            $('#date').removeClass('invalid')
        }
    }

    $('form').submit(function() {
        if ($('#date').val() == '') {
            $('#date').addClass('invalid')
            return false;
        } else {
            $('#date').removeClass('invalid')
            return true;
        }
    });

    $('#date').change(function() {
        checkDate();
    });

    </script>
</body>

</html>