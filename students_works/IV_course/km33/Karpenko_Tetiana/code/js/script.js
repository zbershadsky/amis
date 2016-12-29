$(document).ready(function () {


    var headerHeight = window.innerWidth > 1 ? $('header').outerHeight() : 0;


    
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


    

    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        var target = $(e.target); // activated tab
        var i = target.parents('ul').find('a.dropdown-toggle').find('i');
        target.parents('ul').find('a.dropdown-toggle').html($(e.target).html()).append(i);
    });

});

function goBack() {
    window.history.back();
}

