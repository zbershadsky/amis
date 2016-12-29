<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div id="content">
    <p class="error_color">${error}</p>
    <form class="form" action="<s:url value="/update/phone"/>" method="post">
        <span id="text_old_phone"><label for="old_phone"> Старий номер телефону:</label> </span><input id="old_phone" type="text" name="old_phone" placeholder="Напр. +380979835405" value="${oldPhone}"> <br/>
        <span id="text_new_phone"><label for="new_phone"> Новий номер телефону:</label></span> <input id="new_phone" type="text" name="new_phone" placeholder="Напр. +380979835405" value="${newPhone}"> <br/>
        <input id="update_phone_submit" type="submit" name="submit" value="Оновити">
    </form>
    <br/>
    <br/>
    <br/>
    <br/>
    <br/>
    <jsp:include page="/WEB-INF/views/backButton.jsp" />
</div>