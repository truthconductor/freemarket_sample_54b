class Mypage::Sale::SellingController < ApplicationController
  # ログインしていない場合ログインページへ移動する
  before_action :authenticate_user!

  def index
    # 販売中の商品情報を取得
    @items = current_user.items.includes(:sales_state).user_selling()
  end
end
