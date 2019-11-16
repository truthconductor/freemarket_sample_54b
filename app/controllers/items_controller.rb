class ItemsController < ApplicationController
  before_action :authenticate_user!, :set_category_parent_array, only: [:new, :create, :edit, :update, :destroy]
  # 商品を取得する
  before_action :get_item, only:[:show, :destroy, :activate, :deactivate, :update, :edit]
  def new
    @item = Item.new
    @item.item_images.build
  end

  def create
    @item = Item.new(create_params)
    #入力されたブランドがbrandsテーブルに存在する場合、ブランド情報をセット
    @item.brand = Brand.find_by(name:brand_name_params[:brand_name]) unless brand_name_params.empty?
    #ステータスを販売中にする。
    @item.sales_state_id = 1
    @item.seller_id = current_user.id
    respond_to do |format|
      if @item.save
        format.html{redirect_to root_path}
      else
        #画像がアップロードされずにRollbackした場合、ネストしているitem_imagesモデルが消えるため、新たにbuildする。
        @item.item_images.build if @item.item_images.empty?
        format.html{render action: 'new'}
      end
    end
  end

  def edit
    # 商品が販売済なのに編集リクエストが来た時商品詳細ページへリダイレクト
    return redirect_to item_path(@item) if @item.sales_state_id == 3
    # 他人の出品商品なのに編集リクエストが来た時商品詳細ページへリダイレクト
    return redirect_to item_path(@item) if @item.seller != current_user
    gon.item = @item
    gon.item_images = @item.item_images
    # 子カテゴリの取得
    child_id = gon.child_id = Category.find_by(id: @item.category_id).parent_id
    set_category_grandchild_array(child_id)

    # 親カテゴリの取得
    unless Category.find_by(id: @item.category_id).parent.parent.nil?
      parent_name = gon.parent_category = Category.find_by(id: @item.category_id).parent.parent.name
      gon.grandchild_category = @item.category_id
    else
      parent_name = gon.parent_category = Category.find_by(id: @item.category_id).parent.name
      gon.child_id = @item.category_id
    end
    set_category_child_array(parent_name)

    # 1=送料込み、2=着払い
    if @item.deliver_expend_id == 1
      get_deliver_method
    else
      get_deliver_method_cash_on_delivery
    end

    # バイナリデータをbase64でエンコードする←おそらく不要
    # require 'base64'
    require 'aws-sdk-s3'

    gon.item_images_binary_datas = []
    if Rails.env.production?
      client = Aws::S3::Client.new(
                              region: 'ap-northeast-1',
                              access_key_id: Rails.application.credentials.aws[:access_key_id],
                              secret_access_key: Rails.application.credentials.aws[:secret_access_key],
                              )
      @item.item_images.each do |image|
        gon.item_images_binary_datas << image.image_url
      end
    else
      @item.item_images.each do |image|
        gon.item_images_binary_datas << image.image_url
      end
    end
  end

  def update
    # 商品が販売済なのに編集リクエストが来た時商品詳細ページへリダイレクト
    return redirect_to item_path(@item) if @item.sales_state_id == 3
    # 他人の出品商品なのに編集リクエストが来た時商品詳細ページへリダイレクト
    return redirect_to item_path(@item) if @item.seller != current_user
    # 登録済画像のidの配列を生成
    ids = @item.item_images.map{|image| image.id}
    # 登録済画像のうち、編集後も残っている画像のidの配列を生成
    exist_ids = registered_image_params[:ids].map(&:to_i)
    # 登録済画像が残っていない場合(配列に0が格納されている)、配列を空にする
    exist_ids.clear if exist_ids[0] == 0

    # 新規登録、登録済画像が1枚も残っていない場合は、元の画面がredirectする
    unless exist_ids.length == 0 && params[:item][:item_images_attributes].nil?
      @item.update!(create_params)
      # 登録済画像のうち削除ボタンが押された画像を削除
      unless ids.length == exist_ids.length
        # 削除する画像のidの配列を生成
        delete_ids = ids - exist_ids
        delete_ids.each do |id|
          @item.item_images.find(id).destroy
        end
      end
      redirect_to item_path(@item), data: {turbolinks: false}
    else
      redirect_back(fallback_location: root_path)
    end 
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

  #エラー回避のため、newだけでなくcreateにも持たせる必要がある。
  def set_category_parent_array
    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end 

  def set_category_child_array(parent_name)
    @category_child_array = [["---", "---"]]
    Category.find_by(name: parent_name, ancestry: nil).children.each do |child|
      @category_child_array << [child.name, child.id]
    end
  end

  def set_category_grandchild_array(child_id)
    @category_grandchild_array = [["---", "---"]]
    Category.find_by(id: child_id).children.each do |grandchild|
      @category_grandchild_array << [grandchild.name, grandchild.id]
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
    # params.require(:item).permit(:name, :description, :category_id, :item_state_id, :deliver_expend_id, :deliver_method_id, :prefecture_id, :deliver_day_id, :amount)
  end
  
  def brand_name_params
    params.require(:item).permit(:brand_name)
  end

  # 商品を取得する
  def get_item
    @item = Item.find(params[:id]).decorate
  end

  def registered_image_params
    params.require(:registered_images_ids).permit({ids: []})
  end
end
