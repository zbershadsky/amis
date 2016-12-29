<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
 <%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
 
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
<title>Послугиt</title>
 
<link rel="stylesheet" type="text/css" href="style.css">
 
</head>
<body>
 
    <jsp:include page="_header.jsp" />
    
    <fmt:setLocale value="en_US" scope="session"/>
 
 <div class="row">
          <div class="col-md-12">
            <h1 class="text-center">Які послуги ми надаємо?</h1>
          </div>
        </div>       <div class="section">
       	 <div class = "container">
 
        	  <div class = "row">
 
    <c:forEach items="${paginationProducts.list}" var="prodInfo">
   
                   <div class="col-md-4">
       
        	    <ul>    
                <li><img class="product-image"
                    src="${pageContext.request.contextPath}/productImage?code=${prodInfo.code}" /></li>
                <li>Code: ${prodInfo.code}</li>
                <li>Name: ${prodInfo.name}</li>
                <li>Price: <fmt:formatNumber value="${prodInfo.price}" type="currency"/></li>
                <li><a
                    href="${pageContext.request.contextPath}/buyProduct?code=${prodInfo.code}">
                        Buy Now</a></li>
                <!-- For Manager edit Product -->
                <security:authorize  access="hasRole('ROLE_MANAGER')">
                  <li><a style="color:red;"
                      href="${pageContext.request.contextPath}/product?code=${prodInfo.code}">
                        Edit Product</a></li>
                </security:authorize>
                <security:authorize  access="hasRole('ROLE_MANAGER')">
                  <li><a style="color:red;"
                      href="${pageContext.request.contextPath}/proddel?code=${prodInfo.code}">
                        Delete Product</a></li>
                </security:authorize>
            </ul>
            </div>
            
            
 
    </c:forEach>
    <br/>
    </div>
    </div>
        </div>
  
    <c:if test="${paginationProducts.totalPages > 1}">
        <div class="page-navigator">
           <c:forEach items="${paginationProducts.navigationPages}" var = "page">
               <c:if test="${page != -1 }">
                 <a href="productList?page=${page}" class="nav-item">${page}</a>
               </c:if>
               <c:if test="${page == -1 }">
                 <span class="nav-item"> ... </span>
               </c:if>
           </c:forEach>
            
        </div>
    </c:if>
 
    <jsp:include page="_footer.jsp" />
 
</body>
</html>