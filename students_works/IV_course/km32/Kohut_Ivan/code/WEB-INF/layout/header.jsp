<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<header>

    <a href="<s:url value="/" />">
        <img id="supermarket_image" src="<s:url value="/resources/images/supermarket_image_header.jpg"/>" />
    </a>

    <div id="header_text">
        <h3>Продукти дешево та сердито!</h3>
    </div>



    <div id="absolute_block_position">
        <sec:authorize access="isAuthenticated()">
            Привіт, <sec:authentication property="principal.username" /> ! <a href="<s:url value="/logout"/>" role="button">Вийти</a> <br/>
            <a href="<s:url value="/office"/>">Кабінет користувача</a>
            <div id="basket_block">
                <a href="<s:url value="/basket"/>">
                    <img id="basket_image" src="<s:url value="/resources/images/icon_107.png"/>" />
                </a>
            </div>
        </sec:authorize>

        <sec:authorize access="!isAuthenticated()">
            <div id="log_registr_links">
                <a href="<s:url value="/login" />" role="button">Увійти</a> |
                <a href="<s:url value="/register"/>">Реєстрація</a>
            </div>
        </sec:authorize>
    </div>

</header>