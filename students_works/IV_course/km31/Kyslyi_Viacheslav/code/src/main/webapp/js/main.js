$( document ).ready(function(){
    $(".button-collapse").sideNav();
    $('.carousel').carousel();
    $(document).ready(function() {
        $('select').material_select();
    });

});

$(".a").hide();
$(".na").show();

function Messenger() {

    var container = "<div class='message_container grey darken-3'> <h5 class = 'message'></h5> </div>";

    return {
        init : function(parent) {
            parent.append(container);
            container = $(".message_container");
             container.css({
                width : "100%",
                position : "fixed",
                height : "50px",
                bottom : "-50px",
                color : "white"
            });
        },
        message : function(text, timeout) {
            container.find(".message").css("paddingLeft", "15px");
            container.find(".message").html(text);
            container.css("bottom", "0px");

            if (timeout) {
                setTimeout(function(){
                    container.css("bottom", "-50px");
                }, timeout);
            }
        }
    }
}

(function checkSession(){
    $.post("/session", function(data){
        data = $.parseJSON(data);
        if (data.login){
            var login = data.login;
            $(".a").show();
            $(".na").hide();
        } else {
            $(".a").hide();
            $(".na").show();
        }
    });
})();