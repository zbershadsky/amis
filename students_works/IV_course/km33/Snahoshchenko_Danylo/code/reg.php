<?php
$conn = odbc_connect ("IQ", "DANIL", "000000");
session_start();
if (isset($_POST['submitReg'])) {
  header('location: reg.php');
  $name = htmlspecialchars($_POST['name']);
  $surname = htmlspecialchars($_POST['surname']);
  $mail = md5(htmlspecialchars($_POST['mail']));
  $password = md5(htmlspecialchars($_POST['password']));

  $sql = "SELECT count(*) from users where rtrim(mail)='$mail'";
  $resultset = odbc_exec($conn, $sql);
  $rowExist = odbc_result($resultset, 1);

  if ($rowExist==1){ 
    $_SESSION['userExist'] = 2; 
               
  }
  else{
    odbc_autocommit($conn, FALSE);
    odbc_exec($conn,"SET TRANSACTION ISOLATION LEVEL SERIALIZABLE");
    $sql="begin 
          newUser('$name', '$surname', '$mail', '$password');
          end;";
    odbc_exec($conn,$sql);
    if (!odbc_error()){
      odbc_commit($conn);
      $_SESSION['regSucces'] = 2;     
    }
    else{odbc_rollback($conn);}
    odbc_autocommit($conn, TRUE);

  }  
}
if (isset($_SESSION['regSucces'])){
  $_SESSION['regSucces'] = $_SESSION['regSucces'] -1;
  if ($_SESSION['regSucces']==0){ 
  header('location: login.php');
}}

if (isset($_SESSION['userExist'])){
  $_SESSION['userExist'] = $_SESSION['userExist'] -1;
  if ($_SESSION['userExist']==0){
  echo "<script type='text/javascript'>alert('Sorry! User whith this email is already exist');</script>"; 
  unset($_SESSION['userExist']);
}}

?>








<html><head>
    <link rel="icon" href="img\Skull.ico">
    <title>Regestration</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" type="text/css">
    <!--<link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css"
    rel="stylesheet" type="text/css"> -->
    <link rel="stylesheet" href="bootstrap/css/bootstrap-theme.min.css" type="text/css">
    <script type="text/javascript" src="./jquery/jquery.min.js"></script>
    <script type="text/javascript" src="./bootstrap/js/bootstrap.min.js"></script>
  </head><body>
    <div class="navbar navbar-default navbar-inverse navbar-static-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-ex-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="login.php">IQ Level</a>
        </div>
        <div class="collapse navbar-collapse" id="navbar-ex-collapse">
          <ul class="nav navbar-nav navbar-right">
            <li class="active">
              <a href="reg.php">My profile</a>
            </li>
            <li>
              <a href="test.php">Test</a>
            </li>
            <li>
              <a href="">Top10</a>
            </li>
          </ul>
        </div>
      </div>
    </div>
    <div class="section">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <div class="page-header">
              <h1 class="text-center text-muted">Regestration</h1>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="section">
      <div class="container">
        <div class="row">
          <div class="col-md-6">
            <form class="form-horizontal" role="form" action="reg.php" method="post">
              <div class="form-group">
                <div class="col-sm-2">
                  <label class="control-label">Name</label>
                </div>
                <div class="col-sm-10">
                  <input type="text" class="form-control" name="name" minlength="3" maxlength="12" pattern="^[a-zA-Z]+$" required="">
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-2">
                  <label class="control-label">Surname</label>
                </div>
                <div class="col-sm-10">
                  <input type="text" class="form-control" name="surname" minlength="3" maxlength="12" pattern="^[a-zA-Z]+$" required="">
                </div>
              </div>
              
              
              <div class="form-group">
                <div class="col-sm-2">
                  <label class="control-label" for="inputEmail3">Email</label>
                </div>
                <div class="col-sm-10">
                  <input type="email" class="form-control" id="mail" name="mail" placeholder="Email" required="" minlength="8" maxlength="30">
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-2">
                  <label class="control-label" for="inputPassword3">Password</label>
                </div>
                <div class="col-sm-10">
                  <input type="password" class="form-control" id="password" name="password" placeholder="Password" minlength="6" maxlength="16" required="">
                </div>
              </div>
              <center>
                
                <button type="submit" name="submitReg" class="btn btn-info btn-lg">&nbsp;&nbsp;OK&nbsp;&nbsp;</button>
              </center>
              
            </form>
          </div>

        </div>
      </div>
    </div>

  

</body></html>