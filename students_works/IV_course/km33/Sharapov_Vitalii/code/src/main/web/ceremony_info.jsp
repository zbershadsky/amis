<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Ceremony</title>
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
            <form method="post" action="update_ceremony">
                <label>
                    Ceremony date :
                    <input type="date" name="cer_date" value="${requestScope.cer_date}" required>
                    <input type="hidden" name="command" value="edit date">
                    <input type="submit" value="edit date">
                    <br>
                </label>
            </form>
            Groom :         ${requestScope.cer_groom}<br>
            Bride :         ${requestScope.cer_bride}<br>
            <form method="post" action="update_ceremony">
                <label>
                    Restaurant : ${requestScope.cer_rest}<br>
                    Other restaurant options :
                    <select name="rest_number" required>
                        <c:forEach items="${requestScope.restMap}" var="entry">
                            <option value="${entry.key}">${entry.value}</option>
                        </c:forEach>
                    </select>
                    <input type="hidden" name="command" value="edit rest">
                    <input type="submit" value="edit restaurant">
                    <br>
                </label>
            </form>
            <form method="post" action="update_ceremony">
                <label>
                    Artists : <br>
                    <c:forEach items="${requestScope.cer_art}" var="item">
                        ${item}<br>
                    </c:forEach>
                    Other artists :
                    <select name="art_number" required>
                        <c:forEach items="${requestScope.artMap}" var="entry">
                            <option value="${entry.key}">${entry.value}</option>
                        </c:forEach>
                    </select>
                    <input type="hidden" name="command" value="add artist">
                    <input type="submit" value="add artist">
                </label>
            </form>
            <form method="post" action="bill">
                <input type="submit" value="checkout bill">
            </form>
        </c:when>
        <c:when test="${sessionScope.user_is_manager}">
            <form method="post" action="promotion">
                <label>
                    Users that don't have manager privileges :
                    <select name="new_man" required>
                        <c:forEach items="${requestScope.user_list}" var="item">
                            <option value="${item}">${item}</option>
                        </c:forEach>
                    </select>
                    <input type="submit" value="promote to manager">
                </label>
            </form>
            <form method="post" action="assign">
                <label>
                    Unassigned users :
                    <select name="assign_to" required>
                        <c:forEach items="${requestScope.unassigned_user}" var="item">
                            <option value="${item}">${item}</option>
                        </c:forEach>
                    </select>
                    <input type="submit" value="assign user">
                </label>
            </form>
            <br>Restaurant assignments confirmation/rejection : <br>
            <c:forEach items="${requestScope.rest_tokens}" var="item">
                <form method="post" action="confirm">
                    User : ${item[0]}, Restaurant: ${item[1]},
                    Current status : ${item[3]}, New status :
                    <label>
                        <select name="rest_status" required>
                            <option value="0">0</option>
                            <option value="1">1</option>
                        </select>
                    </label>
                    <input type="hidden" name="command" value="restaurant">
                    <input type="hidden" name="user_name" value="${item[0]}">
                    <input type="hidden" name="rest_number" value="${item[2]}">
                    <input type="submit" value="apply status"><br>
                </form>
            </c:forEach>
            <br>Artists assignments confirmation/rejection : <br>
            <c:forEach items="${requestScope.art_tokens}" var="item">
                <form method="post" action="confirm">
                    User : ${item[0]}, Artist: ${item[1]},
                    Current status : ${item[3]}, New status :
                    <label>
                        <select name="art_status" required>
                            <option value="0">0</option>
                            <option value="1">1</option>
                        </select>
                    </label>
                    <input type="hidden" name="command" value="artist">
                    <input type="hidden" name="user_name" value="${item[0]}">
                    <input type="hidden" name="art_number" value="${item[2]}">
                    <input type="submit" value="apply status">
                </form>
            </c:forEach>

            <form method="post" action="create">
                <label>
                    New restaurant : <br>
                    <label>
                        Name : <input type="text" name="new_name" required pattern="[a-zA-Z].{6,40}" >
                    </label>
                    <label>
                        Address : <input type="text" name="new_other" required pattern="[a-zA-Z].{6,256}">
                    </label>
                    <label>
                        Email : <input type="email" name="new_email" required pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$">
                    </label>
                    <label>
                        Price per day : <input type="number" name="new_price" min="1" max="1000000000" step="0.01" required>
                    </label>
                    <input type="hidden" name="command" value="restaurant">
                    <input type="submit" value="add restaurant">
                </label>
            </form>
            <form method="post" action="create">
                <label>
                    New artist : <br>
                    <label>
                        Name : <input type="text" name="new_name" required pattern="[a-zA-Z].{6,40}" >
                    </label>
                    <label>
                        Genre : <input type="text" name="new_other" required pattern="[a-zA-Z].{6,40}" >
                    </label>
                    <label>
                        Email : <input type="email" name="new_email" required pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$">
                    </label>
                    <label>
                        Price per day : <input type="number" name="new_price" min="1" max="1000000000" step="0.01" required>
                    </label>
                    <input type="hidden" name="command" value="artist">
                    <input type="submit" value="add artist">
                </label>
            </form>
        </c:when>
    </c:choose>
</c:if>
</body>
</html>
