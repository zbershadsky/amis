

<?php
$conn = odbc_connect ("IQ", "DANIL", "000000");
session_start();
if (empty($_SESSION['mail'])){header('location: login.php'); session_unset();}
elseif ($_SESSION['admin']==0) {
	header('location: profile.php');
}
	
  if(isset($_GET['questid'])){
  $_SESSION['questid'] = $_GET['questid']; }

    if (isset($_POST['submitEditQuest'])) {
      header('location: Edit.php');
      $editQuest = htmlspecialchars($_POST['answ0']);
      $editAnswA = htmlspecialchars($_POST['answ1']);
      $editAnswB = htmlspecialchars($_POST['answ2']);
      $editAnswC = htmlspecialchars($_POST['answ3']);
      $editAnswD = htmlspecialchars($_POST['answ4']);
      $editAnswCorrect = $_POST['answCorrect'];
      $sql = "SELECT count(*) from availableQuestions where rtrim(QTEXT)='$editQuest' and QNUM!=".(int)$_SESSION['questid'];
      $resultset = odbc_exec($conn, $sql);
      $rowExist = odbc_result($resultset, 1);
      if ($rowExist==1){ 
	    $_SESSION['rowExist'] = 2;}
      else{

        odbc_autocommit($conn, FALSE);
        
        $sql="begin 
              EditQuestionAnswers(".(int)$_SESSION['questid'].", '$editQuest', '$editAnswA', '$editAnswB', '$editAnswC', '$editAnswD', '$editAnswCorrect');
              end;";
        
        odbc_exec($conn,$sql);
        if (!odbc_error()){
          odbc_commit($conn);
          $_SESSION['editSucces'] = 2;    
        }
        else{odbc_rollback($conn);}
        odbc_autocommit($conn, TRUE);

      }
  }
	  unset($_SESSION['sql']) ;
if (isset($_SESSION['editSucces'])){
  $_SESSION['editSucces'] = $_SESSION['editSucces'] -1;
  if ($_SESSION['editSucces']==0){
  echo "<script type='text/javascript'>alert('Question successfully edit!');</script>"; unset($_SESSION['editSucces']);}}

if (isset($_SESSION['rowExist'])){
  $_SESSION['rowExist'] = $_SESSION['rowExist'] -1;
  if ($_SESSION['rowExist']==0){
  echo "<script type='text/javascript'>alert('Sorry! This question is already exist');</script>"; unset($_SESSION['rowExist']);}}

  
?>



<html><head>
    <link rel="icon" href="img\Skull.ico">
    <title>Questions</title>
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
              <h1 class="text-center text-muted">Question processing</h1>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="section">
      <div class="container">
        <div class="row">
          <div class="col-md-6">
            <h2 class="text-warning">Edit questions</h2>
          </div>
        </div>
      </div>
    </div>
    <div class="section">
      <div class="container">
        <div class="row">
          <div class="col-md-6">
            <form class="form-horizontal" role="form" action="Edit.php" method="post">
              <div class="form-group">
                <div class="col-sm-3">
                  <label class="control-label">Question</label>
                </div>
                <div class="col-sm-9">
                  <textarea class="form-control" name="answ0" id="answ0" value="" required="" maxlength="100"></textarea>
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-1">
                  <input type="radio" id="correct1" name="answCorrect" value="A" required="">
                </div>
                <div class="col-sm-2">
                  <label class="control-label">Answer&nbsp;A:</label>
                </div>
                <div class="col-sm-9">
                  <input type="text" class="form-control" name="answ1" id="answ1" required="" maxlength="10">
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-1">
                  <input type="radio" id="correct2" name="answCorrect" value="B" required="">
                </div>
                <div class="col-sm-2">
                  <label class="control-label">Answer&nbsp;B:</label>
                </div>
                <div class="col-sm-9">
                  <input type="text" class="form-control" name="answ2" id="answ2" required="" maxlength="10">
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-1">
                  <input type="radio" id="correct3" name="answCorrect" value="C" required="">
                </div>
                <div class="col-sm-2">
                  <label class="control-label">Answer&nbsp;C:</label>
                </div>
                <div class="col-sm-9">
                  <input type="text" class="form-control" name="answ3" id="answ3" required="" maxlength="10">
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-1">
                  <input type="radio" id="correct4" name="answCorrect" value="D" required="">
                </div>
                <div class="col-sm-2">
                  <label class="control-label">Answer&nbsp;D:</label>
                </div>
                <div class="col-sm-9">
                  <input type="text" class="form-control" name="answ4" id="answ4" required="" maxlength="10">
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                  <button type="submit" name="submitEditQuest" class="btn btn-lg btn-warning">Edit question</button>
                </div>
              </div>
            </form>
          </div>
<?php          


    

    $sqlAllQuest = "SELECT RTRIM(QTEXT), RTRIM(ATEXT), ACORRECT FROM availableAnswers WHERE QNUM =".$_SESSION['questid'];      
    $resultsetAllAnsw = odbc_exec($conn, $sqlAllQuest);
    $i=1;
    while (odbc_fetch_row($resultsetAllAnsw)) {
    	$qText = odbc_result($resultsetAllAnsw, 1);
		$aText = odbc_result($resultsetAllAnsw, 2);
        $aCorrect = odbc_result($resultsetAllAnsw, 3);
    	if($i==1){
            
            $inputId = "answ".($i-1);
            
			echo "<script type='text/javascript'>document.getElementById('$inputId').value = '$qText';</script>";
    	}
    	$inputId = "answ".$i;
    	echo "<script type='text/javascript'>document.getElementById('$inputId').value = '$aText';</script>";
    	
        if($aCorrect==1){
        	$radioId="correct".$i;
        	echo "<script type='text/javascript'>document.getElementById('$radioId').checked = 'TRUE';</script>";
        }
        $i+=1;
        }
?>




 

</body></html>