$(document).on('turbolinks:load', function() {

  //インクリメンタルサーチ機能を追加する
  addIncrementalSearch();

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
                                <label for="item_brand_input">ブランド</label>
                                <span class="form--optional">任意</span>
                              </div>
                              <input placeholder="例）シャネル" class="items-sell-container__form__field__input-field" type="text" name="item[brand_name]" id="item_brand_input" autocomplete="off">
                            </div>`);
    $('#items-sell-container-category').after(brandInputHTML);

    // インクリメンタルサーチ処理を追加
    addIncrementalSearch();
  }

  // インクリメンタルサーチ処理を追加
  function addIncrementalSearch() {
    $("#item_brand_input").on("keyup", function() {
      var input = $("#item_brand_input").val();
      if (input.length == 0)
      {
         $("#brand-incremental-search-results").remove();
        return;
      }
      // ブランド名をインクリメンタルサーチ
      $.ajax({
        type: "get",
        url: location.origin + "/api/brands/search",
        data: { keyword: input },
        dataType: "json"
      })
      .done(function(brands) {
        // 検索結果を表示（ヒットしなかった時は結果リストを消去）
        if (brands.length > 0) {
          appendBrandSearchResults(brands);
        }
        else {
          $("#brand-incremental-search-results").remove();
        }
      })
      .fail(function(jqXHR, textStatus, errorThrown) {
        alert('ブランド検索に失敗しました');
      });
    });
  }

  // インクリメンタルサーチ結果を入れるリストのマークアップを取得、無ければ作成して追加する
  function appendBrandSearchResults(brands) {
    // 検索結果を入れるリストの用意
    var search_results_list = $("#brand-incremental-search-results");
    if (search_results_list.length == 0) {
      search_results_list = $(`<li id="brand-incremental-search-results" class="brand-incremental-search-results"></li>`);
      // ブランド名入力エリアの下にインクリメンタルサーチ結果表示エリアを追加
      $('#item_brand_input').after(search_results_list);
    }
    else
    {
      // 直前の検索結果を消去
      search_results_list.empty();
    }

    // インクリメンタルサーチ結果のブランド名を追加
    brands.forEach(function(brand) {
      var insertListItem = $(`<ul class="brand-incremental-search-results__item">
                            ${brand.name}
                          </ul>`);
      // クリックした検索結果を入力欄に追加
      insertListItem.on('click', function(e) {
        $("#item_brand_input").val(e.target.innerText);
        $("#brand-incremental-search-results").remove();
      });
      search_results_list.append(insertListItem);
    });

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
    else {
      $('#grandchildren_wrapper').remove();
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