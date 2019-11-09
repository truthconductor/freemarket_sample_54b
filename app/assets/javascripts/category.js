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

  // ブランド入力欄を作成する
  function appendBrandInputBox() {
    var brandInputHTML = $(`<div class='items-sell-container__form__field' id='brand_wrapper'>
                              <div class="items-sell-container__form__description__label">
                                <label for="item_brand">ブランド</label>
                                <span class="form--optional">任意</span>
                              </div>
                              <input placeholder="例）シャネル" class="items-sell-container__form__field__input-field" type="text" name="item[brand_name]" id="item_brand">
                            </div>`);
    $('#items-sell-container-category').after(brandInputHTML);
  }

  // 親カテゴリー選択後のイベント
  $('#parent_category').on('change', function() {
    // 子カテゴリ以下・ブランド入力を消去
    $('#children_wrapper').remove();
    $('#grandchildren_wrapper').remove();
    $('#brand_wrapper').remove();
    // 選択したカテゴリーを取得
    var parentCategory = $('#parent_category').val();
    if (parentCategory != "---") {
      $.ajax({
        url: '/items/get_category_children',
        type: 'GET',
        data: { parent_name: parentCategory},
        dataType: 'json'
      })
      .done(function(children) {
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
  });

  // 子カテゴリー選択後のイベント
  $('.items-sell-detail__category').on('change', '#child_category', function() {
    // 孫カテゴリ以下・ブランド入力を消去
    $('#grandchildren_wrapper').remove();
    $('#brand_wrapper').remove();
    // 選択したカテゴリーを取得
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
          var insertHTML = '';
          grandchildren.forEach(function(grandchild) {
            insertHTML += appendOption(grandchild);
          });
          appendGrandchildrenBox(insertHTML);
        }
        else
        {
          // 孫カテゴリーが存在しないカテゴリーの時ブランド入力を追加
          // TODO:ブランド入力が可能なカテゴリーかを非同期通信で判断し追加する条件分岐が必要
          //      現時点では全てのカテゴリーで入力可能とした
          if($('#brand_wrapper').length == 0) {
            appendBrandInputBox();
          }
        }
      })
      .fail(function() {
        alert('カテゴリー取得に失敗しました');
      })
    }
  });

  // 孫カテゴリー選択後のイベント
  $('.items-sell-detail__category').on('change', '#grandchild_category', function() {
    var grandchildId = $('#grandchild_category option:selected').val();
    if (grandchildId != "---") {
      if($('#brand_wrapper').length == 0) {
        // 孫カテゴリー選択後ブランド入力を追加
        // TODO:ブランド入力が可能なカテゴリーかを非同期通信で判断し追加する条件分岐が必要
        //      現時点では全てのカテゴリーで入力可能とした
        appendBrandInputBox();
      }
    }
  });
});