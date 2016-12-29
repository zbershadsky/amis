<%@ page import="entity.Product" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>

<div id="content">

    <%
        String classAdd = "";
        String text = "Вибрані Вами продукти:";
        if (((List<Product>) (pageContext.findAttribute("products"))).size() == 0) {
            classAdd += "display_none";
            text="У Вас немає вибраних продуктів.";
        }
    %>

    <p class="invitation"><%=text%></p>

    <c:forEach items="${products}" var="product">
        <div class="blocks">
            <img src="${product.image}" width="150" height="150">
            <p>${product.name}</p>
            <p>Ціна: ${product.price} грн.</p>
            <p class="selected_quantity">Кількість: ${product.quantity}</p>
            <div class="display_none">Кількість: <input id="input${product.hash}" type="text" style="width: 72px;" value="1"></div>
            <p class="basket_operation back_color_red" onclick="doAjax(this, '${product.supermarketName}|${product.name}', 'input${product.hash}')">Видалити з кошика</p>
            <div class="error_block"></div>
        </div>
    </c:forEach>

    <br/>
    <div id="delivery_link">
        <a class="<%=classAdd%>" href="<s:url value="/delivery" />">
            <img id="supermarket_image" src="<s:url value="/resources/images/delivery_button.png"/>" />
        </a>
    </div>
    <jsp:include page="/WEB-INF/views/backButton.jsp" />
</div>
