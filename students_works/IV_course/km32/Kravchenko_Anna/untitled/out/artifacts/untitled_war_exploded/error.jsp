<%--
  Created by IntelliJ IDEA.
  User: Ann
  Date: 16.12.2016
  Time: 4:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Error</title>
</head>
<body>
<h1>ERROR</h1><br/>
${requestScope.problem}
${mess}
${message}
<br/>
<a href="/login">press to return</a><br/>

</body>
</html>
