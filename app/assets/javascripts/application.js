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
    $(".create-quicknote").hover(function() {
      $(".header-quicknote").slideDown();
    });   
    
    $(".navbar-fixed-top").mouseleave(function() {
      $(".header-quicknote").slideUp();
    });   

    $('.reviews').css('height',$(window).height() * 0.50);
    
    $(".addYoutubeSrc").click(function(e) {
        e.preventDefault();
        $("#youtubeFrame").attr("src", $(".embed_youtube_link").data('content'));
    })    

    $(".deleteYoutubeSrc").click(function(e) {
        e.preventDefault();
        $("#youtubeFrame").attr("src", "");
    })  
  
    $('#shareFacebook').click(function(e) { 
        window.open($(this).attr('href'), "Share to Facebook", "width=800px, height=600px"); 
        e.preventDefault();
    }); 
    
      
});

jQuery(function($) {
  $("tr[data-link]").click(function() {
    window.open(this.dataset.link);
  });
  
})
