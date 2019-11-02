class ItemsController < ApplicationController
  before_action :authenticate_user!, :set_category_parent_array, only: [:new, :create, :edit, :update]
  def new
    @item = Item.new
    @item.item_images.build
  end

  def create
    @item = Item.new(create_params)
    #ステータスを販売中にする。
    @item.sales_state_id = 1
    @item.seller_id = current_user.id
    respond_to do |format|
      if @item.save
        format.html{redirect_to root_path}
      else
        #画像がアップロードされずにRollbackした場合、ネストしているitem_imagesモデるが消えるため、新たにbuildする。
        @item.item_images.build if @item.item_images.empty?
        format.html{render action: 'new'}
      end
    end
  end

  def edit
  end

  def show
    @item = Item.find(params[:id]).decorate
  end

  #エラー回避のため、newだけでなくcreateにも持たせる必要がある。
  def set_category_parent_array
    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end

  def get_deliver_method
    @deliver_methods = DeliverMethod.all
  end

  def get_deliver_method_cash_on_delivery
    @deliver_methods = DeliverMethod.where(cash_on_delivery: true)
  end

  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  private
  def create_params
    params.require(:item).permit(:name, :description, :category_id, :item_state_id, :deliver_expend_id, :deliver_method_id, :prefecture_id, :deliver_day_id, :amount, item_images_attributes: [:image])
  end
end
