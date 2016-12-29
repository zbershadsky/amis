<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>

<div id="content">

    <p id="invitation">Виберіть секцію товарів:</p>

    <c:forEach items="${sections}" var="section">

        <div class="blocks">
            <img src="${section.image}" width="150" height="150">
            <p><a class="link_decoration" href="<s:url value="/supermarket/section?supermarket_name=${supermarket_name}&section_name=${section.name}" />">${section.name}</a></p>
        </div>

    </c:forEach>
    <br/>
    <jsp:include page="/WEB-INF/views/backButton.jsp" />

</div>