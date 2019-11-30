class Deals::DealsDeliveryAddressesController < DeliveryAddressesController
  def new
    # 既に発送先が登録されているのにnewページを表示した時はeditページにリダイレクトする
    if current_user.delivery_address
      redirect_to edit_item_purchase_delivery_address_path(params[:item_id], current_user.delivery_address)
    else
      super
    end
  end

  def create
    # 入力情報とユーザー情報を元に配送先を保存
    @delivery_address = DeliveryAddress.new(address_params)
    @delivery_address.user = current_user
    if @delivery_address.save
      redirect_to(new_item_purchase_path, notice: "配送先を登録しました")
    else
      flash[:alert] = '入力内容に不備があります'
      render :new
    end
  end

  def update
    # 入力情報とを元に配送先を更新
    @delivery_address = DeliveryAddress.find(params[:id])
    if @delivery_address.user_id == current_user.id
      if @delivery_address.update(address_params)
        redirect_to(new_item_purchase_path, notice: "配送先を変更しました")
      else
        flash[:alert] = '入力内容に不備があります'
        render :edit
      end
    end
  end

private
  def address_params
    params.require(:delivery_address).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :zip_code, :prefecture_id, :city, :address, :building, :phone_number)
  end
end
