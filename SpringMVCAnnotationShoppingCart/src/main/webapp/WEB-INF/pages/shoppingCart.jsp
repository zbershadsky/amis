<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<title>Кошик</title>
 
<link rel="stylesheet" type="text/css" href="style.css">
 
</head>
<body>
    <jsp:include page="_header.jsp" />
    
    
    <fmt:setLocale value="en_US" scope="session"/>
 
<div class="row">
          <div class="col-md-12">
            <h1 class="text-center">Кошик</h1>
          </div>
        </div>   
        <div class="section">
    <div class="container">
    <c:if test="${empty cartForm or empty cartForm.cartLines}">
        <a href="${pageContext.request.contextPath}/productList">Show
            Product List</a>
    </c:if>
 
    <c:if test="${not empty cartForm and not empty cartForm.cartLines   }">
        <form:form method="POST" modelAttribute="cartForm"
            action="${pageContext.request.contextPath}/shoppingCart">
 
            <c:forEach items="${cartForm.cartLines}" var="cartLineInfo"
                varStatus="varStatus">
                <div class="product-preview-container">
                    <ul>
                        <li><img class="product-image"
                            src="${pageContext.request.contextPath}/productImage?code=${cartLineInfo.productInfo.code}" />
                        </li>
                        <li>Code: ${cartLineInfo.productInfo.code} <form:hidden
                                path="cartLines[${varStatus.index}].productInfo.code" />
 
                        </li>
                        <li>Name: ${cartLineInfo.productInfo.name}</li>
                        <li>Price: <span class="price">
                        
                          <fmt:formatNumber value="${cartLineInfo.productInfo.price}" type="currency"/>
                          
                        </span></li>
                        <li>Quantity: <form:input
                                path="cartLines[${varStatus.index}].quantity" /></li>
                        <li>Subtotal:
                          <span class="subtotal">
                          
                             <fmt:formatNumber value="${cartLineInfo.amount}" type="currency"/>
                        
                          </span>
                        </li>
                        <li><a
                            href="${pageContext.request.contextPath}/shoppingCartRemoveProduct?code=${cartLineInfo.productInfo.code}">
                                Delete </a></li>
                    </ul>
                </div>
            </c:forEach>
            <div style="clear: both"></div>
            <input class="button-update-sc" type="submit" value="Update Quantity" />
            <a class="navi-item"
                href="${pageContext.request.contextPath}/shoppingCartCustomer">Enter
                Customer Info</a>
            <a class="navi-item"
                href="${pageContext.request.contextPath}/productList">Continue
                Buy</a>
        </form:form>
 
 
    </c:if>
 </div>
 </div>
 
    <jsp:include page="_footer.jsp" />
 
</body>
</html>