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
<title>Замовлення</title>
 
<link rel="stylesheet" type="text/css" href="style.css">
 
</head>
<body>
 
    <jsp:include page="_header.jsp" />
 
    <fmt:setLocale value="en_US" scope="session"/>
    
<div class="row">
          <div class="col-md-12">
            <h1 class="text-center">Замовлення</h1>
          </div>
        </div>
        <div class="section">
    <div class="container">  
    <div>Total Order Count: ${paginationResult.totalRecords}</div>
    
    <table border="1" style="width:100%">
        <tr>
            <th>Order Num</th>
            <th>Order Date</th>
            <th>Customer Name</th>
            <th>Customer Address</th>
            <th>Customer Email</th>
            <th>Amount</th>
            <th>View</th>
        </tr>
        <c:forEach items="${paginationResult.list}" var="orderInfo">
            <tr>
                <td>${orderInfo.orderNum}</td>
                <td>
                   <fmt:formatDate value="${orderInfo.orderDate}" pattern="dd-MM-yyyy HH:mm"/>
                </td>
                <td>${orderInfo.customerName}</td>
                <td>${orderInfo.customerAddress}</td>
                <td>${orderInfo.customerEmail}</td>
                <td style="color:red;">
                   <fmt:formatNumber value="${orderInfo.amount}" type="currency"/>
                </td>
                <td><a href="${pageContext.request.contextPath}/order?orderId=${orderInfo.id}">
                   View</a></td>
            </tr>
        </c:forEach>
    </table>
    <c:if test="${paginationResult.totalPages > 1}">
        <div class="page-navigator">
           <c:forEach items="${paginationResult.navigationPages}" var = "page">
               <c:if test="${page != -1 }">
                 <a href="orderList?page=${page}" class="nav-item">${page}</a>
               </c:if>
               <c:if test="${page == -1 }">
                 <span class="nav-item"> ... </span>
               </c:if>
           </c:forEach>
            
        </div>
    </c:if>
 
 </div>
 </div>
 
 
    <jsp:include page="_footer.jsp" />
 
</body>
</html>