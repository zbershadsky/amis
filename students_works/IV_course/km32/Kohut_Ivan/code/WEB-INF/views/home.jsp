<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div id="content">

    <p id="invitation">Завітайте у нижче зазначені супермаркети (гіпермаркети):</p>

        <c:forEach items="${supermarkets}" var="supermarket">
            <div class="blocks">
                <img src="${supermarket.image}" width="150" height="150">
                <p><a class="link_decoration" href="<s:url value="/supermarket?supermarket_name=${supermarket.name}" />">${supermarket.name}</a></p>
            </div>
        </c:forEach>

</div>