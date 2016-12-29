<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div id="content">
        <p class="error_color">${error}</p>
        <form class="form" action="spring_security_check" method="post">
            <span id="login_text_username"><label for="login_username"> Ім'я користувача:</label> </span><input id="login_username" type="text" name="username"> <br/>
            <span id="login_text_password"><label for="login_password">Пароль:</label></span> <input id="login_password" type="password" name="password"> <br/>
            <div id="login_remember">
                <input id="remember_me" name="remember-me" type="checkbox"/>
                <label for="remember_me" class="inline">Запам'ятати мене</label>
            </div>
            <input id="login_submit" type="submit" name="submit" value="Надіслати">
        </form>
    <br/>
    <br/>
    <br/>
    <br/>
    <br/>
    <jsp:include page="/WEB-INF/views/backButton.jsp" />
</div>

