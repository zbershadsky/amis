<!DOCTYPE html> 
<html lang="ua"> 

<head> 
<meta charset="utf-8"> 
<meta http-equiv="X-UA-Compatible" content="IE=edge"> 
<meta name="viewport" content="width=device-width, initial-scale=1"> 
<!� The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags �> 
<title>Divorce Call Manager</title> 
<meta name="Description" content="Divorce easily"> 
<meta name="Keywords" content="divorce, want divorce"> 
<meta name="Author" Content="Irina Brisyk"> 
<meta name="Reply-to" Content="saboiren444@gmail.com"> 

<!� Bootstrap �> 
<link href="css/bootstrap.css" rel="stylesheet"> 
<link href="css/style.css" rel="stylesheet"> 
<link href="fonts.css" rel="stylesheet"> 
<link rel="icon" type="image/png" href="img/favicon.ico" /> 
<link rel="apple-touch-icon" href="img/favicon.ico" /> 
<link href='https://fonts.googleapis.com/css?family=Roboto+Slab:300|Exo+2:400,700&subset=latin,cyrillic' rel='stylesheet' type='text/css'> 


<!� HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries �> 
<!� WARNING: Respond.js doesn't work if you view the page via file:// �> 
<!--[if lt IE 9]> 
<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script> 
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script> 
<![endif]--> 

</head> 

<body> 
<div class="container-fluid"> 
<div class="row"> 
<div class="navbar navbar-default navbar-fixed-top" role="navigation"> 
<div class="container"> 
<div class="navbar-header"> 
<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#responsive-menu"> 
<span class="sr-only">Open Nav</span> 
<span class="icon-bar"></span> 
<span class="icon-bar"></span> 
<span class="icon-bar"></span> 
</button> 
<a href="file:///C:/Users/DELL/Documents/bootstrap-3.3.7-dist/mainmain.jsp" class="navbar-brand">
Main</a> </div> 
<div class="collapse navbar-collapse" id="responsive-menu"> 
<ul class="nav navbar-nav"> 
<li id=""><a href="file:///C:/Users/DELL/Documents/bootstrap-3.3.7-dist/lawer1.jsp"><span class="glyphicon glyphicon-user" aria-hidden="true"></span> 
Concurrency</a></li>  <li id=""><a href="file:///C:/Users/DELL/Documents/bootstrap-3.3.7-dist/client1.jsp" style="margin-left:20px"><span class="glyphicon glyphicon-star" aria-hidden="true"></span> My Page</a></li> 
<!--li id=""><a href="comments.jsp"><span class="glyphicon glyphicon-list" aria-hidden="true"></span> Comments</a></li--> 
<li id=""><a href="signup.jsp"><span class="glyphicon glyphicon-book" aria-hidden="true"></span> Laws</a></li> 
<li id=""><a href="file:///C:/Users/DELL/Documents/bootstrap-3.3.7-dist/Main1.jsp"><span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span> Blanks</a></li> 
<li id=""><a href="signup.jsp"><span class="glyphicon glyphicon-question-sign" aria-hidden="true"></span> Questions</a></li> 

</ul> 


</div> 


</div> 
</div> 

</div></div> 

<div class="container" style="padding-top:60px"> 
<div class="row"> 
<h1>Greetins</h1> 
<!--h2>Please enter your information to find a suitable lawer:</h2--> 
<div class="col-lg-3 col-md-3 col-sm-3 col-sm-3"> 
<img src="img/picturetaximain.png" alt="" class="img-responsive center-block hidden-xs"> 
</div> 
<div class="col-lg-1 col-md-1 col-sm-1 col-xs-1"></div> 
<div class="col-lg-8 col-md-8 col-sm-8 col-xs-8"> 
 <form action="/auth" method="post" enctype="text/plain">

<p class="roboto1" style="padding-top:50px">Name<span style="color:red">*</span>: 
<input type="text" style="margin-right=5px; " placeholder="Ivan" maxlength="16" required> 
</p> 
<p class="roboto1">Password<span style="color:red">*</span>: 
<input type="password" placeholder="password" maxlength="12" required> 
</p>
<p class="roboto1">Telephone<span style="color:red">*</span>: 
<input type="text" id="check" step="any" style="margin-right=5px; "  placeholder="380992462677" maxlength="12" required> 
<script>
document.getElementById('check').onkeypress = function (e) {
  return !(/[�-��-�A-Za-z ]/.test(String.fromCharCode(e.charCode)));
}

</script>
<p class="roboto1">Experience<span style="color:red">*</span>: 
<input type="text" id="check2" step="any" style="margin-right=5px; "  placeholder="5" maxlength="2" required> 
<script>
document.getElementById('check2').onkeypress = function (e) {
  return !(/[�-��-�A-Za-z ]/.test(String.fromCharCode(e.charCode)));
}

</script>
<p class="roboto1">Gander:
	<input type="radio" name="drink" value="rad1"> Male
   <input type="radio" name="drink" value="rad2"> Female<Br>
</p>
<p class="roboto1">email<span style="color:red">*</span>: 
<input type="email" placeholder="iravun@gmail.com" maxlength="12" required> 
</p>
<p class="roboto1">Calendar<span style="color:red">*</span>: 
<input type="date" name="calendar">
</p>
  <!--p><input type="submit" class="btn btn-success" value="Registration"></p>
 </form--> 
  <p><input type="submit" class="btn btn-success" value="Registration"></p>
 </form>
<br> 
<br> 
<br>


</div> 
</div> 
</div> 
</div> 

<div class="container"> 
<br> 
<br> 


<hr> 
<div class="row"> 
<div class="col-xs-7"><span class="design"> 
Design and developing by:
</span> 
<a href="mailto:saboiren444@gmail.com" style="color:black;" target="_blank">saboiren444@gmail.com</a> 
</div> 
<div class="col-xs-5"> 
<p class="text-muted pull-right">� 2016 DivorceCallManager. All rights reserved</p> 
</div> 
</div> 
</div> 





<!� jQuery (necessary for Bootstrap's JavaScript plugins) �> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<!� Include all compiled plugins (below), or include individual files as needed �> 

<script src="js/bootstrap.js"></script> 

<script src="js/scroll.js"></script> 



</body> 

</html>