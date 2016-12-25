<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>   
 
<div class="navbar navbar-default navbar-static-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-ex-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
             <a class="navbar-brand"  href="${pageContext.request.contextPath}/">CleaningLife</a>
          </div>
          <div class="collapse navbar-collapse" id="navbar-ex-collapse">
          <ul class="nav navbar-nav navbar-right">
          <security:authorize  access="hasAnyRole('ROLE_MANAGER','ROLE_EMPLOYEE')">
      <li class = "active">
        <a href="${pageContext.request.contextPath}/orderList">
         Список замовлень
     </a>
     </li>
   </security:authorize>
   
   <security:authorize  access="hasRole('ROLE_MANAGER')">
      <li class = "active">
   
         <a href="${pageContext.request.contextPath}/product">
                        Створити продукт
         </a>
      </li>
   </security:authorize>
  	
        <c:if test="${pageContext.request.userPrincipal.name != null}">
                  <li class="active">
                  <a href="${pageContext.request.contextPath}/accountInfo">
                ${pageContext.request.userPrincipal.name} </a>
                </li>
                <li class="active">
                  <a href="${pageContext.request.contextPath}/logout">Вийти</a>
 				</li>
        </c:if>
        <li class="active">
        <c:if test="${pageContext.request.userPrincipal.name == null}">
            <a href="${pageContext.request.contextPath}/login">Авторизація</a>
        </c:if>
        </li>
        <li class = "active">
         <c:if test="${pageContext.request.userPrincipal.name == null}">
            <a href="${pageContext.request.contextPath}/registration">Реєстрація</a>
        </c:if>
        </li>
                <li class = "active">
        
		<a href="${pageContext.request.contextPath}/productList">
      Список послуг
   </a>
   </li>
   
   <li class = "active">
   <a href="${pageContext.request.contextPath}/shoppingCart">
      Кошик
   </a>
   </li>
   
   
        </ul>
    </div>
</div>
</div>
