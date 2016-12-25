<?php
session_start();

if (empty($_SESSION['mail'])){header('location: login.php'); session_unset();}

?>


<html><head>
    <link rel="icon" href="img\Skull.ico">
    <title>Profile</title>
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
          <a class="navbar-brand" href="index.php">IQ Level</a>
        </div>
        <div class="collapse navbar-collapse" id="navbar-ex-collapse">
          <ul class="nav navbar-nav navbar-right">
            <li>
              <?php 
              echo "<a>Hello, ".$_SESSION['name']."</a>";
              ?>
            </li>
            <li class="active">
              <a href="profile.php">My profile</a>
            </li>
            <li>
              <a href="test.php">Test</a>
            </li>
            <li>
              <a href="">Top10</a>
            </li>
            <li>
              <a href="login.php?logout=true">Logout</a>
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
              <h1 class="text-center text-muted">Profile</h1>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="section">
      <div class="container">
        <div class="row">
          <div class="col-md-6">
            <?php
              if ($_SESSION['admin']==1){
                echo "<a href=\"admin.php\" class=\"text-success\"><h2>Go to question processing</h2></a>";
              }
            ?>
          </div>

        </div>
      </div>
    </div>

  

</body></html>