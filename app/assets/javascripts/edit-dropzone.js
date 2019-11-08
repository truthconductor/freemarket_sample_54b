// $(document).on("turbolinks:load", function() {
$(document).on("ready", function() {
  var input_area = $(".input_area")
  var preview = $(".preview")

  function appendOption(category) {
    var html = `<option value="${category.id}">${category.name}</option>`;
    return html;
  }
  $("#parent_category").val(gon.parent_category);
  $("#child_category").val(gon.child_id);
  $("#grandchild_category").val(gon.grandchild_category);

  // 登録済画像データのidを格納する配列を作成
  // ブラウザ上で削除された画像のidをコントローラへ送り返す。
  var registered_images_ids = [];

  gon.item_images.forEach(function(image, index) {
    var img = $(`<div class = "img-view">
                   <img>
                   <div class="btn-wrapper">
                     <div class="btn-edit">編集</div><!--
                     --><div class="btn-delete">削除</div>
                   </div>
                 </div>`);

    img.data("image", index)
    binary_data = gon.item_images_binary_datas[index]
    // 登録済画像データをsrcプロパティへ付与
    img.find("img").attr({
      src: binary_data
      // src: "data:image/jpeg;base64," + binary_data
    });

    // 登録済画像データのidを配列へ格納
    registered_images_ids.push(image.id)
    // 登録済画像データを持たせたHTMLタグを、ビューへ追加してプレビューを表示させる
    preview.append(img);
  });
  var new_input = $(
    `<input class="upload-image" type="file" style="display: none;">`
  );
  input_area.append(new_input);

  // プレビュー表示されている画像の枚数に応じて、ラベルの大きさを調整
  inputs_length = $('[type="file"].upload-image').length;
  $(`.items-sell-container__dropzone0`).attr('class',`items-sell-container__dropzone${inputs_length}`);

  // プレビュー画像の表示をラベル要素の前に移動させる
  $('.dropzone-box').before($('.img-view'))
  
  // 画像を新しく追加
  $(document).on("change", '[type="file"].upload-image', function() {
    var file = $(this).prop("files")[0];
    var reader = new FileReader();
    var img = $(`<div class = "img-view">
                   <img>
                   <div class="btn-wrapper">
                     <div class="btn-edit">編集</div><!--
                     --><div class="btn-delete">削除</div>
                   </div>
                 </div>`);
    
    reader.onload = function(e) {
      img.find("img").attr({
        src: e.target.result
      });
    };

    reader.readAsDataURL(file);
    var new_input = $(
      `<input class="upload-image" type="file" style="display: none;">`
    );
    input_area.append(new_input);
  })
  // 編集後のデータ送信(submitボタンを指定してもイベントは発火しない)
  $('.edit_item').on('submit', function(e) {
    e.preventDefault();
    // images以外のform情報をformDataに追加
    debugger
    var formData = new FormData($('.submit').get(0));

    // 登録済画像が残っていない場合は便宜的に0を入れる
    if (registered_images_ids.length == 0) {
      formData.append("registered_images_ids[ids][]",0)
      debugger
    // 登録済画像で、まだ残っている画像があればidをformDataに追加していく
    }
    else {
      registered_images_ids.forEach(function(registered_image) {
        formData.append("registered_images_ids[ids][]", registered_image)
        debugger
      });
    }

    // $.ajax({
    //   url: '/items/' + gon.item.id,
    //   type: "PATCH",
    //   data: formData,
    //   contentType: false,
    //   processData: false,
    // })
  });
});  

// $(window).on('load', function() {
//   debugger
//   $("#child_category").val(gon.child_category)
// });
// $("#child_caory").ready(function() {
//   debugger
//   $("#child_category").val(gon.child_category)
// })
  
//   var parentCategory = $('#parent_category').val();
//   if (parentCategory != "---") {
//     $.ajax({
//       url: '/items/get_category_children',
//       type: 'GET',
//       data: { parent_name: parentCategory},
//       dataType: 'json'
//     })
//     .done(function(children) {
//       $('#children_wrapper').remove();
//       $('#grandchildren_wrapper').remove();
//       var insertHTML = '';
//       children.forEach(function(child) {
//         insertHTML += appendOption(child);
//       });
//       appendChildrenBox(insertHTML);
//     })
//     .fail(function() {
//       alert('カテゴリー取得に失敗しました');
//     })
//   } 
//   $("#child_category").val(gon.child_category)


// var childId = $('#child_category option:selected').val();
// if (childId != "---") {
//   $.ajax ({
//     url: '/items/get_category_grandchildren',
//     type: 'GET',
//     data: { child_id: childId },
//     dataType: 'json'
//   })
//   .done(function(grandchildren){
//     if (grandchildren.length != 0) {
//       $('#grandchildren_wrapper').remove();
//       var insertHTML = '';
//       grandchildren.forEach(function(grandchild) {
//         insertHTML += appendOption(grandchild);
//       });
//       appendGrandchildrenBox(insertHTML);
//     }
//   })
//   .fail(function() {
//     alert('カテゴリー取得に失敗しました');
//   })
// }
// else {
//   $('#grandchildren_wrpper').remove();
// }

