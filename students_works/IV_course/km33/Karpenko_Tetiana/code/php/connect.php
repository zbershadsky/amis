 <?php 

 $db_con_name = "PAYGO";
 $db_root = "tania";
 $db_pass = "qwer";
    
    try {
    $db_conn=odbc_connect($db_con_name,$db_root,$db_pass);
    }

    catch (Exception $e)
    {
      echo "Something went wrong!";
    }


    //print ("\n");
    //$query = "SELECT name,ID FROM Customers";
    //$result = odbc_exec($conn, $query);
    //while(odbc_fetch_row($result)){
    //  $name = odbc_result($result,1);
    //  $id = odbc_result($result,2);
    //  print("$name$id\n");
    // }

     //odbc_close($conn);

?>