class JointController < ApplicationController

  def index
    @categories = ["レディース","メンズ","家電・スマホ・カメラ","おもちゃ・ホビー・グッズ"]

    @items = []
    @categories.each do |category|
      @category = category
      @parent_category = Category.find_by(name: @category)
      @subtree_ids = @parent_category.subtree_ids
      @items << Item.includes([:item_images]).where(category_id: @subtree_ids).order("updated_at DESC").limit(10)
    end
  end
end