$(document).on('turbolinks:load', function () {

    'use strict';
    
  if ($('#snackbar-container').length == 0){
    $("body").append("<div id=snackbar-container/>");
  }
  
  if ($('.snackbar-message').length > 0){
    $('.snackbar-message').snackbar('show');
    //$('#snackbar-container-l > span, #snackbar-container-l > div').remove();
  }

  //Dispara msj de flash desde js
  //Ej: $(document).trigger('flash:send', {"danger":"Hola"});
  $(document).on('flash:send', function(e, flashMessages){
    $('#snackbar-container > div').remove();
    $('#snackbar-container > span, #snackbar-container > div').remove();
    $.each(flashMessages, function(key, value) {
      var style;
      style = '';
      switch (key) {
      case 'success':
        style = 'callout callout-success bg-green';
        break;
      case 'danger':
        style = 'callout callout-danger bg-red';
        break;
      case 'error':
        style = 'callout callout-danger bg-red';
        break;
      default:
        style = 'callout';
        break;
      }
      $.snackbar({
        content: value,
        style: style,
        timeout: 10000
      });
    });
  });
});