$(document).on('turbolinks:load', function() {
  var preview = $('#preview');
  var input_area = $('.input_area')

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

    //変更されたidに対応するimg_viewを取得
    var image_view = $(".img_view[data-image="+changed_id+"]").first();
    //idに対応するimg_viewが存在しないときは追加
    if(!image_view[0]) {
      image_view = $(`<div class = "img_view">
                        <img>
                        <div class="btn_wrapper">
                          <div class="btn edit">編集</div>
                          <div class="btn delete">削除</div>
                        </div>
                      </div>`);
      preview.append(image_view);
    }

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
  $(document).on('click', '.delete', function() {
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
      $(input).attr({
        'data-image': index,
        id: 'upload-image-' + index,
        name: 'item[item_images_attributes][' + index + '][image]',
      });
      $(input).prop('disabled', index >= 10);
    })
    $('.img_view').each(function(index, image) {
      $(image).attr('data-image', index);
    });
    //dropzone-boxに対応付くinputを末尾のinputに再割り当て
    $('.dropzone-box').attr('for','upload-image-' + ($('[type="file"].upload-image').length - 1));
  }
});