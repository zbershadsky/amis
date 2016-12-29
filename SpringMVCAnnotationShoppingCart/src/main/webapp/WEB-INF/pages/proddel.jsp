<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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
<title>Послуги</title>
 
<link rel="stylesheet" type="text/css" href="style.css">
 
</head>
<body>
 
    <jsp:include page="_header.jsp" />
 
 <div class="section">
      <div class="container">
        <div class="row" style="background-color:white;">
          <div class="col-md-12 text-center" >
            <h1 contenteditable="true" class="text-center text-success">Прибирання - не Ваша справа</h1>
          </div>
        </div>
      </div>
    </div>
    <div class="section">
    <div class="container">
    <c:if test="${not empty errorMessage }">
      <div class="error-message">
          ${errorMessage}
      </div>
    </c:if>
 
    <form:form modelAttribute="prodInfo" method="POST" enctype="multipart/form-data" action="${pageContext.request.contextPath}/proddel">
        <table style="text-align:left;">
            <tr>
                <td>Code *</td>
                <td style="color:red;">
                   <c:if test="${not empty prodInfo.code}">
                        <form:hidden path="code"/>
                        ${prodInfo.code}
                   </c:if>
                    <c:if test="${empty prodInfo.code}">
                        <form:input path="code" />
                   </c:if>
                  
                </td>
                <td><form:errors path="code" class="error-message"  />           
                </td>
            </tr>
 
            <tr>
                <td>Name *</td>
                <td><form:input path="name" />                
                </td>
                <td><form:errors path="name" class="error-message" /></td></tr>
 
            <tr>
                <td>Price *</td>
                <td><form:input path="price"  />         
                </td>
               
                <td><form:errors path="price" class="error-message" /></td>
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