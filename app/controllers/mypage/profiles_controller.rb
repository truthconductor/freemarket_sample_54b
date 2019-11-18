class Mypage::ProfilesController < ApplicationController
  # ログインしていない場合ログインページへ移動する
  before_action :authenticate_user!
  # ユーザープロフィール情報を取得する
  before_action :get_profile, only:[:edit, :update]

  def new
    # プロフィールを作成したのに新規作成リクエストが来た際にはeditアクションにリダイレクト
    return redirect_to edit_mypage_profiles_path if current_user.profile
    @profile = current_user.build_profile
  end

  def create
    # プロフィールを作成したのに新規作成リクエストが来た際にはeditアクションにリダイレクト
    return redirect_to edit_mypage_profiles_path if current_user.profile
    @profile = current_user.build_profile(profile_param)
    if @profile.save
      redirect_to(mypage_path, notice: "プロフィールを作成しました")
    else
      flash[:alert] = '入力内容に不備があります'
      render :new
    end
  end

  def edit
    # プロフィールを作成していないのに編集リクエストが来た際にはnewアクションにリダイレクト
    return redirect_to  new_mypage_profiles_path unless @profile
  end

  def update
    # プロフィールを作成していないのに編集リクエストが来た際にはnewアクションにリダイレクト
    return redirect_to new_mypage_profiles_path unless @profile
    if @profile.update(profile_param)
      redirect_to(mypage_path, notice: "プロフィールを更新しました")
    else
      flash[:alert] = '入力内容に不備があります'
      render :edit
    end
  end

  private
  def profile_param
    params.require(:profile).permit(:nickname, :introduction)
  end
  def get_profile
    @profile = current_user.profile
  end
end
