<?php
$conn = odbc_connect ("IQ", "DANIL", "000000");
session_start();

if (isset($_SESSION['questions'])) {  unset($_SESSION['questions']);}


if (isset($_SESSION['regSucces'])) {
  echo "<script type='text/javascript'>alert('Regestration successfull');</script>";
  unset($_SESSION['regSucces']);}

if (isset($_GET['logout'])) {
    session_unset();
  }

if (isset($_POST['submitLogin'])){
  header('location: login.php');
  $mail = md5(htmlspecialchars($_POST['mail']));
  $password = md5(htmlspecialchars($_POST['password']));

  $sql = "SELECT count(*) from Users where mail='$mail' and userpassword = '$password' ";
  $resultset = odbc_exec($conn, $sql);
  $rowCount = odbc_result($resultset, 1);

  if ($rowCount==1){
      $sql = "SELECT username, adminstatus from Users where mail='$mail' and userpassword = '$password' ";
      $resultset = odbc_exec($conn, $sql);
      $_SESSION['mail'] = $mail;
      $_SESSION['name'] = odbc_result($resultset, 1);
      $_SESSION['admin'] = odbc_result($resultset, 2);
      $_SESSION['loginSucces'] = 2;
  } else{
      $_SESSION['loginFailed'] = 2;
  }
  
}

if (isset($_SESSION['loginSucces'])){
  $_SESSION['loginSucces'] = $_SESSION['loginSucces'] -1;
  if ($_SESSION['loginSucces']==0){ 
  unset($_SESSION['loginSucces']);
  header('location: index.php');
}}

if (isset($_SESSION['loginFailed'])){
  $_SESSION['loginFailed'] = $_SESSION['loginFailed'] -1;
  if ($_SESSION['loginFailed']==0){
  echo "<script type='text/javascript'>alert('Sorry! User does not exist');</script>"; 
  unset($_SESSION['loginFailed']);
}}

?>


<html><head>
    <link rel="icon" href="img\Skull.ico">
    <title>Login</title>
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
          <a class="navbar-brand" href="">IQ Level</a>
        </div>
        <div class="collapse navbar-collapse" id="navbar-ex-collapse">
          <ul class="nav navbar-nav navbar-right">
            <li class="active">
              <a href="login.php">My profile</a>
            </li>
            <li>
              <a href="">Test</a>
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
              <h1 class="text-center text-muted">Login</h1>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="section">
      <div class="container">
        <div class="row">
          <div class="col-md-6">
            <form class="form-horizontal" role="form" action="login.php" method="post">
              <div class="form-group">
                <div class="col-sm-2">
                  <label for="inputEmail3" class="control-label">Email</label>
                </div>
                <div class="col-sm-10">
                  <input type="email" class="form-control input-sm" id="mail" name="mail" placeholder="Email" minlength="8" maxlength="30" required="">
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-2">
                  <label for="inputPassword3" class="control-label">Password</label>
                </div>
                <div class="col-sm-10">
                  <input type="password" class="form-control input-sm" id="password" name="password" placeholder="Password" minlength="6" maxlength="16" required="">
                </div>
              </div>

              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                  <button type="submit" name="submitLogin" class="btn btn-lg btn-success">Sign in</button>
                </div>
              </div>
            </form>
          </div>
          <div class="col-md-6">
            <h2 class="text-center text-info">Join us now!</h2>&nbsp;
            <center>
              <a class="btn btn-info btn-lg"  href="reg.php">Reristration</a>
            </center>
          </div>
        </div>
      </div>
    </div>

  

</body></html>