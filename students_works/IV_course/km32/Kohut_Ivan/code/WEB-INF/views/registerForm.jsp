<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div id="content">
    <p class="error_color">${error}</p>
    <form id="form_registration" method="post">
        <label for="reg_username"><span id="reg_text_username">Ім'я користувача:</span></label><input id="reg_username" type="text" name="username" value="${user.username}" placeholder="від 5 до 16 символів" > <br/>
        <label for="reg_password"><span id="reg_text_password">Пароль:</span></label><input id="reg_password" type="password" name="password" placeholder="від 6 до 16 символів" > <br/>
        <label for="reg_conf_password"><span id="reg_text_conf_password">Підтвердження пароля:</span></label><input id="reg_conf_password" type="password" name="confirmatoryPassword"> <br/>
        <label for="reg_email"><span id="reg_text_email">Електронна пошта:</span></label><input id="reg_email" type="text" name="email" value="${user.email}" placeholder="Напр. kogut@gmail.com" > <br/>
        <label for="reg_phone_number"><span id="reg_text_phone_number">Номер телефону:</span></label><input id="reg_phone_number" type="text" name="phoneNumber" value="${user.phoneNumber}" placeholder="Напр. +380979835405"> <br/>
        <input id="reg_button" type="submit" name="submit" value="Надіслати">
    </form>
    <br/>
    <br/>
    <br/>
    <br/>
    <br/>
    <jsp:include page="/WEB-INF/views/backButton.jsp" />
</div>