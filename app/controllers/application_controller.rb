class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  private

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
  #sign_up_paramsにpersonalモデルのデータを追加
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [profile_attributes: [:nickname]])
    devise_parameter_sanitizer.permit(:sign_up, keys: [personal_attributes: [:last_name,:first_name,:last_name_kana,:first_name_kana,:zip_code,:prefecture_id,:city,:adress,:building,:cellular_phone_number,:birthdate]])
  end
end
