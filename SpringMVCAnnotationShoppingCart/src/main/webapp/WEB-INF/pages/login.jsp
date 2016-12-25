<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css"
    rel="stylesheet" type="text/css">
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.js"></script>
<title>Авторизація</title>
 
<link rel="stylesheet" type="text/css" href="style.css">
 
</head>
<body>
 
 
    <jsp:include page="_header.jsp" />
 
 
  <div class="row">
          <div class="col-md-12">
            <h1 class="text-center">Авторизація</h1>
          </div>
        </div>   
 
 <div class="section">
      <div class="container">
        <div class="row">
                  <div class="col-md-12">
         
        <h3>Введіть логін та пароль</h3>
        <br>
        <!-- /login?error=true -->
        <c:if test="${param.error == 'true'}">
            <div style="color: red; margin: 10px 0px;">
 
                Login Failed!!!<br /> Reason :
                ${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}
 
            </div>
        </c:if>
 
        <form method="POST"
            action="${pageContext.request.contextPath}/j_spring_security_check" >
            <div class="form-group">
                <label class="control-label" for="exampleInputEmail1">Логін</label>
                <input name="userName" class="form-control" id="exampleInputEmail1"
                placeholder="Введіть логін" type="text"/>
                
 			</div>
 			<div class="form-group">
                <label class="control-label" for="exampleInputPassword1">Пароль</label>
                <input class="form-control" id="exampleInputPassword1"
                placeholder="Введіть пароль" type="password" name="password">
              </div>
               
               <input type="submit" class="btn btn-default" value="Авторизуватись" /> <input type="reset"
               class="btn btn-default" value="Скинути" />
        </form>
 
        <span class="error-message">${error }</span>
 
    </div>
 </div>
 </div>
 </div>
 
    <jsp:include page="_footer.jsp" />
 
</body>
</html>

