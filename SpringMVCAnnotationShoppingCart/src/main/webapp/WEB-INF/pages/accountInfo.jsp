<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
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
<title>Користувач Інформація</title>
 
<link rel="stylesheet" type="text/css" href="style.css">
 
</head>
<body>
 
 
    <jsp:include page="_header.jsp" />
 
    <div class="page-title">Account Info</div>
 
<div class="section">
    <div class="container">  
 
        <ul>
            <li>User Name: ${pageContext.request.userPrincipal.name}</li>
            <li>Role:
                <ul>
                    <c:forEach items="${userDetails.authorities}" var="auth">
                        <li>${auth.authority }</li>
                    </c:forEach>
                </ul>
            </li>
        </ul>
    </div>
 </div>

 
    <jsp:include page="_footer.jsp" />
 
</body>
</html>