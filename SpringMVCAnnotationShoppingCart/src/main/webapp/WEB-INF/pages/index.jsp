<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<!DOCTYPE html>

<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css"
    rel="stylesheet" type="text/css">
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.js"></script>
   <title>CleaningLife</title>
   <link rel="stylesheet" type="text/css" href="style.css">
   
 </head>
  <body>
 
 
    <jsp:include page="_header.jsp" />
 
    <div class="section">
      <div class="container">
        <div class="row" style="background-color:white;">
          <div class="col-md-12 text-center" >
            <h1 contenteditable="true" class="text-center text-success">Прибирання - не Ваша справа</h1>
          </div>
        </div>
      </div>
    </div>
	
    <div class="section">
      <div class="container">
        <div class="row">
          <div class="col-md-12 text-center" >
			<form>
		
   <div class="btntop">
  <a href="${pageContext.request.contextPath}/productList">   <input type="submit" class="btn btn-success" value="Список послуг" >
  </a>
</div>
  </form>
            </div>
          </div>
      </div>
    </div>
    <div class="section">
      <div class="container">
               <div class="row">
          <div class="col-md-12">
            <h1 class="text-center text-success">Як це працює?</h1>
          </div>
        </div>
      </div>
    </div>
    <div class="section">
      <div class="container">
        <div class="row">
          <div class="col-md-6">
            <h1>
              <span class="label label-success">1. Зробіть замовлення</span>
            </h1>
            <p class="lead">Виберіть кількість кімнат і санвузлів, залиш свій номер телефону, підтверди
              кодом з смс і переходь далі оформляти замовлення. У віконці праворуч побачиш
              приблизний час прибирання і суму до оплати.</p>
          </div>
          <div class="col-md-6">
            <img src="C:/Users/Ольга/workspase1/SpringMVCAnnotationShoppingCart/src/main/resources/cleaning1.png" width="200" height="200" >
          </div>
        </div>
      </div>
    </div>
    <div class="section">
      <div class="container">
        <div class="row">
          <div class="col-md-6">
            <img src="\resources\cleaning2.png" class="img-responsive img-thumbnail">
          </div>
          <div class="col-md-6">
            <h1 class="text-success">
              <span class="label label-success">2. Спеціалісти у Вашому районі</span>
            </h1>
            <p class="lead">Клінери прибирають квартири в зручному для нього районі, що дозволяє економити
              час на дорогу і знизити вартість прибирання.</p>
          </div>
        </div>
      </div>
    </div>
    <div class="section">
      <div class="container">
        <div class="row">
          <div class="col-md-6">
            <h1>
              <span class="label label-success">3. Отримайте кращий сервіс</span>&nbsp;</h1>
            <p class="lead">Клінери проходять навчання і стажування перед прибиранням у вашій квартирі.
              Ми використовуємо професійний інвентар, eko-засоби, а після збирання все
              багаторазові серветки, мопи і мікрофібра дезінфікується.</p>
          </div>
          <div class="col-md-6">
            <img src="/resources/cleaning3.png" class="img-responsive">
          </div>
        </div>
      </div>
    </div>
 
   
    <jsp:include page="_footer.jsp" />
  
</body>
</html>
