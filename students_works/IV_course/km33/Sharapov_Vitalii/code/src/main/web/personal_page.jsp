<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Personal Page</title>
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
    <c:choose>
        <c:when test="${!sessionScope.user_is_manager}">
            <form method="post" action="personal_page">
                Personal information<br>
                <label>
                    User name (login) :
                    <input type="text" name="user_name" value="${requestScope.user_name}" readonly>
                </label> <br>
                <label>
                    Email :
                    <input type="text" name="user_email" value="${requestScope.user_email}" readonly>
                </label> <br>
                <label>
                    User status :
                    <input type="text" name="user_status" value="${requestScope.user_status}" readonly>
                </label> <br><br>

                <label>
                    Groom name :
                    <input type="text" name="user_groom_name" value="${requestScope.user_groom_name}" pattern="[a-zA-Z].{6,40}" required>
                </label> <br>
                <label>
                    Groom surname :
                    <input type="text" name="user_groom_surname" value="${requestScope.user_groom_surname}" pattern="[a-zA-Z].{6,40}" required>
                </label> <br>
                <label>
                    Groom birthday :
                    <input type="date" name="user_groom_birthday" value="${requestScope.user_groom_birthday}" pattern="[a-zA-Z].{6,40}" required>
                </label> <br><br>

                <label>
                    Bride name :
                    <input type="text" name="user_bride_name" value="${requestScope.user_bride_name}" pattern="[a-zA-Z].{6,40}" required>
                </label> <br>
                <label>
                    Bride surname :
                    <input type="text" name="user_bride_surname" value="${requestScope.user_bride_surname}" pattern="[a-zA-Z].{6,40}" required>
                </label> <br>
                <label>
                    Bride birthday :
                    <input type="date" name="user_bride_birthday" value="${requestScope.user_bride_birthday}" pattern="[a-zA-Z].{6,40}" required>
                </label> <br><br>
                <label>
                    Enter password to apply changes :
                    <input type="password" name="user_password" required pattern="[a-zA-Z0-9].{6,40}">
                </label> <br>

                <input name="command" type="hidden" value="update">
                <input type="submit" value="update personal data">
            </form>
            <form method="post" action="change_password">
                Change password<br>
                <label>
                    Old password :
                    <input type="password" name="old_password" required pattern="[a-zA-Z0-9].{6,40}">
                </label><br>
                <label>
                    New password :
                    <input type="password" name="new_password" required pattern="[a-zA-Z0-9].{6,40}">
                </label><br>
                <label>
                    Repeat new password :
                    <input type="password" name="new_password_2" required pattern="[a-zA-Z0-9].{6,40}">
                </label><br>
                <input type="submit" value="change password">
            </form>
        </c:when>
        <c:when test="${sessionScope.user_is_manager}">
            <form method="post" action="promotion">
                <label>
                    Enter password to apply changes :
                    <input type="password" name="user_password" required pattern="[a-zA-Z0-9].{6,40}">
                </label><br>
                <input type="hidden" name="new_man" value="${sessionScope.user_login}">
                <input type="submit" value="become regular user">
            </form>
        </c:when>
    </c:choose>
</c:if>
</body>
</html>
