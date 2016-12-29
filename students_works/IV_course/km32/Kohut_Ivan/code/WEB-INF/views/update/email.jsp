<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div id="content">
    <p class="error_color">${error}</p>
    <form class="form" action="<s:url value="/update/email"/>" method="post">
        <span id="text_old_email"><label for="old_email"> Старий адрес електронної пошти:</label> </span><input id="old_email" type="text" name="old_email" placeholder="Напр. kogut@gmail.com" value="${oldEmail}"> <br/>
        <span id="text_new_email"><label for="new_email"> Новий адрес електронної пошти:</label></span> <input id="new_email" type="text" name="new_email" placeholder="Напр. kogut@gmail.com" value="${newEmail}"> <br/>
        <input id="update_email_submit" type="submit" name="submit" value="Оновити">
    </form>
    <br/>
    <br/>
    <br/>
    <br/>
    <br/>
    <jsp:include page="/WEB-INF/views/backButton.jsp" />
</div>