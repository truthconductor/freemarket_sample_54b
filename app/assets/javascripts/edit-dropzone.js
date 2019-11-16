$(document).on("turbolinks:load", function() {
  var input_area = $(".input_area")
  var preview = $(".preview")

  // editでのみ発火するよう制限
  var re = new RegExp('/items/[0-9]+/edit$');
  if(!re.test(location.pathname)) {
   return;
  }

  $("#parent_category").val(gon.parent_category);
  $("#child_category").val(gon.child_id);
  $("#grandchild_category").val(gon.grandchild_category);

  for (var i = preview.length; i > 1; i--) {
    preview[i-1].remove();
  }
  preview = $('.preview');

  // 登録済画像データのidを格納する配列を作成
  // ブラウザ上で削除されていない画像のidをコントローラへ送り返す
  var registered_images_ids = [];

  gon.item_images.forEach(function(image, index) {
    var img = $(`<div class = "img-view" data-image = "${index}">
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
    });

    // 登録済画像データのidを配列へ格納
    registered_images_ids.push(image.id)
    // 登録済画像データを持たせたHTMLタグを、ビューへ追加してプレビューを表示させる
    preview.append(img);
  });

  add_data_image();
  // プレビュー表示されている画像の枚数に応じて、ラベルの大きさを調整
  inputs_length = $('input[name^="item[item_"]').length;
  $(`.items-sell-container__dropzone0`).attr('class',`items-sell-container__dropzone${inputs_length - 1}`);

  // プレビュー画像の表示をラベル要素の前に移動させる
  $('.dropzone-box').before($('.img-view'))
  
  // 画像を新規追加
  // inputの中身の変更時に発生
  $(document).on('change', '[type="file"].upload-image', function(event) {

    // 変更を行ったinputを取得する
    changed_input = $(this);
    changed_id = changed_input.data('image');
    // 現時点でのfile用inputタグを全取得する
    inputs_length = $('input[name^="item[item_"]').length;
    //画像が10枚より少ない場合、inputを更に追加
    if(inputs_length <= 10) {
      var new_input = $(`<input class="upload-image" type="file" style="display: none;" name="item[item_images_attributes][${inputs_length}][image]" id="upload-image-${inputs_length}">`);
      input_area.append(new_input);
    }

    // ラベルのサイズ調整
    $('.dropzone-box').attr('for',`upload-image-${inputs_length}`);
    $(`.items-sell-container__dropzone${inputs_length - 1}`).attr('class',`items-sell-container__dropzone${inputs_length}`);

    //変更されたidに対応するimg-viewを取得
    var image_view = $(".img-view[data-image="+changed_id+"]").first();
    //idに対応するimg_viewが存在しないときは追加
    if(!image_view[0]) {
      image_view = $(`<div class = "img-view">
                        <img>
                        <div class="btn-wrapper">
                          <div class="btn-edit">編集</div><!--
                          --><div class="btn-delete">削除</div>
                        </div>
                      </div>`);
      preview.append(image_view);
    }
    
    // プレビュー画像の表示をラベル要素の前に移動させる
    $('.dropzone-box').before($('.img-view'))

    //input,image_viewそれぞれにindexを再割り当て
    reorder_new_data_image();

    // アップロードされた画像ファイル(ファイルオブジェクト)の属性値(filesプロパティ)を取得する
    var file = changed_input.prop('files')[0];
    // FileReaderオブジェクトをインスタンス化する
    var reader = new FileReader();
    // ファイル読み込み後の処理
    reader.onload = function(e) {
      // img_view内のimgタグのsrcプロパティへ、読み込みが完了した画像を入れ込む
      image_view.find('img').attr('src', e.target.result);
    };

    // FileReaderオブジェクトへ属性値(filesプロパティ)を代入する
    reader.readAsDataURL(file);
  });

  // 削除クリック
  $(document).on('click', '.btn-delete', function() {
    // イベントが発生したimage_viewのオブジェクトとidを取得する
    var target_image = $(this).parent().parent();
    var remove_id = Number($(this).parent().parent()[0].getAttribute('data-image'));
    // var remove_id = target_image.data('image');

    // 同じidのinputを取得する
    var remove_input = $(`input[data-image=${remove_id}]`);

    // 削除された登録済み画像のIDを配列から削除する
    var removed_image_id = remove_input[0].value
    $.each(registered_images_ids, 
      function(index) {
        if (Number($(this)[0]) === Number(removed_image_id)) {
          registered_images_ids.splice(index, 1);
        }
      }
    );
    //input,image_view消去
    remove_input.remove();
    target_image.remove();

    // 現時点でのfile用inputタグを全取得する
    inputs_length = $('input[name^="item[item_"]').length;

    // ラベルのサイズ調整
    $('.dropzone-box').attr('for',`upload-image-${inputs_length - 1}`);
    $(`.items-sell-container__dropzone${inputs_length}`).attr('class',`items-sell-container__dropzone${inputs_length - 1}`);
    
    //input,image_viewそれぞれにindexを再割り当て
    reorder_uploaded_data_image();
    reorder_new_data_image();
  });

  // hidden_fieldへdata-imageを付与
  function add_data_image() {
    $('input[id^="item_item_images_attributes"]').each(function(index) {
      $(this).attr({
        'data-image': String(index),
      });
    })
  };

  // data-imageをの番号を再割り当てする
  function reorder_new_data_image() {
    // input,image_viewそれぞれにindexを再割り当て
    $('input[id^="upload-image"]').each(function(index, input) {
      // 登録済み画像の枚数を足した数からeachをスタートする
      var image_number =  index + $('input[id^="item_item_images_attributes"]').length;
      $(input).attr({
        'data-image': String(image_number),
        id: 'upload-image-' + image_number,
        name: 'item[item_images_attributes][' + image_number + '][image]',
      });
      $(input).prop('disabled', index >= 10);
    })
    $('.img-view').each(function(index, image) {
      $(image).attr('data-image', String(index));
    });
  }

  function reorder_uploaded_data_image() {
    // input,image_viewそれぞれにindexを再割り当て
    $('input[id^="item_item_images_attributes"]').each(function(index, input) {
      $(input).attr({
        'data-image': String(index),
        name: 'item[item_registered_images][' + index + '][image]',
      });
    })
  }

  // 編集後のデータ送信(submitボタンを指定してもイベントは発火しない)
  $('.edit_item').on('submit', function(e) {
    e.preventDefault();

    // 登録済み画像の入っているhidden_fieldを削除する
    $('input[id^="item_item_images_attributes"]').remove();

    // form情報をformDataに追加
    var formElement = $('#item-dropzone').get(0)
    var formData = new FormData(formElement);

    // 登録済画像が残っていない場合は便宜的に0を入れる
    if (registered_images_ids.length == 0) {
      formData.append("registered_images_ids[ids][]", 0)
    // 登録済画像で、まだ残っている画像があればidをformDataに追加していく
    }
    else {
      registered_images_ids.forEach(function(registered_image) {
        formData.append("registered_images_ids[ids][]", registered_image)
      });
    }

    $.ajax({
      url: '/items/' + gon.item.id,
      type: "PATCH",
      data: formData,
      contentType: false,
      processData: false,
    })
  });
});  

