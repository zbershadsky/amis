var rest_template;
$('#search').prop("disabled", true);

$(".a").hide();

var info = new Messenger();

info.init($("body"));

$.get("/templates/rest_card.html", function(data) {
    $('#search').prop("disabled", false);
    $(".progress").hide();
    rest_template = data;
});

function clone(str){
    var res = "";
    for(var i=0 ; i<str.length ; i++) res += str.charAt(i);
    return res;
}

function search() {
    $.ajax({
        type: "POST",
        url: "/get/restaurant",
        data: {
            query  : $("#search").val()
        },
        success : function(data){
            data = $.parseJSON(data);

            $(".card_container").html("");

            for (var i=0 ; i<data.length ; i++) {
                var obj = data[i];
                var template = clone(rest_template);
                template = template.replace("{name}", obj.name);
                template = template.replace("{link}", "/rest_detail.html?id=" + obj.id);
                template = template.replace("{description}", obj.description);
                $(".card_container").append(template);
            }

            $('#search').prop("disabled", false);
            $(".progress").hide();
        },
        error : function() {
            info.message("Error during request", 3000);
            $('#search').prop("disabled", false);
            $(".progress").hide();
        }
    });
}

$('#search').keypress(function (e) {
  if (e.which == 13) {

    $('#search').prop("disabled", true);
    $(".progress").show();

    search();

    return false;
  }
});
