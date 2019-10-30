$(document).on('turbolinks:load', function() {
  // 商品詳細ページの以外のパスでない時処理を行わない
  var re = new RegExp('/items/[0-9]+$');
  if(!re.test(location.pathname)) {
    return;
  }
  // 商品のトップ表示画像を取得
  var top_image = document.querySelector(".item-detail__infomation__images__top__image");
  // リスト中のハイライト画像を取得
  var selected_image = document.querySelector(".item-detail__infomation__images__flex__box__image--selected");
  // 画像一覧ファイルを取得
  var images = document.querySelectorAll('.item-detail__infomation__images__flex__box')
  // イベント登録
  for(i = 0; i < images.length; i++) {
    images[i].addEventListener('mouseenter', (e) => {
      // マウスが通過した画像をトップ表示画像に切り替える
      var enter_image = e.target.querySelector("img");
      if (enter_image !== selected_image) {
        top_image.src = enter_image.src
        // ハイライトCSSの付け替え
        selected_image.classList.remove('item-detail__infomation__images__flex__box__image--selected');
        enter_image.classList.add('item-detail__infomation__images__flex__box__image--selected');
        selected_image = enter_image;
        // 画像をフェードアウト後フェードインを行う
        $('.item-detail__infomation__images__top__image').stop(false, false).fadeOut(250);
        $('.item-detail__infomation__images__top__image').stop(false, true).fadeIn(750);
      }
    });
  }
});