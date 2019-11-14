$(document).on('turbolinks:load', function() {
  // 商品出品ページでのみ発火するように正規表現で条件分岐
  var re = new RegExp('/items/new|/items$');
  if(!re.test(location.pathname)) {
   return;
  }

  var preview = $('.preview');
  var input_area = $('.input_area');

  // DB保存に失敗(Rollback)した際に残っている、動的に生成したinputタグを削除する
  $(document).ready(function(){
    for (var i = preview.length; i > 1; i--) {
      preview[i-1].remove();
    }
    preview = $('.preview');
  });

  //inputの中身の変更時に発生
  $(document).on('change', '[type="file"].upload-image', function(event) {

    // 変更を行ったinputを取得する
    changed_input = $(this);
    changed_id = changed_input.data('image');
    // 現時点でのfile用inputタグを全取得する
    inputs_length = $('[type="file"].upload-image').length;
    //変更されたinputが末尾のinput（空欄からの追加）の場合、inputを更に追加
    if(changed_id === inputs_length - 1 && inputs_length <= 10) {
      var new_input = $(`<input class="upload-image" type="file" style="display: none;">`);
      input_area.append(new_input);
    }

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
    reorder_data_image();

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
    var remove_id = target_image.data('image');
    // 同じidのinputを取得する
    var remove_input = $('[type="file"].upload-image[data-image='+remove_id+']');
    //input,image_view消去
    remove_input.remove();
    target_image.remove();
    //input,image_viewそれぞれにindexを再割り当て
    reorder_data_image();
  });

  // data-imageをの番号を再割り当てする
  function reorder_data_image() {
    //input,image_viewそれぞれにindexを再割り当て
    $('[type="file"].upload-image').each(function(index, input) {
      debugger
      $(input).attr({
        'data-image': index,
        id: 'upload-image-' + index,
        name: 'item[item_images_attributes][' + index + '][image]',
      });
      $(input).prop('disabled', index >= 10);
    })
    $('.img-view').each(function(index, image) {
      $(image).attr('data-image', index);
    });
    //dropzone-boxに対応付くinputを末尾のinputに再割り当て
    $('.dropzone-box').attr('for','upload-image-' + ($('[type="file"].upload-image').length - 1));
    $('.items-sell-container__dropzone' + ($('[type="file"].upload-image').length)).attr('class', 'items-sell-container__dropzone' + ($('[type="file"].upload-image').length - 1));
  }
});