    <?php
    session_start();
    ?>
<!DOCTYPE html>
<html lang="ru">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pay&Go</title>

   


    <link rel="stylesheet" type="text/css" href="node_modules/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="node_modules/bootstrap.min.css">
    <!--<link rel="stylesheet" type="text/css" href="node_modules/swiper/dist/css/swiper.min.css">-->
    <link rel="stylesheet" type="text/css" href="css/style.css">
   <!--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.1/css/bootstrap-select.min.css">-->
    <link rel="stylesheet" type="text/css" href="node_modules/bootstrap_select.min.css">
    <link rel="stylesheet" href="css/bootstrap-datetimepicker.min.css">
   <!--<link rel="stylesheet" type="text/css" href="css/bootstrap-datetimepicker.min.css">-->

</head>

<body>
    <!-- uncollapsed menu -->

    <nav id="uncol-menu" class="toggle-menu hidden-sm hidden-md hidden-lg ">
        <img src="img/icons/close-menu.png" class="pull-right close-menu" id="close-menu" alt="close-menu">
        <p class="bold">Меню</p>
        <br>
        <ul>
            <li>
                <?php
                            if (!isset($_SESSION['user_name'])){
                            echo '<a href="#reest">Вхід до системи</a>';
                            }
                            else { 
                               echo '<a href="#" class = "aid">Вихід з системи</a>';
                             }
                            ?>
            </li>
            <li>
                <a href="index.php#form">Створити форму</a>
            </li>
            <li>
                <a href="cabinet.php">Особистий кабінет</a>
            </li>
            <li>
                <a href="cart.php">Кошик</a>
            </li>
        </ul>
    </nav>
    <!-- end of uncollapsed menu -->

    <div class="container-fluid">
        <header class="row default">
            <div class="col-lg-8 col-lg-offset-2 col-md-12 col-sm-12 col-xs-12 top">
                <nav class="static-menu">
                    <div class="logo-in-nav bold"><a href="index.php">PAY&GO</a></div>
                    <div id="open-menu" class="bars visible-xs"><i class="fa fa-bars"></i></div>
                    <ul class="menu bold" id="menu">
                         <li>
                            <a href="cart.php">Кошик</a>
                        </li>
                        <li>
                            <a href="cabinet.php">Особистий кабінет</a>
                        </li>
                        <li>
                        <?php
                            if (!isset($_SESSION['user_name'])){
                            echo '<a href="#reest">Вхід до системи</a>';
                            }
                            else { 
                               echo '<a href="#" class = "aid">Вихід з системи</a>';
                             }
                            ?>
                        </li>
                        <li>
                            <a href="#form">Створити форму</a>
                        </li>
                        

                    </ul>
                </nav>
            </div>
        </header>
           
        <div class="row main-bg" id="main-bg">
            <div class="col-lg-4  col-lg-offset-4 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1">
                <div class="lead-text">
                    <p class="pre-main-title">Сервіс оплати комунальних послуг</p>
                    <h1 class="main-title bold">PAY&GO</h1>
                    <hr class="black-bg">
                    <p>Якщо Ви сучасна людина і розумієте, що сплачувати в Інтернеті безпечно, то ми гарантуємо Вам повернути час, втрачений у стояннях в чергах на оплату комунальних  послуг.
                    
                    </p>
                    <a class='button hidden-xs' href="#form">Створити форму оплати</a>
                    <a class="arrow-button"><i></i></a>
                </div>
            </div>
        </div>

        <!-- about us -->
        <div class="row about ">
            <div class="col-lg-6 col-lg-offset-3 col-sm-10 col-sm-offset-1 col-xs-12">
                <div class="white-realm" id="reest">
                   
                    <?PHP
                    if (!isset($_SESSION['user_name']))
                          {
                            echo '<html >
                            <head>
                            <link rel="stylesheet" type="text/css" href="node_modules/bootstrap.min.css">
                            <link rel="stylesheet" type="text/css" href="css/style.css">
                            </head>
                            <body>
                             <div class="col-lg-2"></div>
                             <div class="container-fluid tab-content">

                        <div class="tab-pane row  services-page-description  active" id="login" role="tabpanel">
                            <form class="form-horizontal col-lg-8" id ="auth_form">
                              <fieldset >
                                <div class="form-group">
                                  <label for="inputlogin" class="control-label col-xs-3">Login</label>
                                  <div class="col-xs-9">
                                    <input type="email" class="form-control email_test " id="inputlogin" placeholder="Login" required  maxlength = "254" name="auth_login">
                                  </div>
                                </div>
                                <div class="form-group">
                                  <label for="inputPassword" class="control-label col-xs-3">Пароль</label>
                                  <div class="col-xs-9">
                                    <input type="password" class="form-control pass_test" id="inputPassword" placeholder="Пароль" required   maxlength = "30" name = "auth_pass">
                                  </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-offset-2 col-sm-10">
                                        <a  id= "go_reestr" aria-controls="reestration" role="tab" href="#reestration" data-toggle="tab">Я не зареєстрований</a>
                                        <!--<div class="checkbox">
                                            <label><input type="checkbox"> Запам"ятати мене</label>
                                        </div>-->
                                    </div>
                                </div>
                                <div class="form-group">
                                  <div class="col-xs-offset-2 col-xs-10">
                                    <input type="submit" value="Войти" class="button" id="sendLogin">
                                  </div>
                                </div>
                              </fieldset>
                            </form>
                        </div>

                        <div class="tab-pane row services-page-description" id="reestration" role="tabpanel">
                            
                            <form class="form-horizontal col-xs-12" id="reestr_form">
                                <h3>Реєстрація</h3>
                              <fieldset >
                                <div class="form-group">
                                      <label for="inputFNameReestr" class="control-label col-xs-4">Введіть ім"я</label>
                                      <div class="col-xs-8">
                                        <input type="text" class="form-control name_test" name="inputFNameReestr" pattern="^[A-Za-zА-Яа-яЁёІі-]{2,}" placeholder="Олександр" required  maxlength = "64" >
                                      </div>
                                </div>
                                <div class="form-group">
                                  <label for="inputSNameReestr" class="control-label col-xs-4">Введіть прізвище</label>
                                  <div class="col-xs-8">
                                    <input type="text" class="form-control name_test" name="inputSNameReest" placeholder="Курілець" required pattern="^[A-Za-zА-Яа-яЁёІі-]{2,}" maxlength = "64" >
                                  </div>
                                </div>
                                  <div class="form-group">
                                    <label class="control-label col-xs-4" for="inputEmail">Email</label>
                                    <div class="col-xs-8">
                                      <input type="email" class="form-control email_test" name="inputEmail" placeholder="Email"  pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" maxlength = "254" required >
                                    </div>
                                  </div>
                                <div class="form-group">
                                  <label for="inputPasswordReestr" class="control-label col-xs-4">Пароль</label>
                                  <div class="col-xs-8">
                                    <input type="password" class="form-control pass_test" name="inputPasswordReestr" placeholder="Пароль" required  maxlength = "30" >
                                  </div>
                                </div>
                                <div class="form-group">
                                  <label for="inputPasswordAgain" class="control-label col-xs-4">Повторіть пароль</label>
                                  <div class="col-xs-8">
                                    <input type="password" class="form-control" name="inputPasswordAgain" placeholder="Пароль" required pattern="{5,}" maxlength = "30" >
                                  </div>
                                </div>
                                <div class="form-group">
                                  <div class="col-xs-12">
                                    <input type="submit" value="Зареєструватися" class="button sendInfo" id="sendLogin">
                                  </div>
                                </div>
                              </fieldset>
                            </form>
                        
                        </div>
                    </div>
                    <div class="col-lg-2"></div>
                            </body></html>';
                          }
                          else {
                            echo "Вітаємо Вас у системі,".$_SESSION['user_name'];
                          }
                          ?>
                </div>
            </div>
        </div>


        <div class="row">
            <div class="col-lg-2"></div>
            <div class=" col-lg-8">
                <div class="team" id="form">
                    <h2>Форма до оплати</h2>
                    <hr class="black-bg">
                    <div class="container-fluid">
                        <form class="form-horizontal" id="add_to_cart">
                            <div class="form-group">
                              <label for="inputFName" class="control-label col-xs-4">Введіть ім'я платника</label>
                              <div class="col-xs-8">
                                <input type="text" class="form-control name_test" name="inputFName" placeholder="Олександр" required pattern="^[A-Za-zА-Яа-яЁёІі]{2,}" maxlength = "64" value = <?php  if (isset($_SESSION['user_name']))
                          { echo $_SESSION['user_name'];} ;?> >
                              </div>
                            </div>
                            <div class="form-group">
                              <label for="inputSName" class="control-label col-xs-4">Введіть прізвище платника</label>
                              <div class="col-xs-8">
                                <input type="text" class="form-control" name="inputSName name_test" placeholder="Курілець" required pattern="^[A-Za-zА-Яа-яЁёІі]{2,}" maxlength = "64" value = <?php  if (isset($_SESSION['user_surname']))
                          { echo $_SESSION['user_surname'];} ;?>  >
                              </div>
                            </div>
                            <div class="form-group">
                                    <label class="control-label col-xs-4" for="inputEmail">Email для чека</label>
                                    <div class="col-xs-8">
                                      <input type="email" class="form-control email_test" name="inputEmail" placeholder="Email"  pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" maxlength = "254" >
                                    </div>
                                  </div>
                            <div class="form-group">
                                <label for="City" class="control-label col-xs-4">Оберіть місто</label>
                                <div class="col-xs-8">
                                    <select class="form-control" required name = "selectCity">
                                      <option value="Kiev">Київ</option>
                                      <option value="Dnipro">Дніпро</option>
                                      <option value="Kharkiv">Харків</option>
                                      <option value="Lviv">Львів</option>
                                      <option value="Odessa">Одесса</option>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                              <label for="inputAdress" class="control-label col-xs-4" >Введіть адресу платника</label>
                              <div class="col-xs-8">
                                <input type="text" class="form-control address_test" name="inputAdress" placeholder="Проспект Пушкіна 26/18" required pattern="{6,}" maxlength = "150">
                              </div>
                            </div>
                            <div class="form-group">
                              <label for="inputService" class="control-label col-xs-4">Оберіть види комунальної послуги</label>
                              <div class="col-xs-8">
                                <select class="selectpicker form-control" multiple required name = "selectService">
                                  <option value="water">Вода</option>
                                  <option value="gas">Газ</option>
                                  <option value="electric power">Електроенергія</option>
                                  <option value="cleaning">Прибирання територій</option>
                                  <option value="lift">Ліфт</option>
                                </select>
                              </div>
                            </div>
                               <!-- <div class="col-xs-5">
                                <div class="form-group">
                                  <div class="input-group date" id="datetimepicker8">
                                    <input type="text" class="form-control" required>
                                    <span class="input-group-addon">
                                      <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                  </div>
                                </div>
                                </div>
                                <div class="col-xs-2"></div>
                                <div class="col-xs-5">
                                <div class="form-group">
                                  <div class="input-group date" id="datetimepicker9">
                                    <input type="text" class="form-control" required>
                                    <span class="input-group-addon">
                                      <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                  </div>
                                </div>-->
                            </div>
                            <div class="form-group">
                                 <input type="submit" value="Додати до кошика" class="button" > 
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-lg-2"></div>
        </div>


        
        

    <footer>
        <div class="container-fluid">
            <a class="upArr" id="upArr">
                <i class="fa fa-chevron-up"></i></a>
            <div class="row">
                <div class="col-lg-10 col-lg-offset-1 col-xs-12">
                    <h2>Pay&Go</h2>
                    <ul class="footer-navigation hidden-xs">
                        <li>
                            <a href="index.php#reest">Реєстрація</a>
                        </li>
                        <li>
                            <a href="index.php#form">Створити форму</a>
                        </li>
                        <li>
                            <a href="cabinet.php">Вхід до системи</a>
                        </li>
                        <li>
                            <a href="cart.php">Кошик</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </footer>





 <script src="node_modules/jquery.js"></script>
    <script src="node_modules/moment-with-locales.min.js"></script>
    <script type="text/javascript" src="node_modules/bootstrap.min.js"></script>
    <script src="http://cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/a549aa8780dbda16f6cff545aeabc3d71073911e/src/js/bootstrap-datetimepicker.js"></script>


    <!--<script src="node_modules/swiper/dist/js/swiper.jquery.min.js"></script>-->
    <!--<script src="node_modules/jquery-mask-plugin/dist/jquery.mask.min.js"></script>-->
    <script src="js/script.js"></script>
    <script src="js/logik.js"></script>
    <!--<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.1/js/bootstrap-select.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.2/rollups/md5.js"> -->
     <script src="node_modules/bootstrap-select.min.js"></script>
      <script src="node_modules/md5.js"></script>


    

<script type="text/javascript">
               $(document).ready(function() {
               $('.selectpicker').selectpicker();
              });
    </script>

<script type="text/javascript">
  $(document).ready(function($) {
    //Инициализация datetimepicker8 и datetimepicker9
    
    $("#datetimepicker8").datetimepicker({
    format:'DD-MM-YY'
 });
    $("#datetimepicker9").datetimepicker({
    format:'DD-MM-YY'
 });
    //При изменении даты в 8 datetimepicker, она устанавливается как минимальная для 9 datetimepicker
    $("#datetimepicker8").on("dp.change",function (e) {
      $("#datetimepicker9").data("DateTimePicker").setMinDate(e.date);
    });
    //При изменении даты в 9 datetimepicker, она устанавливается как максимальная для 8 datetimepicker
    $("#datetimepicker9").on("dp.change",function (e) {
      $("#datetimepicker8").data("DateTimePicker").setMaxDate(e.date);
    });
  });
</script>
   
</body>

</html>
