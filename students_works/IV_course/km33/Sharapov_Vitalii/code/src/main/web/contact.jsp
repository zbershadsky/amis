<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Contact</title>
    <style>
        textarea {
            width: 200px;;
            height: 200px;;
            resize: none;
        }
    </style>
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
    <form method="get" action="contact">
        <label>
            Message History : <br>
            <textarea name="msg_hist" maxlength="256" readonly>${requestScope.hist}</textarea><br>
        </label>
        <label>
            New message :<br>
            <textarea name="new_msg"></textarea><br>
        </label>
        <label>
            <select name="send_to" required>
                <c:forEach items="${requestScope.user_list}" var="item">
                    <option value="${item}">${item}</option>
                </c:forEach>
            </select>
        </label>
        <input type="submit" value="send">
    </form>
</c:if>
</body>
</html>