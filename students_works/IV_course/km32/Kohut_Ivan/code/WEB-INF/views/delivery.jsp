<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>

<div id="content">

    <%
        String text = "";
        String addClass = "";
        if (((Double) (pageContext.findAttribute("price"))) == 0.0) {
            text += "У Вас немає вибраних продуктів.";
            addClass += "display_none";
        }
    %>

    <p class="invitation"><%=text%></p>
    <div class="<%=addClass%>">
        <p class="invitation">Сума оплати складає ${price} грн. <br/><br/>
            Для того, щоб з Вами зв'язалися, підтвердіть своє замовлення. <br/> <br/>
            <a href="<s:url value="/gratitude" />">
                <img id="supermarket_image" src="<s:url value="/resources/images/submit.jpg"/>" />
            </a>
        </p>
    </div>
    <br/>
    <jsp:include page="/WEB-INF/views/backButton.jsp" />
</div>
