class JointController < ApplicationController

  def index
    # 人気カテゴリー直近１０アイテムの情報を取得
    @category_datas = []
    category_names = ["レディース","メンズ","家電・スマホ・カメラ","おもちゃ・ホビー・グッズ"]
    category_names.each do |category_name|
      category = Category.find_by(name: category_name)
      subtree_ids = category.subtree_ids
      # 上記親カテゴリ配下のカテゴリに属する販売中の商品の内、直近で出品された10件を取得
      category_items = Item.includes([:item_images]).where(category_id: subtree_ids, sales_state_id: 1).recent(10)
      @category_datas << {category: category, items: category_items}
    end

    # 人気ブランド直近１０アイテムの情報を取得
    @brand_datas = []
    brand_names = ["シャネル","ルイ ヴィトン","シュプリーム","ナイキ"]
    brand_names.each do |brand_name|
      brand = Brand.find_by(name: brand_name)
      # 上記ブランドに属する販売中の商品の内、直近で出品された10件を取得
      brand_items = Item.includes([:item_images]).where(brand: brand, sales_state_id: 1).recent(10)
      @brand_datas << {brand: brand, items: brand_items}
    end

  end
end