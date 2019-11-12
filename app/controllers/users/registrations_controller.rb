# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  #before_action :to_katakana,only: [:create]
  #GET /resource/sign_up
  before_action :validates_step1, only: :step2 
  before_action :validates_step2, only: :step3 
  before_action :validates_step3, only: :step4 

  before_action :set_api_key, only:[:step4,:create]

  require "date"

  layout "registration"

  def new
    session.clear
    build_resource
    @user.build_personal
    @user.build_profile
    yield resource if block_given?
    respond_with resource
  end

  def step1
    build_resource
    @user.build_personal
    @user.build_profile
  end

  def step2
    session[:nickname]=sign_up_params[:profile_attributes][:nickname]
    session[:email] = sign_up_params[:email]
    session[:password] = sign_up_params[:password]
    session[:password_confirmation]= sign_up_params[:password_confirmation]
    session[:last_name]= sign_up_params[:personal_attributes][:last_name]
    session[:first_name]= sign_up_params[:personal_attributes][:first_name]
    session[:last_name_kana]= sign_up_params[:personal_attributes][:last_name_kana]
    session[:first_name_kana]= sign_up_params[:personal_attributes][:first_name_kana]
    year = sign_up_params[:personal_attributes][:"birthdate(1i)"].to_i
    month = sign_up_params[:personal_attributes][:"birthdate(2i)"].to_i
    day = sign_up_params[:personal_attributes][:"birthdate(3i)"].to_i
    session[:birthdate] = Date.new(year,month, day) if Date.valid_date?(year,month, day)
    build_resource
    @user.build_personal
    @user.build_profile
  end
  
  def step3
   session[:phone_number]=params[:user][:cellular_phone_number]
   build_resource
   @user.build_personal
   @user.build_profile
  end

  def step4
    session[:zip_code]=params[:user][:zip_code]
    session[:prefecture_id]=params[:user][:prefecture_id]
    session[:city]=params[:user][:city]
    session[:address]=params[:user][:address]
    session[:building]=params[:user][:building]
    build_resource
    @user.build_personal
    @user.build_profile
    @payjp_card = PayjpCard.new
  end

  #POST /resource
  def create
    build_resource(
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation])

    resource.build_profile(
      nickname: session[:nickname]
    )
    resource.build_personal(
      first_name: session[:first_name],
      last_name: session[:last_name],
      first_name_kana: session[:first_name_kana],
      last_name_kana: session[:last_name_kana],
      birthdate: session[:birthdate],
      cellular_phone_number: session[:phone_number].to_s,
      zip_code: session[:zip_code],
      prefecture_id: session[:prefecture_id],
      city: session[:city],
      address: session[:address],
      building: session[:building]
    )

    resource.save
    
    # formのパラメータとpayjp.jsのカードtokenを取得
    @payjp_card = PayjpCard.new(payjp_card_params)
    card_token = token_params[:card_token]

    customer = Payjp::Customer.create(card: card_token)
    @credit_card = CreditCard.new(customer_id: customer[:id], user_id: @user.id)
    @credit_card.save
    unless @credit_card.save
      render :new
      return
    end

    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, current_user) 
        respond_with resource, location: after_sign_up_path_for(resource)
        
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  #def to_katakana
    #ひらがなで入力されたものをカタカナに変換する（未実装）
    #sign_up_params[:personal_attributes][:first_name_kana].tr('ぁ-ん','ァ-ン')
  #end
  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def validates_step1
    # step1で入力された値をsessionに保存
    session[:nickname]=sign_up_params[:profile_attributes][:nickname]
    session[:email] = sign_up_params[:email]
    session[:password] = sign_up_params[:password]
    session[:password_confirmation]= sign_up_params[:password_confirmation]
    session[:last_name]= sign_up_params[:personal_attributes][:last_name]
    session[:first_name]= sign_up_params[:personal_attributes][:first_name]
    session[:last_name_kana]= sign_up_params[:personal_attributes][:last_name_kana]
    session[:first_name_kana]= sign_up_params[:personal_attributes][:first_name_kana]
    year = sign_up_params[:personal_attributes][:"birthdate(1i)"].to_i
    month = sign_up_params[:personal_attributes][:"birthdate(2i)"].to_i
    day = sign_up_params[:personal_attributes][:"birthdate(3i)"].to_i
    session[:birthdate] = Date.new(year,month, day) if Date.valid_date?(year,month, day)
    @user = User.new(
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation]
    )
    @profile=@user.build_profile(
      nickname: session[:nickname]
  )
    @personal=@user.build_personal(
      last_name: session[:last_name], 
      first_name: session[:first_name], 
      last_name_kana: session[:last_name_kana], 
      first_name_kana: session[:first_name_kana],
      birthdate: session[:birthdate], 
      cellular_phone_number: "08012129090",
      zip_code: "あ",
      prefecture_id: "1",
      city: "あ",
      address: "あ",
      building: "あ"
    )
    render action: :step1 unless @user.valid?
  end

  def validates_step2
    session[:phone_number]=params[:user][:cellular_phone_number]
    @user = User.new(
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation]
    )
    @profile=@user.build_profile(
      nickname: session[:nickname]
  )
    @personal=@user.build_personal(
      last_name: session[:last_name], 
      first_name: session[:first_name], 
      last_name_kana: session[:last_name_kana], 
      first_name_kana: session[:first_name_kana],
      birthdate: session[:birthdate],
      cellular_phone_number: session[:phone_number],
      zip_code: "あ",
      prefecture_id: "1",
      city: "あ",
      address: "あ",
      building: "あ"
    )
    render action: :step2  unless @personal.valid?
  end

  def validates_step3
    session[:zip_code]=params[:user][:zip_code]
    session[:prefecture_id]=params[:user][:prefecture_id]
    session[:city]=params[:user][:city]
    session[:address]=params[:user][:address]
    session[:building]=params[:user][:building]
    @user = User.new(
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation]
    )
    @profile=@user.build_profile(
      nickname: session[:nickname]
  )
    @personal=@user.build_personal(
      last_name: session[:last_name], 
      first_name: session[:first_name], 
      last_name_kana: session[:last_name_kana], 
      first_name_kana: session[:first_name_kana],
      birthdate: session[:birthdate],
      cellular_phone_number: session[:phone_number],
      zip_code: session[:zip_code],
      prefecture_id: session[:prefecture_id],
      city: session[:city],
      address: session[:address],
      building: session[:building]
    )
    render action: :step3 unless @personal.valid?
  end

  # PAY.JP APIの秘密鍵をセット
  def set_api_key
    require "payjp"
    Payjp.api_key = Rails.application.credentials.payjp[:api_key]
  end

  def payjp_card_params
    params.require(:payjp_card).permit(:number, :year, :month, :cvc, :id)
  end

  def token_params
    params.permit(:card_token)
  end

end