class Deals::PurchaseController < ApplicationController

  # ログインしていない場合ログインページへ移動する
  before_action :authenticate_user!

  def check_item
    #ログインユーザーのカード情報を取得する
    @credit_card = current_user.credit_card
    @payjp_card = @credit_card&.getPayjpDefaultCard
  end
end
