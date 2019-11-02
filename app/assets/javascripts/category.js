$(document).on('turbolinks:load', function() {
  function appendOption(category) {
    var html = `<option value="${category.id}">${category.name}</option>`;
    return html;
  }

  // 子カテゴリーの表示を作成する
  function appendChildrenBox(insertHTML) {
    var childSelectHtml = $(`<div class='items-sell-container__form__field-detail' id='children_wrapper'>
                               <select class='items-sell-container__form__field__input-field' id='child_category' name='item[category_id]'>
                                 <option value="---">---</option>
                                 ${insertHTML}
                               </select>
                             </div>`);
    $('.items-sell-detail__category').append(childSelectHtml);
  }
  // 孫カテゴリーの表示を作成する
  function appendGrandchildrenBox(insertHTML) {
    var grandchildSelectHTML = $(`<div class='items-sell-container__form__field-detail' id='grandchildren_wrapper'>
                                    <select class='items-sell-container__form__field__input-field' id='grandchild_category' name='item[category_id]'>
                                      <option value="---">---</option>
                                      ${insertHTML}
                                    </select>
                                  </div>`);
    $('.items-sell-detail__category').append(grandchildSelectHTML);
  }

  // 親カテゴリー選択後のイベント
  $('#parent_category').on('change', function() {
    var parentCategory = $('#parent_category').val();
    if (parentCategory != "---") {
      $.ajax({
        url: '/items/get_category_children',
        type: 'GET',
        data: { parent_name: parentCategory},
        dataType: 'json'
      })
      .done(function(children) {
        $('#children_wrapper').remove();
        $('#grandchildren_wrapper').remove();
        // $('#brand_wrapper').remove();
        var insertHTML = '';
        children.forEach(function(child) {
          insertHTML += appendOption(child);
        });
        appendChildrenBox(insertHTML);
      })
      .fail(function() {
        alert('カテゴリー取得に失敗しました');
      })
    } 
    else {
      $('#children_wrapper').remove();
      $('#grandchildren_wrapper').remove();
      // $('#brand_wrapper').remove();
    }
  });
  // 子カテゴリー選択後のイベント
  $('.items-sell-detail__category').on('change', '#child_category', function() {
    var childId = $('#child_category option:selected').val();
    if (childId != "---") {
      $.ajax ({
        url: '/items/get_category_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json'
      })
      .done(function(grandchildren){
        if (grandchildren.length != 0) {
          $('#grandchildren_wrapper').remove();
          // $('#brand_wrapper').remove();
          var insertHTML = '';
          grandchildren.forEach(function(grandchild) {
            insertHTML += appendOption(grandchild);
          });
          appendGrandchildrenBox(insertHTML);
        }
      })
      .fail(function() {
        alert('カテゴリー取得に失敗しました');
      })
    }
    else {
      $('#grandchildren_wrpper').remove();
      $('#brand_wrpper').remove();
    }
  });
});