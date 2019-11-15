$(document).on('turbolinks:load', function() {
  // トップページのカテゴリ名・ブランド名をクリックすると該当商品一覧の先頭にスクロールする
  // トップページのみの機能のためトップページ以外では実行させない
  if(location.pathname !== "/"){
    return;
  }

  // カテゴリーの選択
  $(".popular_category_label").on("click", function() {
    // クリックしたカテゴリーのdata_idが一致する表示エリアを検索しスクロールする
    category_id = $(this).data('category-id');
    var category_block = $(".root-new__production__box[data-category-id="+category_id+"]");
    var scrollSize = category_block.last().offset().top
    $("html,body").animate(
      { scrollTop: category_block.last().offset().top },
      { duration: 750 }
    );
  });

  // ブランドの選択
  $(".popular_brand_label").on("click", function() {
    // クリックしたブランドのdata_idが一致する表示エリアを検索しスクロールする
    brand_id = $(this).data('brand-id');
    var brand_block = $(".root-new__production__box[data-brand-id="+brand_id+"]");
    var scrollSize = brand_block.last().offset().top
    $("html,body").animate(
      { scrollTop: brand_block.last().offset().top },
      { duration: 750 }
    );
  });

});