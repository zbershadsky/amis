<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
<title>Інформація</title>
 
<link rel="stylesheet" type="text/css" href="style.css">
 
</head>
<body>
<jsp:include page="_header.jsp" />
 
<div class="row">
          <div class="col-md-12">
            <h1 class="text-center">Введіть свої дані, будь ласка</h1>
          </div>
        </div>  
        <div class="section">
    <div class="container">
    <form:form method="POST" modelAttribute="customerForm"
        action="${pageContext.request.contextPath}/shoppingCartCustomer">
 
        <table>
            <tr>
                <td>Name *</td>
                <td><form:input path="name" /></td>
                <td><form:errors path="name" class="error-message" /></td>
            </tr>
 
            <tr>
                <td>Email *</td>
                <td><form:input path="email" /></td>
                <td><form:errors path="email" class="error-message" /></td>
            </tr>
 
            <tr>
                <td>Phone *</td>
                <td><form:input path="phone" /></td>
                <td><form:errors path="phone" class="error-message" /></td>
            </tr>
 
            <tr>
                <td>Address *</td>
                <td><form:input path="address" /></td>
                <td><form:errors path="address" class="error-message" /></td>
            </tr>
 
            <tr>
                <td>&nbsp;</td>
                <td><input type="submit" value="Submit" /> <input type="reset"
                    value="Reset" /></td>
            </tr>
        </table>
 
    </form:form>
 
 </div>
 </div>
    <jsp:include page="_footer.jsp" />
 
 
</body>
</html>