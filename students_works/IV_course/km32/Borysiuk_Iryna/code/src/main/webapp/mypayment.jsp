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
    <h1>Greetins</h1>
    <!--h2>Please enter your information to find a suitable lawer:</h2-->
    <div class="col-lg-3 col-md-3 col-sm-3 col-sm-3">
        <img src="https://avatanplus.com/files/resources/mid/57646e1f2dc31155604e29d3.png" alt="" class="img-responsive center-block hidden-xs">
    </div>
    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-1"></div>
    <div class="col-lg-8 col-md-8 col-sm-8 col-xs-8">
        <form action="">
            <p class="roboto1"  >From card<span style="color:red">*</span>:
                <input type="text" id="check" step="any" style="margin-right:5px; " placeholder="5168 **** **** 6371" minlength="16" maxlength="16" required>
                <script>
                    document.getElementById('check').onkeypress = function (e) {
                        return !(/[Ђ-џа-ЯA-Za-z ]/.test(String.fromCharCode(e.charCode)));
                    }

                </script>
            </p>
            <p class="roboto1"  >Card<span style="color:red">*</span>:
                <input type="text" id="check1" step="any"style="margin-right=5px; " placeholder="6851 **** **** 7163" maxlength="16" required>
                <script>
                    document.getElementById('check1').onkeypress = function (e) {
                        return !(/[Ђ-џа-ЯA-Za-z ]/.test(String.fromCharCode(e.charCode)));
                    }
                </script></p>
            <p class="roboto1"  >Money<span style="color:red">*</span>:
                <input type="text" id="check2" step="any" style="margin-right=5px; " placeholder="12" maxlength="16" required>
                <script>
                    document.getElementById('check2').onkeypress = function (e) {
                        return !(/[Ђ-џа-ЯA-Za-z ]/.test(String.fromCharCode(e.charCode)));
                    }
                </script></p>
            <button type="submit" class="btn btn-success">Transaction</button>
</body>
</html>
