(function( $ ){

//	Phone Mask
$(function() {
    
    $('#phone').each(function(){
      $(this).mask("+38(099) 999-99-99");
    });
    

});

})( jQuery );


$(document).ready(function() {
   $('input[type="radio"]').click(function() {
       if($(this).attr('id') == 'test1') {
            $('#group').show(); 
            document.getElementById('groupsel').required = true;
       }

       else {
            $('#group').hide();   
            document.getElementById('groupsel').required = false;
       }
   });
});