$(document).on('turbolinks:load', function() {
  $(document).on('keyup', '.item-value', function(event) {
    var price = $(this).val();

    if(price >= 300 && price <= 9999999) {
      var margin = Math.floor(price*0.1);
      var profit = price - margin;
      margin = '¥' + String(margin).replace(/(\d)(?=(\d\d\d)+$)/g, '$1,');
      profit = '¥' + String(profit).replace(/(\d)(?=(\d\d\d)+$)/g, '$1,');
      $('.margin-calculation__result').html(margin);
      $('.profit-calculation__result').html(profit);

    } 
    else {
      $('.margin-calculation__result').html("-");
      $('.profit-calculation__result').html("-");
    }
  });
});