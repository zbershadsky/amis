<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>

<div id="content">
    <div class="align blocks">
        <img src="${product.image}" width="150" height="150">
        <p>${product.name}</p>
        <p>Ціна: ${product.price} грн.</p>
        <p>${product.description}</p>
    </div>
    <br/>
    <jsp:include page="/WEB-INF/views/backButton.jsp" />
</div>
