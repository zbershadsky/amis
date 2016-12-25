
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
  <%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
 
<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css"
    rel="stylesheet" type="text/css">
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.js"></script>
<title>Product</title>
 
<link rel="stylesheet" type="text/css" href="style.css">
 
</head>
<body>
 
    <jsp:include page="_header.jsp" />
 
<div class="row">
          <div class="col-md-12">
            <h1 class="text-center">Реєстрація</h1>
          </div>
        </div>     
         <div class="section">
      <div class="container">
        <div class="row">
                  <div class="col-md-12">
         
        <h3>Введіть логін та пароль</h3>
    <c:if test="${not empty errorMessage }">
      <div class="error-message">
          ${errorMessage}
      </div>
    </c:if>
 
    <form:form modelAttribute="userForm" method="POST"          
       action="${pageContext.request.contextPath}/registration">

                    <div class="form-group">

                <label class="control-label" for="exampleInputEmail1">Логін</label>
                   
                        <form:input   class="form-control" path="userName"  />
                        <form:errors path="userName" class="error-message" />
            
 
 </div>
             			<div class="form-group">
                <label class="control-label" for="exampleInputPassword1">Пароль</label>

                <form:input path="password" class="form-control" type = "password" />
                <form:errors path="password" class="error-message" />
            
          </div>
 
            <input type="submit" class="btn btn-default" value="Зареєструватись" /> <input type="reset"
               class="btn btn-default" value="Скинути" />
        
    </form:form>
 
 
 </div>
 </div>
 </div>
 </div>
 
 
    <jsp:include page="_footer.jsp" />
 
</body>
</html>

