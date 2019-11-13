# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:

  def facebook
    callback_from :facebook
  end

  def google_oauth2
    callback_from :google
  end

  

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
  private

  def callback_from(provider)
    provider = provider.to_s #プロバイダを定義
    @user = User.from_omniauth(request.env['omniauth.auth']) #モデルでSNSにリクエストするメソッド（from_omniauth）を使用し、レスポンスを@userに代入
    if @user.persisted? #@userがすでに存在したらログイン処理、存在しなかったら残りの登録処理へ移行
      sign_in @user
      redirect_to root_path
    else
      session[:provider] = @user.provider
      session[:uid] = @user.uid
      redirect_to step1_google_path
    end
  end

end
