    <?php
    session_start();
    require_once 'php/connect.php';
    
    ?>
<!DOCTYPE html>
<html lang="ru">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Кошик</title>
    <link rel="stylesheet" type="text/css" href="node_modules/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="node_modules/bootstrap/dist/css/bootstrap.min.css">
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
                               echo '<a href="#" class = "aid">Вихід з системи</a>';
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
                             }
                            ?>
                        </li>
                        <li>
                            <a href="index.php#form">Створити форму</a>
                        </li>
                        

                    </ul>
                </nav>
            </div>
        </header>

        <section class="cart-page">
            <div class="row services-page-main">
                <div class="col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2 col-lg-8 col-lg-offset-2">
                    <h1>Кошик</h1>
                    <div class="row">
                       <!--<div class="col-lg-12 col-md-12">
                            <ul role="tablist" class="tabs hidden-xs" id="tabs">
                                <li role="presentation" class="active"> <a aria-controls="list" href="#list" data-toggle="tab">Перелік</a>
                                </li>
                                <li role="presentation"> <a aria-controls="pay" role="tab" href="#pay" data-toggle="tab">Оплата</a>
                                </li>
                            </ul>
                            <div class="visible-xs">
                                <ul role="tablist" class="tabs">
                                    <li role="presentation" class="dropdown">
                                        <a id="dLabel" class="dropdown-toggle custom-dropdown-toggle" href="#" data-toggle="dropdown" aria-controls="TabDrop">Лендинг пейдж<i class="fa fa-angle-down" aria-hidden="true"></i></a>
                                        <ul class="dropdown-menu custom-dropdown-menu" role="menu" aria-labelledby="dLabel" id="TabDrop">
                                            <li role="presentation" class="active"> <a aria-controls="list" href="#list" data-toggle="tab">Перелік</a>
                                            </li>
                                            <li role="presentation"> <a aria-controls="pay" role="tab" href="#pay" data-toggle="tab">Оплата</a>
                                            </li>
                                           
                                        </ul>
                                    </li>
                                </ul>
                            </div> 
                        </div>-->
                    </div>
                </div>
            </div>

            <div class="tab-content">
                <div class="tab-pane row active services-page-description" id="list" role="tabpanel">
                    <h2>Ваші заповнені форми</h2>
                    <div class="col-xs-10 col-sm-10 col-sm-offset-1 col-md-10 col-md-offset-1 col-lg-offset-1 col-lg-10">
                        <p class="text-center">
                        <?php
                            if (isset($_SESSION['user_name'])) {
                               // echo "Hi,".$_SESSION['user_name'];
                                echo '<!DOCTYPE html>
                                <html>
                                <head>
                                    <title></title>
                                </head>
                                <body>
                                <div class="container-fluid tab-content">
                                <div class="tab-pane row cart_table" id="div_change" role="tabpanel_tabl">
                                <form id = "change">
                                 <table class="table table-striped">
                                    <thead>
                                     <tr>
                                     <th>Имя</th>
                                     <th>Фамилия</th>
                                     <th>Почта для отправки чека</th>
                                     <th>Адрес</th>
                                     <th>Сервис</th>
                                     <th></th>
                                     </tr>
                                     </thead>
                                     <tbody>';

                                 $query = "SELECT * FROM Cartitem_view   WHERE Cartitem_view.user_email_fk LIKE '".$_SESSION['user_email']."' ;"; 
                                 //echo $query;
                                 odbc_autocommit($db_conn, FALSE);
                                 $result = odbc_exec($db_conn, $query);
                                 if (!odbc_error()){
                                     odbc_commit($db_conn);
                                   }
                                else {
                                       odbc_rollback($db_conn);
                                   }
                                odbc_autocommit($db_conn, TRUE);
                                 while(odbc_fetch_row($result)){
                                    $service = odbc_result($result,3);
                                    $addres = odbc_result($result,4);
                                    $email_to_send = odbc_result($result,5);
                                    $pay_name = odbc_result($result,6);
                                    $pay_surname = odbc_result($result,7);
                                    echo '<tr id ='.odbc_result($result,1).'>
                                     <td> <input type="text" class = "pay_name" required  maxlength = "64" pattern="^[A-Za-zА-Яа-яЁёІі]{2,}" value="'.$pay_name.'"></td>
                                     <td><input type="text" class = "pay_surname" required  maxlength = "64" pattern="^[A-Za-zА-Яа-яЁёІі]{2,}" value="'.$pay_surname.'"</td>
                                     <td><input type="text" class = "email_to_send" required  pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" maxlength = "254" value="'.$email_to_send.'"></td>
                                     <td><input type="text" class = "addres" required  maxlength = "150" value="'.$addres.'"></td>
                                     <td><select class="form-control" required name = "selectservice">
                                            <option value="water" ' ;
                                    if ($service == 'water') {
                                        echo 'selected';
                                    }
                                    echo '>Вода</option>
                                              <option value="gas" ' ;
                                    if ($service == 'gas') {
                                        echo 'selected';
                                    }
                                    echo '>Газ</option>
                                              <option value="electric power"  ' ;
                                    if ($service == 'electric power') {
                                        echo 'selected';
                                    }
                                    echo '>Електроенергія</option>
                                              <option value="cleaning" ' ;
                                    if ($service == 'cleaning') {
                                        echo 'selected';
                                    }
                                    echo '>Прибирання територій</option>
                                              <option value="lift" ' ;
                                    if ($service == 'lift') {
                                        echo 'selected';
                                    }
                                    echo '>Ліфт</option>
                                            </select>
                                     </td>
                                     <td class = "delete" id = "'.odbc_result($result,1).'"><span class="glyphicon glyphicon-remove" ></span></td>
                                     </tr>';
                                      }
                                
                                 echo '   
                                     </tbody>
                                    </table>
                                     <div class="form-group">
                                 <input type="submit" value="Зберігти зміни" class="button" > 
                                        </div>
                                </form>
                                 <a  id= "go_show" aria-controls="div_show" role="tab" href="#div_show" data-toggle="tab" class="button">Выйти з режиму редагування</a>
                                </div> 

                                <!--end of changable table-->


                                <!--begine of table to show-->

                                <div class="tab-pane row cart_table active" id="div_show" role="tabpanel_tabl">
                                    <table class="table table-striped">
                                    <thead>
                                     <tr>
                                     <th>Имя</th>
                                     <th>Фамилия</th>
                                     <th>Почта для отправки чека</th>
                                     <th>Адрес</th>
                                     <th>Сервис</th>
                                     </tr>
                                     </thead>
                                     <tbody>';
                                odbc_autocommit($db_conn, FALSE);
                                 $query = "SELECT * FROM Cartitem_view   WHERE Cartitem_view.user_email_fk LIKE '".$_SESSION['user_email']."' ;"; 
                                 //echo $query;
                                 $result = odbc_exec($db_conn, $query);
                                  if (!odbc_error()) {
                                  odbc_commit($db_conn);
                                }
                                else{
                                  odbc_rollback($db_conn);
                                }
                                odbc_autocommit($db_conn, TRUE);
                                 while(odbc_fetch_row($result)){
                                    $service = odbc_result($result,3);
                                    $addres = odbc_result($result,4);
                                    $email_to_send = odbc_result($result,5);
                                    $pay_name = odbc_result($result,6);
                                    $pay_surname = odbc_result($result,7);
                                    echo '<tr id ='.odbc_result($result,1).'>
                                     <td> '.$pay_name.'</td>
                                     <td>'.$pay_surname.'</td>
                                     <td>'.$email_to_send.'</td>
                                     <td>'.$addres.'</td>
                                     <td>'.$service.'</td>
                                     </tr>';
                                      }
                                
                                 echo ' 
                                        <tr>
                                        <td class = "warning">Сума Ваших заказів :';
                                $query2 = "SELECT sum(s.service_cost)
                                            FROM service s INNER JOIN cartitem_view c
                                             On c.service_name_fk=s.service_name  
                                             WHERE c.user_email_fk LIKE '".$_SESSION['user_email']."' ;";

                                //echo $query2;
                                odbc_autocommit($db_conn, FALSE);
                                $result = odbc_exec($db_conn, $query2);
                                $cost = odbc_result($result,1);    
                                    if (!odbc_error()) {
                                  odbc_commit($db_conn);
                                }
                                else{
                                  odbc_rollback($db_conn);
                                }

                                odbc_autocommit($db_conn, TRUE);
                                odbc_close($db_conn);
                                //$query3 = " UPDATE Cart
                                 //           Set price = ".$cost."
                                 //           Where user_email_fk Like '".$_SESSION['user_email']."';";
                                //echo $query3;
                                //odbc_exec($db_conn, $query3);
                                echo''.$cost.'</td>
                                        </tr>  
                                     </tbody>
                                    </table>
                                     <a  id= "go_change" aria-controls="div_change" role="tab" href="#div_change" data-toggle="tab" class="button">Режим редагування</a>
                                </div>
                                </div>

                                </body>
                                </html>';

                            }
                            else{
                                echo "<<!DOCTYPE html>
                                <html>
                                <head>
                                    <title></title>
                                </head>
                                <body>
                                 Тут будуть відображатись заповнені форми
                                </body>
                                </html>>";
                            }
                        ?>
                       
                           
                        </p>

                        <div class="row">
                            <div class="col-xs-3"></div>
                            <div class="col-lg-6 text-center">
                                <a class="button " aria-controls="pay" role="tab" href="#pay" data-toggle="tab">До оплати</a>
                            </div>
                            <div class="col-xs-3"></div>
                        </div>
                    </div>
                </div>
                <div class="tab-pane row services-page-description" id="pay" role="tabpanel">
                    <h2>Оберіть шлях оплати</h2>
                    <div class="col-sm-4 col-sm-offset-2 col-md-4 col-md-offset-2 col-lg-3 col-lg-offset-3 img-group">
                        <a href="https://www.privat24.ua/">
                            <img src="images/privat24.png" alt="privat24" class="img-responsive">
                        </a>
                    </div>
                    <div class="col-sm-4 col-md-4 col-lg-3 img-group">
                        <a aria-controls="visa" role="tab" href="#visa" data-toggle="tab">
                            <img src="images/visa-and-mastercard.gif" alt="visa" class="img-responsive">
                        </a>
                    </div>
                </div>

                <div class="tab-pane row services-page-description" id="visa" role="tabpanel">
                    <h2>Оплата карткою</h2>
                    <div class="col-xs-6 col-sm-6 col-sm-offset-6 col-md-6 col-md-offset-3 col-lg-offset-4 col-lg-4">
                        <div class="panel panel-default credit-card-box">
                <div class="panel-heading display-table" >
                    <div class="row display-tr" >
                        <h3 class="panel-title display-td" >Payment Details</h3>
                        <div class="display-td" >                            
                            <img class="img-responsive pull-right" src="http://i76.imgup.net/accepted_c22e0.png">
                        </div>
                    </div>                    
                </div>
                <div class="panel-body">
                    <form role="form" id="payment-form" method="POST" action="javascript:void(0);">
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <label for="cardNumber">CARD NUMBER</label>
                                    <div class="input-group">
                                        <input 
                                            type="tel"
                                            class="form-control"
                                            name="cardNumber"
                                            placeholder="Valid Card Number"
                                            autocomplete="cc-number"
                                            required autofocus 
                                        />
                                        <span class="input-group-addon"><i class="fa fa-credit-card"></i></span>
                                    </div>
                                </div>                            
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-7 col-md-7">
                                <div class="form-group">
                                    <label for="cardExpiry"><span class="hidden-xs">EXPIRATION</span><span class="visible-xs-inline">EXP</span> DATE</label>
                                    <input 
                                        type="tel" 
                                        class="form-control" 
                                        name="cardExpiry"
                                        placeholder="MM / YY"
                                        autocomplete="cc-exp"
                                        required 
                                    />
                                </div>
                            </div>
                            <div class="col-xs-5 col-md-5 pull-right">
                                <div class="form-group">
                                    <label for="cardCVC">CV CODE</label>
                                    <input 
                                        type="tel" 
                                        class="form-control"
                                        name="cardCVC"
                                        placeholder="CVC"
                                        autocomplete="cc-csc"
                                        required
                                    />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <a class="button subscribe btn btn-success btn-lg btn-block" type="button">Далі</a>
                            </div>
                        </div>
                        <div class="row" style="display:none;">
                            <div class="col-xs-12">
                                <p class="payment-errors"></p>
                            </div>
                        </div>
                    </form>
                </div>
            </div>      
                    </div>
                </div>
            </div>

        </section>
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
    <!--<script src="node_modules/swiper/dist/js/swiper.jquery.min.js"></script>-->
    <!--<script src="node_modules/jquery-mask-plugin/dist/jquery.mask.min.js"></script>-->
    <!--<script src="js/script.js"></script>-->
    <script src="js/cart.js"></script>
    
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.13.1/jquery.validate.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.payment/1.2.3/jquery.payment.min.js"></script>
    <script src="js/card.js"></script>



</body>

</html>
