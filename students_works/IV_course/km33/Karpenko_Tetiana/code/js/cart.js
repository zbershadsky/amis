$(document).ready(function () {

/*$(function()	{
	$('td').click(function(e)	{
		//ловим элемент, по которому кликнули
		var t = e.target || e.srcElement;
		//получаем название тега
		var elm_name = t.tagName.toLowerCase();
		//если это инпут - ничего не делаем
		if(elm_name == 'input')	{return false;}
		var val = $(this).html();
		var code = '<input type="text" id="edit" value="'+val+'" />';
		$(this).empty().append(code);
		$('#edit').focus();
		$('#edit').blur(function()	{
			var val = $(this).val();
			$(this).parent().empty().html(val);
		});
	});
});

$(window).keydown(function(event){
	//ловим событие нажатия клавиши
	if(event.keyCode == 13) {	//если это Enter
		$('#edit').blur();	//снимаем фокус с поля ввода
	}
});*/

 $("#uncol-menu li a").on('click', function () {
        var hash = this.hash;
        $("html, body").animate({
                scrollTop: $(hash).offset().top - headerHeight
            }, 500,
            function () {
                window.location.hash = hash;
            });
    });
    
    $("#upArr").on('click', function scroll() {
        $("html, body").animate({
            scrollTop: 0
        }, 500);
    });


    $("#open-menu, #close-menu, #uncol-menu li a").on('click', function () {
        $('#uncol-menu, header').toggle();
    });

    var $menu = $("header");
    $(window).scroll(function () {
        if ($(this).scrollTop() > 1 && $menu.hasClass("default")) {
            $menu.removeClass("default").addClass("shadow");
        } else if ($(this).scrollTop() <= 1 && $menu.hasClass("shadow")) {
            $menu.removeClass("shadow").addClass("default");
        }
    });


$("#change").submit (function (e) {
		e.preventDefault();
		var form = $(this);
		var pay_name = $('input[class=pay_name]').val(function( i, value ) {return value;});
		var pay_surname = $('input[class=pay_surname]').val(function( i, value ) {return value;});
		var email_to_send = $('input[class=email_to_send]').val(function( i, value ) {return value;});
		var addres = $('input[class=addres]').val(function( i, value ) {return value;});
		var service = $('input[class=service]').val(function( i, value ) {return value;});
		var idArr = []
		$(this).find("tbody tr").each(function(e){
			idArr.push($(this).attr("id"));
		})

		for (var i=0; i< pay_name.length; i++){
			//get query
			var data_to_send = "addFName="+pay_name[i].value+"&addSName="+pay_surname[i].value+"&addEmail="+email_to_send[i].value+"&addAddres="+addres[i].value+ "&addService="+service[i].value+"&id="+idArr[i];
			console.log (data_to_send);
			$.ajax({
				type: "POST",
			   	url: "php/logik_cart.php",
			   	data: data_to_send,
			   	success :  function(response){
			   		if (response == 1) {
			   			//alert ("Зміни збережені");
			   			location.reload();
			   		}
			   		else {
			   			alert ("Виникли технічні проблеми, спробуйте перезавантажити сторінку");
			   		};
			   	}      
			
			});	
		};
	});


$(".delete").click (function (e) {
		e.preventDefault();
		result = prompt("Наберите слово 'delete', если Вы подтвержадеие удаление элемента", "");
		if (result == "delete"){
			//alert ("to del");
			var data_to_send = "idtodel="+$(this).attr("id");
			var id = $(this).attr("id")
			$.ajax({
				type: "POST",
			   	url: "php/logik_cart.php",
			   	data: data_to_send,
			   	success :  function(response){
			   		if (response == 1) {
			   			$('tr[id="'+id+'"]').remove();
			   		}
			   		else {
			   			//alert (response);
			   			alert ("Виникли технічні проблеми, спробуйте перезавантажити сторінку");
			   		};
			   	}      
			
			});	
		};
});

$('.aid').click (function () {
		//alert ("here");
		$.ajax({
			   	type: "POST",
			   	url: "php/exit.php",
			   	success :  function(response){
			   		
			   		//alert (response);
			   		location.reload();

			   	}      
		    })
}) 

})