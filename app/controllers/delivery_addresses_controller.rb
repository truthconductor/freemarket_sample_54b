class DeliveryAddressesController < ApplicationController
  # ログインしていない場合ログインページへ移動する
  before_action :authenticate_user!
  def new
    @delivery_address = DeliveryAddress.new
  end
end
