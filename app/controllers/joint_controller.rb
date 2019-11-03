class JointController < ApplicationController

  def index
    @category_names = ["レディース","メンズ","家電・スマホ・カメラ","おもちゃ・ホビー・グッズ"]

    @items = []
    @category_names.each do |category_name|
      @category = Category.find_by(name: category_name)
      @subtree_ids = @category.subtree_ids
      # 上記親カテゴリ配下のカテゴリに属する販売中の商品の内、直近で出品された10件を一覧表示する。
      @items << Item.includes([:item_images]).where(category_id: @subtree_ids, sales_state_id: 1).order("updated_at DESC").limit(10)
    end
  end
end