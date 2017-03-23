$(document).ready(function(){

  var scrollPos = function(targetID) {
    var targetOffset = $('#' + targetID).offset().top;
    $(window).scrollTop( targetOffset );
  };

  if(window.location.hash) {
    scrollPos(window.location.hash.substring(1));
  }

}) 
