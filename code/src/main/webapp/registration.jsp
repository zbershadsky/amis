<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registration</title>
</head>
<body>

<div></div>
<div>
    <h2>Registration Form</h2>
    <br>
    <form action="/reg" method="post">

        <div class="form-group">
            <label for="inputLogin">Enter login</label>
            <input type="text" class=form-control" name="login" id="inputLogin" maxlength="30" required>
        </div>

        <div class="form-group">
            <label for="inputEmail">Enter email address:</label>
            <input type="email" class="form-control" name = "email" id="inputEmail"  maxlenght="30" required>
            <small id="emailHelp" class="form-text text-muted">Create your email</small>
        </div>

        <div class="form-group">
            <label for="inputPass">Create password:</label>
            <input type="password" class="form-control" id="inputPass" maxlength="25" name="password" required>
            <small id="passHelp" pattern="^[A-Za-z0-9]+$" class="form-text text-muted">You have to come up with a strong password</small>
        </div>

        <div class="form-group">
            <label for="inputRePass">Repeat password:</label>
            <input type="password" class="form-control" pattern="^[A-Za-z0-9]+$" id="inputRePass" name="re_password"  maxlength="25"  required>
        </div>
        <br />
        <div class="text-right">
            <button type="submit" onClick="check_pass()" class="btn btn-primary">Send</button>
        </div>
    </form>
</div>
<script>
    function check_pass(){
        var pass = document.getElementById("inputPass").value();
        var repass = document.getElementById("inputRePass").value();
        if(pass != repass){
            alert("Passwords is not equals");
        }
    }
</script>
</body>
</html>