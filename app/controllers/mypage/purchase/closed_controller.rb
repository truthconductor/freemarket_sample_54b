class Mypage::Purchase::ClosedController < ApplicationController
  # ログインしていない場合ログインページへ移動する
  before_action :authenticate_user!

  def index
    # 取引完了の購入商品を全て取得
    @deals = current_user.buyer_deals.closed().order(id: :desc).includes(:item)
  end
end
