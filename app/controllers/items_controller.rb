class ItemsController < ApplicationController
  before_action :authenticate_user!, :set_category_parent_array, only: [:new, :create, :edit, :update]
  def new
    @item = Item.new
    2.times { @item.item_images.build }
  end

  def create
    @item = Item.new(create_params)
    #フロント実装して(jsで小カテゴリ作って)ないのでバリデーション突破するため仮データを置いてる。
    @item.category_id = 1
    @item.deliver_method_id = 1
    #ステータスを販売中にする。
    @item.sales_state_id = 1
    @item.seller_id = current_user.id
    if @item.save
      redirect_to new_item_path
    else
      render :new
    end
  end

  def edit
  end

  private
  def create_params
    params.require(:item).permit(:name, :description, :category_id, :item_state_id, :deliver_expend_id, :prefecture_id, :deliver_day_id, :amount, item_images_attributes: [:image])
  end
  #エラー回避のため、newだけでなくcreateにも持たせる必要がある。
  def set_category_parent_array
    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end
end
