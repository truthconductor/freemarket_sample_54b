class Mypage::Sale::ClosedController < ApplicationController
  
  def index
    # 販売済みの情報を全て取得
    @deals = current_user.seller_deals.closed.order(id: :desc).includes(:item)
  end
end
