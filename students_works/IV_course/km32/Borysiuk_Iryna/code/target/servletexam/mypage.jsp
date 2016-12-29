<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession session1 = request.getSession(true);
    session1.setMaxInactiveInterval(1800);

    Boolean logined = (Boolean) session1.getAttribute("logined");
    String email = (String) session1.getAttribute("email");
    String role = (String) session1.getAttribute("role");

%>
<html>
<head>
    <title>Devcolibri.com</title>
</head>
<body>
    <h1>Hello, <%=email%> </h1>

    <form action="/blank" method="post" enctype="text/plain">
        <input name="column1" type="text" class="btn btn-success" value="Payment" required>
        <input name="column2" type="text" class="btn btn-success" value="Payment" required>
        <br>
        <input name="column3" type="date" class="btn btn-success" value="Payment" required>
        <input name="column4" type="date" class="btn btn-success" value="Payment" required>
        <br>
        <input name="column5" type="text" class="btn btn-success" value="Payment" required>
        <input name="column6" type="text" class="btn btn-success" value="Payment" required>
        <br>
        <input name="column7" type="text" class="btn btn-success" value="Payment" required>
        <input name="column8" type="text" class="btn btn-success" value="Payment" required>
        <br>
        <input name="column9" type="text" class="btn btn-success" value="Payment" required>
        <input name="column10" type="text" class="btn btn-success" value="Payment" required>
        <br>
        <input name="column11" type="text" class="btn btn-success" value="Payment" required>
        <input name="column12" type="text" class="btn btn-success" value="Payment" required>
        <br>
        <input name="column13" type="text" class="btn btn-success" value="Payment" required>
        <input name="column14" type="text" class="btn btn-success" value="Payment" required>
        <br>
        <input name="column15" type="date" class="btn btn-success" value="Payment" required>
        <input name="column16" type="date" class="btn btn-success" value="Payment" required>
        <br>
        <input name="column17" type="text" class="btn btn-success" value="Payment" required>
        <input type="submit" class="btn btn-success" value="Payment">
        <%    String column1= (String) session1.getAttribute("column1");%>

            <%=column1%>
    </form>

</body>
</html>
