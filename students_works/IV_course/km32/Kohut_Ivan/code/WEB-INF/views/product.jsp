<%@ page import="entity.ProductTablePrimaryKey" %>
<%@ page import="java.util.List" %>
<%@ page import="entity.Product" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<div id="content">

    <p id="invitation">Дивимося товари та додаємо у кошик для покупки:</p>

    <%
        @SuppressWarnings("unchecked")
        List<ProductTablePrimaryKey> selectedProducts = (List<ProductTablePrimaryKey>) request.getAttribute("selectedProducts");
    %>

    <c:forEach items="${products}" var="product">

        <%
            String classAdd = "";
            String text = "Додати у кошик";
            String displayNoneProperty = "";
            for (ProductTablePrimaryKey tablePrimaryKey : selectedProducts) {
                if (((Product) (pageContext.findAttribute("product"))).getName().equals(tablePrimaryKey.getProductName()) &&
                        ((Product) (pageContext.findAttribute("product"))).getSupermarketName().equals(tablePrimaryKey.getSupermarketName())) {
                    classAdd += "back_color_red";
                    text = "Видалити з кошика";
                    displayNoneProperty += "display_none";
                    break;
                }
            }
        %>

        <div class="blocks">
            <img src="${product.image}" width="150" height="150">
            <p>${product.name}</p>
            <p>Ціна: ${product.price} грн.</p>
            <p class="description"><a class="link_decoration" href="<s:url value="/supermarket/section/product?supermarket_name=${supermarket_name}&section_name=${section}&product_name=${product.name}" />">Опис</a></p>
            <sec:authorize access="isAuthenticated()">
                <div class="<%=displayNoneProperty%>">Кількість: <input id="input${product.hash}" type="text" style="width: 72px;" value="1"></div>
                <p class="basket_operation <%=classAdd%>" onclick="doAjax(this, '${supermarket_name}|${product.name}', 'input${product.hash}')"><%=text%></p>
                <div class="error_block error_color"></div>
            </sec:authorize>
        </div>
    </c:forEach>
    <br/>
    <jsp:include page="/WEB-INF/views/backButton.jsp" />

</div>
