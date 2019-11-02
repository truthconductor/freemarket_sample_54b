class Mypage::ProfilesController < ApplicationController
  # ログインしていない場合ログインページへ移動する
  before_action :authenticate_user!
  # ユーザープロフィール情報を取得する
  before_action :get_profile, only:[:edit, :update]

  def new
    @profile = Profile.new
  end

  def create
  end

  def edit
  end

  def update
  end

  private
  def profile_param
  end

  def get_profile
    @profile = Profile.find_by(user_id: current_user.id)
  end
end
