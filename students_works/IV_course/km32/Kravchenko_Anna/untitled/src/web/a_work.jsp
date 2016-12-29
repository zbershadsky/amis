<%--
  Created by IntelliJ IDEA.
  User: Ann
  Date: 25.12.2016
  Time: 14:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<style>


</style>
<body>
<table>
    <caption>Users</caption>
    <thead>
    <tr>
        <th>User_Name <br/><br/>
            <c:forEach items="${result1}" var="variable">
            "${variable}" <br/>
        </c:forEach></th>
        <th>User_Status <br/><br/>
            <c:forEach items="${result2}" var="variable">
            "${variable}" <br/>
        </c:forEach></th>
        <th>User_Pass <br/><br/>
            <c:forEach items="${result3}" var="variable">
                "${variable}" <br/>
            </c:forEach></th>
        <th>User_Mail <br/><br/>
            <c:forEach items="${result4}" var="variable">
                "${variable}" <br/>
            </c:forEach></th>
    </tr>
    </thead>
</table> <br/>
<form class="form-container" action="/a_work_status" method="POST">
    User_Name:
<input class="form-field" type="text" name="userName" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Za-z]).{3,20}"
       title="I need more then 3, but less then 20 letters & number" required><br/>
    User_Status:
<input class="form-field" type="text" name="status" pattern="(?=.*[u,b,a]).{1}"
       title="Status contain 'u' - user, 'b' - ban, 'a' - admin" required><br/>
<input class="submit-button" type="submit" value="Submit"/>
</form>
<input class="submit-button" type="button" value="On adminpage"
       onClick='location.href="http://localhost:8080/a_work_status"'>
</body>
</html>
