$(document).on('turbolinks:load', function() {
  function appendOption(deliver) {
  var html = `<option value="${deliver.id}">${deliver.method}</option>`;
  return html;
  }

  // 配達方法フォームの作成
  function appendDeliverMethodBox(insertHTML) {
    var deliverMethodHtml = $(`<div class='items-sell-container__form__field' id='deliver_method_wrapper'>
                                 <div class='items-sell-container__form__field__label'>
                                   <label for='deliver_method_id'>配送の方法</label>
                                   <span class='form--required'>必須</span>
                                 </div>
                                 <select class='items-sell-container__form__field__input-field' id='deliver_method' name='item[deliver_method_id]'>
                                   <option value="---">---</option>
                                   ${insertHTML}
                                 </select>
                               </div>`);
  $('#items-sell-delivery-method').append(deliverMethodHtml);
  }

  $('#item_deliver_expend_id').on('change', function() {
    var removeForm = function() {
      $('#deliver_method_wrapper').remove();
      $('#deliver_method').remove();
    }
    var deliverExpend = $('#item_deliver_expend_id').val();
    if (deliverExpend == 1) {
      $.ajax({
        url: '/items/get_deliver_method',
        type: 'GET',
        data: { deliver_expend: deliverExpend},
        dataType: 'json'
      })
      .done(function(deliver_method){
        removeForm();
        var insertHTML = '';
        deliver_method.forEach(function(method) {
          insertHTML += appendOption(method);
        });
        appendDeliverMethodBox(insertHTML);
      })
      .fail(function(){
        alert('配達方法の取得に失敗しました')
      })
    } 
    else if
      (deliverExpend == 2) {
      $.ajax({
        url: '/items/get_deliver_method_cash_on_delivery',
        type: 'GET',
        data: { deliver_expend: deliverExpend},
        dataType: 'json'
      })
      .done(function(deliver_method){
        removeForm();
        var insertHTML = '';
        deliver_method.forEach(function(method) {
          insertHTML += appendOption(method);
        });
        appendDeliverMethodBox(insertHTML);
      })
      .fail(function(){
        alert('配達方法の取得に失敗しました')
      })
    }
    else {
      removeForm();
    }
  });
});