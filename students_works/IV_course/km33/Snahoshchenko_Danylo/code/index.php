<?php
$conn = odbc_connect ("IQ", "DANIL", "000000");
session_start();
if (empty($_SESSION['mail'])){header('location: login.php');}

?>




<html><head>
    <link rel="icon" href="D:\Значки\Skull.ico">
    <title>IQLevel</title>
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
            <li>
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
    <div class="cover">
      <div class="background-image-fixed cover-image" style="background-image : url('https://unsplash.imgix.net/reserve/MTuhqSiPQbeVnaIYU16X_P1160798_adj.jpg?w=1024&amp;q=50&amp;fm=jpg&amp;s=ede6dca4fff55fa0cc6ec27bcd3480d9')"></div>
      <div class="container">
        <div class="row">
          <div class="col-md-12 text-center">
            <h1 class="text-muted">Welcome!</h1>
            <p class="text-center text-muted">An intelligence quotient (IQ) is a total score derived from one of several&nbsp;
              <br>standardized tests designed to assess human intelligence.</p>
            <br>
            <br>
            <a class="btn btn-info btn-lg" href="test.php">Start Testing</a>
          </div>
        </div>
      </div>
    </div>
    <div class="section">
      <div class="container">&nbsp;</div>
    </div>
    <div class="section">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <h1 class="text-center text-muted">Famous People's IQ</h1>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <div class="container">&nbsp;</div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-3"></div>
          <div class="col-md-2">
            <img class="center-block img-circle img-responsive" src="img/Einstein.jpg">
            <h4 class="text-center">Albert Einstein</h4>
            <p class="text-center">200</p>
          </div>
          <div class="col-md-2">
            <img src="img/Leo.jpg" class="center-block img-circle img-responsive">
            <h4 class="text-center">Leo da Vinci</h4>
            <p class="text-center">180</p>
          </div>
          <div class="col-md-2">
            <img src="img/Bill.jpg" class="center-block img-circle img-responsive">
            <h4 class="text-center">Bill Gates</h4>
            <p class="text-center">160
              <br>
            </p>
          </div>
          <div class="col-md-3"></div>
        </div>
      </div>
    </div>
  

</body></html>