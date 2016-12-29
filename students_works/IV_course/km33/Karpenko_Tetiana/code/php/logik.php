<?php

session_start ();
require_once 'connect.php';

if((isset($_POST['auth_login'])&&$_POST['auth_login']!="")&&(isset($_POST['auth_pass'])&&$_POST['auth_pass']!="")){ 

    $user_email = trim($_POST['auth_login']);
    $user_password = trim($_POST['auth_pass']);
    odbc_autocommit($db_conn, FALSE);
    $query = "SELECT * FROM User_view u WHERE u.user_email LIKE '".$user_email."';";
    $result = odbc_exec($db_conn, $query);
    if (!odbc_error()) {
      odbc_commit($db_conn);
    }
    else{
      odbc_rollback($db_conn);
    }
    odbc_autocommit($db_conn, TRUE);
    $name = odbc_result($result,3);
    $pass = odbc_result($result,2);
    $surname = odbc_result($result,4);
    if($user_password==$pass){
     // log in
   		$_SESSION['user_email'] = $user_email;
      $_SESSION['user_surname'] = $surname;
      $_SESSION['user_name'] = $name;
      echo 1;
      //echo $_SESSION['user_name'];
   	}
    else if (!odbc_error()) {
      echo "0"; // wrong details 
    }
    else {
      echo 2;
    };
    odbc_close($db_conn);
}


if(isset($_POST['reg_login'])){
	$user_name = trim($_POST['reg_Fname']);
	$user_surname = trim($_POST['reg_Sname']);
	$user_email = trim($_POST['reg_login']);
  $user_password = trim($_POST['reg_pass']);
  odbc_autocommit($db_conn, FALSE);
  odbc_exec($db_conn,"SET TRANSACTION ISOLATION LEVEL SERIALIZABLE"); 
  $query = "SELECT u.user_email FROM User_view u WHERE u.user_email LIKE '".$user_email."' ;"; 
  $result = odbc_exec($db_conn, $query);
  if ($name = odbc_result($result,1)) {
    odbc_commit($db_conn);
    odbc_autocommit($db_conn, TRUE);
  	echo "0";
  }
  else {
  // registration
  	 $query = "INSERT INTO Users (user_email,user_password,user_name, user_surname) VALUES ('".$user_email."','".$user_password."','".$user_name."','".$user_surname."');" ;
     //echo $query;
  	 odbc_exec($db_conn, $query);
     if (!odbc_error()) {
      odbc_commit($db_conn);
      echo 1;
    }
  	 else {
      odbc_rollback($db_conn);
      echo 2;
    };
     odbc_autocommit($db_conn, TRUE);
  };
  odbc_close($db_conn);
}


if(isset($_POST['addFName'])){
  $pay_name = trim($_POST['addFName']);
  $pay_surname = trim($_POST['addSName']);
  $pay_email = trim($_POST['addEmail']);
  $pay_city = trim($_POST['addCity']);
  $pay_addres = htmlspecialchars($_POST['addAddress']);
  $pay_service = trim($_POST['addService']);
  odbc_autocommit($db_conn, FALSE);
  odbc_exec($db_conn,"SET TRANSACTION ISOLATION LEVEL SERIALIZABLE"); 
  $query = "insert into Cartitem (user_email_fk,service_name_fk,addres,email_to_send,pay_name,pay_surname) values ('".$_SESSION['user_email']."','".$pay_service."','".$pay_city.",".$pay_addres."','".$pay_email."','".$pay_name."','".$pay_surname."');" ;
  //echo $query;
  odbc_exec($db_conn, $query);
  if (!odbc_error()) {
      odbc_commit($db_conn);
      echo 1;
    }
     else {
      odbc_rollback($db_conn);
      echo 2;
    };
  odbc_autocommit($db_conn, TRUE);
  odbc_close($db_conn);
}

if(isset($_POST['new_pass'])){
   $old_password = trim($_POST['old_pass']);
  $new_password = trim($_POST['new_pass']);
  odbc_autocommit($db_conn, FALSE);
  odbc_exec($db_conn,"SET TRANSACTION ISOLATION LEVEL SERIALIZABLE"); 
  $query = "SELECT u.user_password FROM User_view u WHERE u.user_email LIKE '".$_SESSION['user_email']."' ;"; 
  $result = odbc_exec($db_conn, $query);
  //echo $old_password;
  if ($old_password != odbc_result($result,1)) {
    odbc_commit($db_conn);
    odbc_autocommit($db_conn, TRUE);
    echo "0";
  }
  else {
  // change pass
     $query = "UPDATE Users u Set user_password = '".$new_password."' WHERE u.user_email LIKE '".$_SESSION['user_email']."' ;" ;
     //echo $query;
     odbc_exec($db_conn, $query);
     if (!odbc_error()) {
      odbc_commit($db_conn);
      echo 1;
    }
     else {
      odbc_rollback($db_conn);
      echo 2;
    };
     odbc_autocommit($db_conn, TRUE);
  };
  odbc_close($db_conn);


};

?>