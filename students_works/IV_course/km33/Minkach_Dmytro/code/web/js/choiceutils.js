$(document).ready(function() {
   $('#group').click(function() {
       if($(this).attr('id') != 'Оберіть групу') {
            $('#discipline').show(); 
       }

       else {
            $('#discipline').hide();   
       }
   });
});