<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Complete password restoration</title>
</head>
<body>
Your password is:
${requestScope.password}
<p><a href="<c:url value="/login.jsp"/>">Login page</a>
</body>
</html>