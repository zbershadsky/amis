var validator = new Validator();
    validator.init([
        [$("#login"), /^[A-Za-z0-9_]+$/],
        [$("#password_ret"), function(){
            return $("#password_ret").val() == $("#password").val();
        }],
        [$("#first_name"), /^[A-Za-zА-Яа-яЁё-]+$/],
        [$("#last_name"), /^[A-Za-zА-Яа-яЁё-]+$/]
    ]);

$(".a").hide();

$(".progress").hide();

var info = new Messenger();

info.init($("body"));

$(".sign-up-btn").click(function() {

   if ( $(this).hasClass("disabled") ){
        return;
   }

   $(this).addClass("disabled");
   $(".progress").show();

   $.ajax({
        type: "POST",
        url: "/add/user",
        data: {
            first_name  : $("#first_name").val(),
            last_name   : $("#last_name").val(),
            pass        : $("#password").val(),
            login       : $("#login").val(),
            email       : $("#email").val()
        },
        success : function(data){
            data = $.parseJSON(data);
            if (data.status == "success") {
                info.message("User successfully created ! You will be redirected to log in page ...");
                setTimeout(function(){
                    window.location.href = "/log.html";
                }, 3000);
            } else {
                if (data.status == "failed") {
                    switch (data.reason) {
                        case "internal_DB" :
                            info.message("Internal server error, try later !", 3000);
                            break;
                        case "server" :
                            info.message("Server error, try later !", 3000);
                            break;
                        case "login_exist" :
                            info.message("User login is already exist, try another !", 3000);
                            break;
                    }
                }
            }

            $(".sign-up-btn").removeClass("disabled");
            $(".progress").hide();
        },
        error : function() {
            info.message("Request to server is not available, try later !", 3000);
            $(".sign-up-btn").removeClass("disabled");
            $(".progress").hide();
        }
   });

});