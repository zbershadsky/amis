<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css"
    rel="stylesheet" type="text/css">
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.js"></script>
<title>Успіх!</title>
 
<link rel="stylesheet" type="text/css" href="style.css">
 
</head>
<body>
    <jsp:include page="_header.jsp" />
 
    <jsp:include page="_menu.jsp" />
 

 <div class="row">
          <div class="col-md-12">
            <h1 class="text-center">Які послуги ми надаємо?</h1>
          </div>
        </div>      
    <div class="container">
    
        <h3>Дякуємо за Ваше замовленя!</h3>
        <h4> Наші менеджери звяжуться з Вами в якнайскоріше</h4>
        <!-- Your order number is: ${lastOrderedCart.orderNum} -->
    </div>
 
    <jsp:include page="_footer.jsp" />
 
</body>
</html>