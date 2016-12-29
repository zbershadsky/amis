    <?php
    session_start();
    ?>

<!DOCTYPE html>
<html lang="ru">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Кошик</title>
    <link rel="stylesheet" type="text/css" href="node_modules/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="node_modules/bootstrap.min.css">
    <!--<link rel="stylesheet" type="text/css" href="node_modules/swiper/dist/css/swiper.min.css">-->
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/cart.css">
    <link rel="stylesheet" type="text/css" href="css/card.css">
</head>


<body class="cart">
    <!-- uncollapsed menu -->
    <nav id="uncol-menu" class="toggle-menu hidden-sm hidden-md hidden-lg ">
        <img src="img/icons/close-menu.png" class="pull-right close-menu" id="close-menu" alt="close-menu">
        <p class="bold">Меню</p>
        <br>
        <ul>
            <li>
                <a href="cart.php">Кошик</a>
            </li>
            <li>
                <a href="cabinet.php">Особистий кабінет</a>
            </li>
            <li>
                <?php
                            if (!isset($_SESSION['user_name'])){
                            echo '<a href="index.php#reest">Вхід до системи</a>';
                            }
                            else { 
                               echo '<a href="#" class="aid">Вихід з системи</a>';
                             }
                            ?>
            </li>
            <li>
                <a href="index.php#form">Створити форму</a>
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
                            echo '<a href="index.php#reest">Вхід до системи</a>';
                            }
                            else { 
                               echo '<a href="#" class = "aid">Вихід з системи</a>';
                             };
                            ?>
                        </li>
                        <li>
                            <a href="index.php#form">Створити форму</a>
                        </li>
                        

                    </ul>
                </nav>
            </div>
        </header>

        <div class="white-realm row" >
                    <div class="col-md-1"></div>
                    <div class="col-md-10">

                    <?php
                            if (isset($_SESSION['user_name'])){
                            echo '<form class="form-horizontal col-xs-12" id="change_pass">
                            <h3>Бажаете змінити пароль?</h3>
                              <fieldset >
                                <div class="form-group">
                                  <label for="inputPasswordOld" class="control-label col-xs-4">Введіть старий пароль</label>
                                  <div class="col-xs-8">
                                    <input type="password" class="form-control pass_test" name="inputPasswordOld" placeholder="Пароль" required  maxlength = "30" >
                                  </div>
                                </div>
                                <div class="form-group">
                                  <label for="inputPasswordNew" class="control-label col-xs-4">Введіть новий пароль</label>
                                  <div class="col-xs-8">
                                    <input type="password" class="form-control pass_test" name="inputPasswordNew" placeholder="Пароль" required  maxlength = "30" >
                                  </div>
                                </div>
                                <div class="form-group">
                                  <label for="inputPasswordNew2" class="control-label col-xs-4">Повторіть новий пароль</label>
                                  <div class="col-xs-8">
                                    <input type="password" class="form-control" name="inputPasswordNew2" placeholder="Пароль" required pattern="{5,}" maxlength = "30" >
                                  </div>
                                </div>
                                <div class="form-group">
                                  <div class="col-xs-12">
                                    <input type="submit" value="Змінити пароль" class="button sendInfo" id="sendLogin">
                                  </div>
                                </div>
                              </fieldset>
                            </form>';
                            }
                            else { 
                               echo ' Необхідно увійти до системи';
                             };
                            ?>


                     
                    </div>
                    <div class="col-md-1"></div>
        </div>

    </div>

    <footer>
        <div class="container-fluid">
            <a class="upArr" id="upArr">
                <i class="fa fa-chevron-up"></i></a>
            <div class="row">
                <div class="col-lg-10 col-lg-offset-1 col-xs-12">
                    <h2>PAY&GO</h2>
                    <ul class="footer-navigation hidden-xs">
                        <li>
                            <a href="cart.php">Кошик</a>
                        </li>
                        <li>
                            <a href="cabinet.php">Особистий кабінет</a>
                        </li>
                        <li>
                            <a href="index.php#reest">Вхід до системи</a>
                        </li>
                        <li>
                            <a href="index.php#form">Створити форму</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </footer>
    
    <script src="node_modules/jquery.min.js"></script>
    <script src="node_modules/bootstrap.min.js"></script>
    <!--<script src="node_modules/swiper/dist/js/swiper.jquery.min.js"></script>
    <script src="node_modules/jquery-mask-plugin/dist/jquery.mask.min.js"></script>-->
    <script src="js/script.js"></script>
    <script src="js/logik.js"></script>
    
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.13.1/jquery.validate.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.payment/1.2.3/jquery.payment.min.js"></script>
 <script src="node_modules/md5.js"></script>



</body>

</html>
