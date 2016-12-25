<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<title>Завершення</title>
 
<link rel="stylesheet" type="text/css" href="style.css">
 
</head>
<body>
   <jsp:include page="_header.jsp" />
  
  
   <fmt:setLocale value="en_US" scope="session"/>
<div class="row">
          <div class="col-md-12">
            <h1 class="text-center">Завершіть замволення, будь ласка</h1>
          </div>
        </div>   
  
  
<div class="section">
    <div class="container">
           <h3>Інформаця про замовника:</h3>
       <ul>
           <li>Name: ${myCart.customerInfo.name}</li>
           <li>Email: ${myCart.customerInfo.email}</li>
           <li>Phone: ${myCart.customerInfo.phone}</li>
           <li>Address: ${myCart.customerInfo.address}</li>
       </ul>
       <h3>Cart Summary:</h3>
       <ul>
           <li>Quantity: ${myCart.quantityTotal}</li>
           <li>Total:
           <span class="total">
             <fmt:formatNumber value="${myCart.amountTotal}" type="currency"/>
           </span></li>
       </ul>
   </div>
 
   <form method="POST"
       action="${pageContext.request.contextPath}/shoppingCartConfirmation">
 
       <!-- Edit Cart -->
       <a class="navi-item"
           href="${pageContext.request.contextPath}/shoppingCart">Edit Cart</a>
 
       <!-- Edit Customer Info -->
       <a class="navi-item"
           href="${pageContext.request.contextPath}/shoppingCartCustomer">Edit
           Customer Info</a>
 
       <!-- Send/Save -->
       <input type="submit" value="Send" class="button-send-sc" />
   </form>
 
   <div class="container">
 
       <c:forEach items="${myCart.cartLines}" var="cartLineInfo">
           <div class="product-preview-container">
               <ul>
                   <li><img class="product-image"
                       src="${pageContext.request.contextPath}/productImage?code=${cartLineInfo.productInfo.code}" /></li>
                   <li>Code: ${cartLineInfo.productInfo.code} <input
                       type="hidden" name="code" value="${cartLineInfo.productInfo.code}" />
                   </li>
                   <li>Name: ${cartLineInfo.productInfo.name}</li>
                   <li>Price: <span class="price">
                      <fmt:formatNumber value="${cartLineInfo.productInfo.price}" type="currency"/>
                   </span>
                   </li>
                   <li>Quantity: ${cartLineInfo.quantity}</li>
                   <li>Subtotal:
                     <span class="subtotal">
                        <fmt:formatNumber value="${cartLineInfo.amount}" type="currency"/>
                     </span>
                   </li>
               </ul>
           </div>
       </c:forEach>
 
   </div>
 </div>

   <jsp:include page="_footer.jsp" />
 
</body>
</html>