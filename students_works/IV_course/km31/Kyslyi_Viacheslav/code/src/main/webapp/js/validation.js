function Validator(){
    var data;

    function isRegExpMatch(str, regexp_str){
        console.log(str);
        console.log(str.match(regexp_str));
        return !!str.match(regexp_str);
    }

    function addRegExpConstraint(elem, regExp){
        elem.focusout(function(){
            if(isRegExpMatch(elem.val(), regExp)){
                elem.addClass("valid");
                elem.removeClass("invalid");
            } else {
                elem.addClass("invalid");
                elem.removeClass("valid");
            }
        });
    }

    function addFunctionConstraint(elem, func){
        elem.focusout(function(){
            if(func()){
                elem.addClass("valid");
                elem.removeClass("invalid");
            } else {
                elem.addClass("invalid");
                elem.removeClass("valid");
            }
        });
    }

    return {
        init : function(valid_arr) {
            data = valid_arr;
            var elem;
            var regExp;
            for(var i=0 ; i<valid_arr.length ; i++){
                elem = valid_arr[i][0];
                regExp = valid_arr[i][1];
                if (typeof  regExp == "function") {
                    addFunctionConstraint(elem, regExp);
                } else {
                    addRegExpConstraint(elem, regExp);
                }
            }
        }
    }
}