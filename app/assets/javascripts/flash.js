$(document).on('turbolinks:load', function() {
  setTimeout("$('.notice, .alert').fadeOut('slow')", 4000);
  // setTimeout("$('.notification').fadeOut('slow')", 4000);
});