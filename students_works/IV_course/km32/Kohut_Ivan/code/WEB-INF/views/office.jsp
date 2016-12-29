<%@ page import="entity.Product" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div id="content">

    <div id="update_block">
        Змінити:
        <a id="red_link" href="<s:url value="/update/password"/>">Пароль</a> |
        <a id="yellow_link" href="<s:url value="/update/phone"/>">Моб. телефон</a> |
        <a id="green_link" href="<s:url value="/update/email"/>">Електр. пошту</a>
    </div>

    <p>Ім'я користувача: ${user.username}</p>
    <p>Електронна пошта: ${user.email}</p>
    <p>Мобільний телефон: ${user.phoneNumber}</p>

    <%
        @SuppressWarnings("unchecked")
        Map<String, List<Product>> map = (Map<String, List<Product>>) pageContext.findAttribute("orders");
        String text = "Ваші зроблені замовлення: <br/>";
        if (map.isEmpty()) {
            text = "У Вас немає замовлень.";
        }
    %>

    <p class="invitation"><%=text%></p>

    <ol>
        <c:forEach items="${orders}" var="entry">
            <%
                double sum = 0;
            %>
            <li>Дата замовлення: ${entry.key}</li>
            <ul>
                <c:forEach items="${entry.value}" var="product">
                    <%
                        Product product = (Product) pageContext.findAttribute("product");
                        sum += product.getQuantity() * product.getPrice();
                    %>
                    <li>Супермаркет: ${product.supermarketName}, продукт: ${product.name}, кількість: ${product.quantity}, ціна: ${product.price}.</li>
                </c:forEach>
            </ul>
            <p>Сума: <%=Double.parseDouble(String.format(Locale.ENGLISH, "%.2f", sum))%></p>
        </c:forEach>
    </ol>
    <br/>
    <jsp:include page="/WEB-INF/views/backButton.jsp" />
</div>