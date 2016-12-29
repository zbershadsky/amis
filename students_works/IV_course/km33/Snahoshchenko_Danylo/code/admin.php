<?php

  
  $conn = odbc_connect ("IQ", "DANIL", "000000");


 session_start();
 if (empty($_SESSION['mail'])){header('location: login.php'); session_unset();}
elseif ($_SESSION['admin']==0) {
  header('location: profile.php');
}
  if (isset($_POST['submitAddQuest'])) {
      header('location: admin.php');
      $newQuest = htmlspecialchars($_POST['newQuest']);
      $newAnswA = htmlspecialchars($_POST['newAnswA']);
      $newAnswB = htmlspecialchars($_POST['newAnswB']);
      $newAnswC = htmlspecialchars($_POST['newAnswC']);
      $newAnswD = htmlspecialchars($_POST['newAnswD']);
      $newAnswCorrect = $_POST['newAnswCorrect'];
      $sql = "SELECT count(*) from availableQuestions where rtrim(QTEXT)='$newQuest'";
      $resultset = odbc_exec($conn, $sql);
      $rowExist = odbc_result($resultset, 1);
      if ($rowExist==1){ 
        $_SESSION['rowExist'] = 2;              
      }
      else{
        odbc_autocommit($conn, FALSE);
        odbc_exec($conn,"SET TRANSACTION ISOLATION LEVEL SERIALIZABLE");
        $sql="begin 
              InsertQuestionAnswers('$newQuest', '$newAnswA', '$newAnswB', '$newAnswC', '$newAnswD', '$newAnswCorrect');
              end;";
        odbc_exec($conn,$sql);
        if (!odbc_error()){
          odbc_commit($conn);
          $_SESSION['insertSucces'] = 2;    
        }
        else{odbc_rollback($conn);}
        odbc_autocommit($conn, TRUE);

      }
  }

if (isset($_SESSION['questions'])){
  foreach ($_SESSION['questions'] as $value){
    $delButton ="delButton".$value;
    if (isset($_POST["$delButton"])) {
                  header("Location: admin.php");
                  odbc_autocommit($conn, FALSE);
                
                  $sqlDelQuest = "begin
                                  DeleteQuestion($value);
                                  end;";
                  odbc_exec($conn, $sqlDelQuest);
                  
                  
                  if (!odbc_error()){
                    odbc_commit($conn);
                    $_SESSION['deleteStatus'] = 2;

                  }
                  else{odbc_rollback($conn);}
                  odbc_autocommit($conn, TRUE);
                  

                }}}



if (isset($_SESSION['deleteStatus'])){
  $_SESSION['deleteStatus'] = $_SESSION['deleteStatus'] -1;
  if ($_SESSION['deleteStatus']==0){
  echo "<script type='text/javascript'>alert('Question successfully deleted!');</script>"; unset($_SESSION['deleteStatus']);}}

if (isset($_SESSION['insertSucces'])){
  $_SESSION['insertSucces'] = $_SESSION['insertSucces'] -1;
  if ($_SESSION['insertSucces']==0){
  echo "<script type='text/javascript'>alert('Question successfully inserted!');</script>"; unset($_SESSION['insertSucces']);}}

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
    <script type="text/javascrip "></script>
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
            <h2 class="text-success">Add new question</h2>
          </div>
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
            <form class="form-horizontal" role="form" action="admin.php" method="post">
              <div class="form-group">
                <div class="col-sm-3">
                  <label class="control-label">Question</label>
                </div>
                <div class="col-sm-9">
                  <textarea class="form-control" name="newQuest" required="" maxlength="100"></textarea>
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-1">
                  <input type="radio" name="newAnswCorrect" value="A" required="">
                </div>
                <div class="col-sm-2">
                  <label class="control-label">Answer&nbsp;A:</label>
                </div>
                <div class="col-sm-9">
                  <input type="text" class="form-control" name="newAnswA" required="" maxlength="10">
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-1">
                  <input type="radio" name="newAnswCorrect" value="B" required="">
                </div>
                <div class="col-sm-2">
                  <label class="control-label">Answer&nbsp;B:</label>
                </div>
                <div class="col-sm-9">
                  <input type="text" class="form-control" name="newAnswB" required="" maxlength="10">
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-1">
                  <input type="radio" name="newAnswCorrect" value="C" required="">
                </div>
                <div class="col-sm-2">
                  <label class="control-label">Answer&nbsp;C:</label>
                </div>
                <div class="col-sm-9">
                  <input type="text" class="form-control" name="newAnswC" required="" maxlength="10">
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-1">
                  <input type="radio" name="newAnswCorrect" value="D" required="">
                </div>
                <div class="col-sm-2">
                  <label class="control-label">Answer&nbsp;D:</label>
                </div>
                <div class="col-sm-9">
                  <input type="text" class="form-control" name="newAnswD" required="" maxlength="10">
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                  <button type="submit" name="submitAddQuest" class="btn btn-lg btn-success">Add question</button>
                </div>
              </div>
            </form>
          </div>
          

          <div class="col-md-6">

<?php 
        
          $sqlAllQuest = "SELECT QNUM, RTRIM(QTEXT) FROM availableQuestions order by QNUM";       
           $resultsetAllQuest = odbc_exec($conn, $sqlAllQuest);

            unset($_SESSION['questions']);
           $rowCount = 0;
           while (odbc_fetch_row($resultsetAllQuest)) {
            $rowCount += 1;
            $qNum = odbc_result($resultsetAllQuest, 1);
            $qText = odbc_result($resultsetAllQuest, 2); 
            $editButton ="editButton".$qNum;
            $delButton ="delButton".$qNum;
            $formEditDel = "formEditDel".$qNum;
            $hrefEdit ="Edit.php?questid=".$qNum;
            if (isset($_SESSION['questions'])){array_push($_SESSION['questions'], $qNum);}
            else{$_SESSION['questions'] = array($qNum);}
            

            echo "
              <form id=\"$formEditDel\" action=\"admin.php\" method=\"post\">
              <p>$qText</p>
              <a class=\"btn btn-warning\" name=\"$editButton\"  href=\"$hrefEdit\">Edit</a>
              <button type=\"submit\" class=\"btn btn-danger\" id =\"$delButton\" name=\"$delButton\" >Delete</button>
              
              </form>";

            

                
            }
            if ($rowCount <= 5){
              foreach ($_SESSION['questions'] as $value){
                $delButton ="delButton".$value;
                echo "<script type='text/javascript'>document.getElementById(\"$delButton\").disabled = true;</script>";}}
             

            
            ?>
            

            





          </div>
        </div>
      </div>
    </div>
    <div class="modal" id="editQuest">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h4 class="modal-title">Edit</h4>
          </div>
          <div class="modal-body">
            <form class="form-horizontal" role="form" id="editForm">
              <div class="form-group">
                <div class="col-sm-3">
                  <label class="control-label">Question</label>
                </div>
                <div class="col-sm-9">
                  <textarea class="form-control" required="" maxlength="100"></textarea>
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-1">
                  <input type="radio" name="correctAnswer" value="A" required="">
                </div>
                <div class="col-sm-2">
                  <label class="control-label">Answer&nbsp;A:</label>
                </div>
                <div class="col-sm-9">
                  <input type="text" class="form-control" required="" maxlength="10">
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-1">
                  <input type="radio" name="correctAnswer" value="B" required="">
                </div>
                <div class="col-sm-2">
                  <label class="control-label">Answer&nbsp;B:</label>
                </div>
                <div class="col-sm-9">
                  <input type="text" class="form-control" required="" maxlength="10">
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-1">
                  <input type="radio" name="correctAnswer" value="C" required="">
                </div>
                <div class="col-sm-2">
                  <label class="control-label">Answer&nbsp;C:</label>
                </div>
                <div class="col-sm-9">
                  <input type="text" class="form-control" required="" maxlength="10">
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-1">
                  <input type="radio" name="correctAnswer" value="D" required="">
                </div>
                <div class="col-sm-2">
                  <label class="control-label">Answer&nbsp;D:</label>
                </div>
                <div class="col-sm-9">
                  <input type="text" class="form-control" required="" maxlength="10">
                </div>
              </div>
              
            </form>
          </div>
          <div class="modal-footer">
            <a class="btn btn-default" data-dismiss="modal">Close</a>
            <button type="submit" class="btn btn-warning" form="editForm">Save changes</button>
          </div>
        </div>
      </div>
    </div>
  

</body></html>