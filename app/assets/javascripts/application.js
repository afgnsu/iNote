// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require masonry/jquery.masonry
//= require bootstrap
//= require_tree .

$(document).ready(function(){
    $('[data-toggle="popover"]').popover({html: true});   
});

jQuery(function($) {
  $("tr[data-link]").click(function() {
    window.open(this.dataset.link);
  });
})

// FLASH NOTICE ANIMATION
var fade_flash = function() {
  var flash_message = $("#flash-message");

  if ( flash_message.is(':animated') )
    flash_message.stop(true,true).animate({opacity:1});

  flash_message.delay(5000).fadeOut("slow");
};

var show_ajax_message = function(msg, type) {
  var flash_message = $("#flash-message");

  //delete the flash message (if it was there before) when an ajax request returns no flash message
  if ( (type.indexOf("empty") == 0) || msg == null || (msg.length == 0) ) {
    flash_message.html("").hide();
    return;
  }

  var alert_type = (type.indexOf("error") == -1) ? 'alert-success' : 'alert-error';

  flash_message.html(
    "<div class='alert " + alert_type + "'><a class='close' data-dismiss='alert'>&#215;</a>" +
    "<div id='flash_" + type + "'>" + msg + "</div></div>"
  ).show();

  fade_flash();
};

$(document).ajaxComplete(function(event, request) {
  var msg = request.getResponseHeader('X-Message');
  var type = request.getResponseHeader('X-Message-Type');

  if (type.indexOf("keep") != 0)
    show_ajax_message(msg, type); //use whatever popup, notification or whatever plugin you want
});
