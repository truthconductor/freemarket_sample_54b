$(document).on('turbolinks:load', function() {
  setTimeout("$('.notice, .alert').fadeOut('slow')", 4000);
});