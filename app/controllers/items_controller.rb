class ItemsController < ApplicationController
  before_action :authenticate_user!, :set_category_parent_array, only: [:new, :create, :edit, :update, :destroy]
  # 商品を取得する
  before_action :get_item, only:[:show, :destroy, :activate, :deactivate]
  def new
    @item = Item.new
    @item.item_images.build
  end

  def create
    @item = Item.new(create_params)
    #フロント実装して(jsで小カテゴリ作って)ないのでバリデーション突破するため仮データを置いてる。
    @item.category_id = 1
    #ステータスを販売中にする。
    @item.sales_state_id = 1
    @item.seller_id = current_user.id

    respond_to do |format|
      if @item.save
        format.html{redirect_to new_item_path}
      else
        #画像がアップロードされずにRollbackした場合、ネストしているitem_imagesモデルが消えるため、新たにbuildする。
        @item.item_images.build if @item.item_images.empty?
        format.html{render action: 'new'}
      end
    end
  end

  def edit
  end
  
  def show
  end

  def destroy
    # 出品者以外から削除リクエストが来た時商品詳細ページへリダイレクト
    return redirect_to item_path(@item) unless @item.seller == current_user
    # 商品が購入済なのに削除リクエストが来た時商品詳細ページへリダイレクト
    return redirect_to item_path(@item) if @item.sales_state_id == 3
    # 商品を消去したらマイページへリダイレクト
    return redirect_to mypage_path if @item.delete
    # 消去に失敗した時商品詳細ページリダイレクト
    render redirect_to item_path(@item)
  end

  # 商品販売状態を販売中にする
  def activate
    # 出品者以外から変更リクエストが来た時商品詳細ページへリダイレクト
    return redirect_to item_path(@item) unless @item.seller == current_user
    # 商品が公開停止中でないのに変更リクエストが来た時商品詳細ページへリダイレクト
    return redirect_to item_path(@item) unless @item.sales_state_id == 2
    # 商品を公開中に切り替えて保存する
    @item.sales_state_id = 1
    @item.save
    redirect_to item_path(@item)
  end

  # 商品販売状態を一旦停止中にする
  def deactivate
    # 出品者以外から変更リクエストが来た時商品詳細ページへリダイレクト
    return redirect_to item_path(@item) unless @item.seller == current_user
    # 商品販売中でないのに変更リクエストが来た時商品詳細ページへリダイレクト
    return redirect_to item_path(@item) unless @item.sales_state_id == 1
    # 商品を一旦停止中に切り替えて保存する
    @item.sales_state_id = 2
    @item.save
    redirect_to item_path(@item)
  end

  private
  def create_params
    params.require(:item).permit(:name, :description, :category_id, :item_state_id, :deliver_expend_id, :deliver_method_id, :prefecture_id, :deliver_day_id, :amount, item_images_attributes: [:image])
  end
  #エラー回避のため、newだけでなくcreateにも持たせる必要がある。
  def set_category_parent_array
    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end
  # 商品を取得する
  def get_item
    @item = Item.find(params[:id]).decorate
  end
end
