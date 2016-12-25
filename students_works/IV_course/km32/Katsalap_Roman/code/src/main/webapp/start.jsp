<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Fill ME!</title>

</head>
<body>
    <div id="page_top">

        <c:if test="${logged eq 'false'}">
            <jsp:include page="login.jsp"></jsp:include>
        </c:if>
    </div>
    <div id="content">

        <c:if test="${logged eq 'false'}">
            <jsp:include page="registration.jsp"></jsp:include>
        </c:if>
        <!--include register form-->



    </div>
</body>
</html>
