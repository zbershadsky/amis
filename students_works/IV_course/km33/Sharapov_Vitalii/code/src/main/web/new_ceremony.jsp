<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>New ceremony</title>
</head>
<body>
<c:if test="${!empty sessionScope.user_login}">
    <header>
        <form method="post" action="login">
            Hello, ${sessionScope.user_login}!
            <input type="hidden" name="command" value="logout">
            <input type="submit" value="Logout"/>
        </form>
        <br/>
        <form method="post" action="ceremony_switch">
            <input type="submit" value="manage ceremony">
        </form>
        <form method="post" action="contact">
            <input type="submit" value="contact manager">
        </form>
        <a href="<c:url value="/about.jsp"/>">About</a>
        <form method="post" action="personal_page">
            <input name="command" type="hidden" value="load">
            <input type="submit" value="personal page">
        </form>
    </header>
    <form method="post" action="new_ceremony">
        <label>
            Ceremony date
            <input type="date" name="cer_date" required> <br>
        </label>
        <label>
            Restaurant
            <select name="rest_number" required>
                <c:forEach items="${requestScope.restMap}" var="entry">
                    <option value="${entry.key}">${entry.value}</option>
                </c:forEach>
            </select><br>
        </label>
        <label>
            Artist
            <select name="art_number" required>
                <c:forEach items="${requestScope.artMap}" var="entry">
                    <option value="${entry.key}">${entry.value}</option>
                </c:forEach>
            </select><br>
        </label>
        <input type="submit" value="create new ceremony">
    </form>
</c:if>
</body>
</html>
