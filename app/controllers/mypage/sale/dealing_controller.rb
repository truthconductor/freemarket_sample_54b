class Mypage::Sale::DealingController < ApplicationController
  # ログインしていない場合ログインページへ移動する
  before_action :authenticate_user!

  def index
    # 取引中の販売情報を全て取得
    @deals = current_user.seller_deals.in_progress.order(id: :desc).includes(:item)
  end
end
