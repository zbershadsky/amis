var validator = new Validator();
validator.init([
        [$("#login"), /^[A-Za-z0-9_]+$/]
]);

$(".a").hide();

var info = new Messenger();

info.init($("body"));
$(".progress").hide();

$(".log_in_button").click(function() {

   if ( $(this).hasClass("disabled") ){
        return;
   }

   $(this).addClass("disabled");
   $(".progress").show();

   $.ajax({
        type: "POST",
        url: "/login",
        data: {
            pass    : $("#password").val(),
            login   : $("#login").val()
        },
        success : function(data){
            data = $.parseJSON(data);
            if (data.autorized == "true") {
                info.message("User successfully logged in ! You will be redirected to home page ...");
                setTimeout(function(){
                    window.location.href = "/index.html";
                }, 3000);
            } else {
                info.message("You are not autorized with you credentials !", 5000);
            }

            $(".log_in_button").removeClass("disabled");
            $(".progress").hide();
        },
        error : function() {
            info.message("Request to server is not available, try later !", 3000);
            $(".log_in_button").removeClass("disabled");
            $(".progress").hide();
        }
   });

});