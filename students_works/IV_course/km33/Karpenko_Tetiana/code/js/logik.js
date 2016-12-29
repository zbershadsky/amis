$(document).ready(function () {

 $("#auth_form").submit(function(e) { //устанавливаем событие отправки для формы с id=form
 			e.preventDefault();
 			var form = $(this);
            var form_data = form.serializeArray(); //собераем все данные из формы
            //data_to_send = {auth_login :form_data[0].value, auth_pass:  CryptoJS.MD5(form_data[1].value)};

            var data_to_send = "auth_login=" + form_data[0].value + "&auth_pass=" + CryptoJS.MD5(form_data[1].value);
            //console.log(data_to_send);
           	$.ajax({
			   	type: "POST",
			   	url: "php/logik.php",
				data: data_to_send,
			   	success :  function(response){
			   		if(response == 1){
			   		location.reload();
			   		}
			   		else if (response == 0)
			   			{alert ("Невірно введені дані")}
			   		else {
			   			//alert (response);
			   			alert ("Виникли технічні проблеми") ;
			   		};
			   	}      
		    })
    });

$("#reestr_form").submit ( function (e) {
		e.preventDefault();
		var form = $(this);
        var form_data = form.serializeArray();
        if (form_data[3].value !== form_data[4].value) {alert ("Passwords do not match!")}
        else {
        	// send data to php
        var data_to_send = "reg_Fname="+form_data[0].value+"&reg_Sname="+form_data[1].value+"&reg_login=" + form_data[2].value + "&reg_pass=" + CryptoJS.MD5(form_data[3].value);
        $.ajax({
			type: "POST",
		   	url: "php/logik.php",
			data: data_to_send,
		   	success :  function(response){
		   		if (response == 1 ){
		   			alert ("Тепер Ви можете увійти до системи");
		   			location.reload();
		   		}
		   		else if (response == 0){
		   			alert ("Така адреса вже зареєстрована");
		   		}
		   		else {
		   			//alert (response);
		   			alert ("Виникли технічні проблеми") ;
		   		};

		   	}      
		    })	
        };

	});
$('.aid').click (function () {

		$.ajax({
			   	type: "POST",
			   	url: "php/exit.php",
			   	success :  function(response){
			   		//alert (response);
			   		location.reload();

			   	}      
		    })
}) 

$("#add_to_cart").submit (function (e) {
		e.preventDefault();
		var form = $(this);
		$.ajax({
			type: "POST",
		   	url: "php/check.php",
		   	success :  function(response){
		   		if (response != 0 ){
		   			var multyArray = $('select[name=selectService]').val()
					var form_data = form.serializeArray();
					var data_to_send = "addFName="+form_data[0].value+"&addSName="+form_data[1].value+"&addEmail="+form_data[2].value+"&addCity="+form_data[3].value+"&addAddress="+form_data[4].value;
					for (var i =0;i<multyArray.length;i++){
						send_now = data_to_send + "&addService="+multyArray[i];
						//alert (send_now);
						$.ajax({
			   			type: "POST",
			   			url: "php/logik.php",
						data: send_now,
			   			success :  function(response){
			   				if (response == 1 ){
					   			//alert ("Тепер Ви можете перейти до кошика");
					   			//location.reload();
					   		}
					   		else {
					   			//alert (response);
					   			alert ("Виникли технічні проблеми") ;
					   		};

			   				//alert (response);
			   				//location.reload();
			   			}      
		    			})
					}
		   			alert ("Тепер Ви можете перейти до кошика");
		   			location.reload();
		   		}
		   		else {
		   			alert ("Нажаль на даний момент відсутня функція оплати без реєстрації на сайті");
		   		};
		   	}      
		    });	
        });


$("#change_pass").submit ( function (e) {
		e.preventDefault();
		var form = $(this);
        var form_data = form.serializeArray();
        if (form_data[1].value !== form_data[2].value) {alert ("Passwords do not match!")}
        else {
        	// send data to php
        var data_to_send ="old_pass=" + CryptoJS.MD5(form_data[0].value) +"&new_pass=" + CryptoJS.MD5(form_data[1].value) ;
        //alert (form_data[0].value);
        //alert (form_data[1].value);
        $.ajax({
			type: "POST",
		   	url: "php/logik.php",
			data: data_to_send,
		   	success :  function(response){
		   		if (response == 1 ){
		   			alert ("Пароль змінено");
		   			location.reload();
		   		}
		   		else if (response == 0){
		   			//alert (response);
		   			alert ("Введено невірний пароль");
		   		}
		   		else {
		   			alert (response);
		   			alert ("Виникли технічні проблеми") ;
		   		};

		   	}      
		    })	
        };

	});

});