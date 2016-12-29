<?php

session_start();
if((isset($_POST['auth_login'])&&$_POST['auth_login']!="")&&(isset($_POST['auth_pass'])&&$_POST['auth_pass']!="")){ 

    $user_email = trim($_POST['auth_login']);
    $user_password = trim($_POST['auth_pass']);
    


}
?>