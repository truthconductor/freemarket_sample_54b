class Mypage::Purchase::DealingController < ApplicationController
  # ログインしていない場合ログインページへ移動する
  before_action :authenticate_user!

  def index
    # 取引中の購入情報を全て取得
    @deals = current_user.buyer_deals.in_progress.order(id: :desc).includes(:item)
  end
end
