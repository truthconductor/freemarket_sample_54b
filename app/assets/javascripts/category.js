$(document).on('turbolinks:load', function() {
  function appendOption(category) {
    var html = `<option value="${category.name}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }

  // 子カテゴリーの表示を作成する
  function appendChildrenBox(insertHTML) {
    var childSelectHtml = $(`<div class='items-sell-container__box' id='children_wrapper'>
                              <div class='items-sell-container__form__field'>
                                <select class='items-sell-container__form__field__input-field' id:'child_category' name='category_id>
                                  <option value="---" data-category="---">---</option>
                                  ${insertHTML}
                                </select>
                              </div>
                            </div>`);
    debugger
    $('.items-sell-detail__category').append(childSelectHtml);
  }
  // 孫カテゴリーの表示を作成する

  // 親カテゴリー選択後のイベント
  $('#parent_category').on('change', function() {
    var parentCategory = $('#parent_category').val();
    debugger
    if (parentCategory != "---") {
      $.ajax({
        url: 'get_category_children',
        type: 'GET',
        data: { parent_name: parentCategory},
        dataType: 'json'
      })
      .done(function(children) {
        debugger
        $('#children_wrapper').remove();
        // $('#children_wrapper').remove();
        // $('#brand_wrapper').remove();
        var insertHTML = '';
        children.forEach(function(child) {
          insertHTML += appendOption(child);
        });
        debugger
        appendChildrenBox(insertHTML);
      })
      .fail(function() {
        alert('カテゴリー取得に失敗しました');
      })
    } 
    else {
      $('#children_wrapper').remove();
      // $('#children_wrapper').remove();
      // $('#brand_wrapper').remove();
    }
  });
});