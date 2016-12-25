/**
 * Created by Admin on 26.10.2016.
 */

function mouseEvent(selector, className) {

    selector.mouseenter(function() {
        $(this).toggleClass(className);
    });

    selector.mouseleave(function() {
        $(this).toggleClass(className);
    });
}

function inputLengthCheck(selectorIn, len) {
    $(selectorIn).keydown(function() {
        var v = $(this).val();
        var postLength = v.length;
        var charactersLeft = len - postLength;
        if (charactersLeft <= 0) {
            $(this).val(v.substring(0, len));
        }
    });
}

function doAjax(instance, product, link) {

    var textContent = $(instance).text();

    var quantity;
    var pattern = /^[1-9][0-9]{0,2}$/;
    var selectorInputQuantity = "#" + link;
    quantity = $(selectorInputQuantity).val();
    if (pattern.test(quantity) || (quantity === "" && textContent === "Видалити з кошика")) {
        $.ajax({
            url : '/code/add_or_remove_product',
            type: 'GET',
            dataType: 'json',
            contentType: 'application/json',
            mimeType: 'application/json',
            data : ({
                product: product,
                quantity: quantity
            })
        });

        if (textContent === "Додати у кошик") {
            $(instance).html("Видалити з кошика");
        } else {
            $(instance).html("Додати у кошик");
            $(instance).siblings(".selected_quantity").addClass("display_none");
        }

        $(instance).toggleClass("back_color_red");
        $(instance).prev().toggleClass("display_none");

        $(".error_block").html("");
    } else {
        $(".error_block").html("Кількість від 1 до 999");
    }
}

function main() {
    mouseEvent($(".basket_operation"), "back_color_white");
    mouseEvent($("#red_link"), "red");
    mouseEvent($("#yellow_link"), "yellow");
    mouseEvent($("#green_link"), "green");
    inputLengthCheck($("#reg_username"), 16);
    inputLengthCheck($("#reg_password"), 16);
    inputLengthCheck($("#reg_conf_password"), 16);
    inputLengthCheck($("#old_password"), 16);
    inputLengthCheck($("#new_password"), 16);
    inputLengthCheck($("#check_password"), 16);
    inputLengthCheck($("#reg_email"), 50);
    inputLengthCheck($("#old_email"), 50);
    inputLengthCheck($("#new_email"), 50);
    inputLengthCheck($("#reg_phone_number"), 13);
    inputLengthCheck($("#old_phone"), 13);
    inputLengthCheck($("#new_phone"), 13);
}

$(document).ready(main);