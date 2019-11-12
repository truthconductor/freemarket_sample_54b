class MypagesController < ApplicationController
  # ログインしていない場合ログインページへ移動する
  before_action :authenticate_user!

  def show
  end

  def logout
  end
end
