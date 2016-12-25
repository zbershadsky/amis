<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div id="content">
    <p class="error_color">${error}</p>
    <form class="form" action="<s:url value="/update/password"/>" method="post">
        <span id="text_old_password"><label for="old_password"> Старий пароль:</label> </span><input id="old_password" type="password" name="old_password" placeholder="від 6 до 16 символів"> <br/>
        <span id="text_new_password"><label for="new_password"> Новий пароль:</label></span> <input id="new_password" type="password" name="new_password" placeholder="від 6 до 16 символів"> <br/>
        <span id="text_check_password"><label for="check_password"> Повторіть новий пароль:</label></span> <input id="check_password" type="password" name="check_password" placeholder="від 6 до 16 символів"> <br/>
        <input id="update_password_submit" type="submit" name="submit" value="Оновити">
    </form>
    <br/>
    <br/>
    <br/>
    <br/>
    <br/>
    <jsp:include page="/WEB-INF/views/backButton.jsp" />
</div>
