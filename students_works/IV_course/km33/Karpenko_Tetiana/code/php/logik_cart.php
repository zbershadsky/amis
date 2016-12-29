<?php

session_start ();
require_once 'connect.php';

if(isset($_POST['id'])){
  $pay_name = trim($_POST['addFName']);
  $pay_surname = trim($_POST['addSName']);
  $pay_email = trim($_POST['addEmail']);
  $pay_addres = trim($_POST['addAddres']);
  $pay_service = trim($_POST['addService']);
  $id = trim($_POST['id'])-13;
  odbc_autocommit($db_conn, FALSE);
  $query = "UPDATE Cartitem  
  SET service_name_fk= '".$pay_service."',
  addres= '".$pay_addres."',
  email_to_send= '".$pay_email."' ,
  pay_name= '".$pay_name."',
  pay_surname='".$pay_surname."'
  WHERE Cartitem.item_num  = '".$id."';";
  //echo $query;
  odbc_exec($db_conn, $query);
    if (!odbc_error()) {
      odbc_commit($db_conn);
      echo 1;
    }
    else{
      odbc_rollback($db_conn);
    }

    odbc_autocommit($db_conn, TRUE);
  odbc_close($db_conn);
}

if(isset($_POST['idtodel'])){
	$id = trim($_POST['idtodel'])-13;
	odbc_autocommit($db_conn, FALSE);
	odbc_exec($db_conn,"SET TRANSACTION ISOLATION LEVEL SERIALIZABLE"); 
	$query = "DELETE FROM Cartitem
    WHERE Cartitem.item_num = '".$id."';";
    odbc_exec($db_conn, $query);
    if (!odbc_error()) {
      echo 1;
      odbc_commit($db_conn);
    }
    else{
      odbc_rollback($db_conn);
    }

    odbc_autocommit($db_conn, TRUE);
  	odbc_close($db_conn);
}



?>