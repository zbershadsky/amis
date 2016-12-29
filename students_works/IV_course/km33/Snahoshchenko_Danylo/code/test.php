<?php
$conn = odbc_connect ("IQ", "DANIL", "000000");
session_start();

if (empty($_SESSION['mail'])){header('location: login.php'); session_unset();}



if (isset($_POST['submitTest'])) {
      header('location: test.php');
       $today = date("Y-m-d H:i:s");
       $_SESSION['level']=0; 
       odbc_autocommit($conn, FALSE);
        odbc_exec($conn,"SET TRANSACTION ISOLATION LEVEL SERIALIZABLE");  
      for ($i = 1; $i <= 5; $i++) {
          $radioName = "question".$i;
          $userAnswer = $_POST["$radioName"];
          if (isset($_SESSION['userAnswer'])){array_push($_SESSION['userAnswer'], $userAnswer);}
          else{$_SESSION['userAnswer'] = array($userAnswer);}
          if ($userAnswer == $_SESSION['testKeys'][$i-1]){
              $truefalse=1;} else{$truefalse=0;}

          if (isset($_SESSION['truefalse'])){array_push($_SESSION['truefalse'], $truefalse);}
          else{$_SESSION['truefalse'] = array($truefalse);}

           $_SESSION['level']= $_SESSION['level'] +$truefalse;

        $sql="begin 
              newTest('".$_SESSION['mail']."','$today', ".$_SESSION['testQuestions'][$i-1].", ".$_SESSION['truefalse'][$i-1].");
              end;";
              odbc_exec($conn,$sql);
          if($i==5){
            $_SESSION['level'] = $_SESSION['level']*40;
            $sql="begin 
              newIQ('".$_SESSION['mail']."','$today',".$_SESSION['level'].");
              end;";
              odbc_exec($conn,$sql);
          }
      }
        
        if (!odbc_error()){
          odbc_commit($conn);
          unset($_SESSION['truefalse']);
          $_SESSION['testSucces'] = 2;    
        }
        else{
        odbc_rollback($conn);
        unset($_SESSION['truefalse']);}
        odbc_autocommit($conn, TRUE);



}

if (isset($_SESSION['testSucces'])){
  $_SESSION['testSucces'] = $_SESSION['testSucces'] -1;
  if ($_SESSION['testSucces']==0){
  echo "<script type='text/javascript'>alert('Test results are stored! Your IQ level = ".$_SESSION['level']."');</script>"; 
  unset($_SESSION['level']);
  unset($_SESSION['testSucces']); }}

?>

<html><head>
    <link rel="icon" href="img\Skull.ico">
    <title>Testing</title>
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
            <li class="active">
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
              <h1 class="text-center text-muted">Testing</h1>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="section">
      <div class="container">
        <div class="row">
          <div class="col-md-4">
            <p></p>
            <p></p>
          </div>
          <div class="col-md-6">
            <h2 class="text-info">Choose only one answer:</h2>






            <form role="form" action="test.php" method="post">

<?php
$sqlTestQuest = "SELECT QNUM, RTRIM(QTEXT), AVARIANT, RTRIM(ATEXT), ACORRECT FROM availableanswers";     
$resultsetTestQuest = odbc_exec($conn, $sqlTestQuest);


unset($_SESSION['testQuestions']);
unset($_SESSION['testKeys']);

$rowCount = 0;
while (odbc_fetch_row($resultsetTestQuest)) {
$rowCount += 1;
if($rowCount==21){break;}
    if(($rowCount % 4) == 1){
      $i=($rowCount+3)/4;

      $qNum = odbc_result($resultsetTestQuest, 1);
      
      $qtext=odbc_result($resultsetTestQuest, 2);

      echo "<div class=\"form-group\" id=\"question1\">
                    <p id=\"questionText1\">".$qtext."</p>";
    }
    $aVariant = odbc_result($resultsetTestQuest, 3);
    $atext = odbc_result($resultsetTestQuest, 4);
    $aCorrect = odbc_result($resultsetTestQuest, 5);

    if ($aCorrect==1){$push=1;$testKey = $aVariant;}
    else{$push=0;}
    $i=intval(($rowCount+3)/4);
    $radioName = "question".$i;
    echo "<div class=\"radio\">
                  <label>
                    <input type=\"radio\" name=\"$radioName\"  value=\"$aVariant\" required=\"required\">$atext</label>
                </div>";
if(($rowCount % 4) == 1){
  if (isset($_SESSION['testQuestions'])){array_push($_SESSION['testQuestions'], $qNum);}
  else{$_SESSION['testQuestions'] = array($qNum);}
}
if ($push==1){
  if (isset($_SESSION['testKeys'])){array_push($_SESSION['testKeys'], $testKey);}
  else{$_SESSION['testKeys'] = array($testKey);}  
}



}


?>
<button type="submit" name="submitTest" class="btn btn-info btn-lg">Submit</button>
</form>


          </div>
        </div>
      </div>
    </div>
  

</body></html>