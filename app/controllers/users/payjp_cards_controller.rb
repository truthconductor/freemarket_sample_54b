class Users::PayjpCardsController < ApplicationController

  # ログインしていない場合ログインページへ移動する
  before_action :authenticate_user!

  def index
    #ログインユーザーのカード情報を取得する
    @creditCard = CreditCard.find_by(user_id: current_user.id)
    if(@creditCard)
      @payjp_cards = @creditCard.getPayJPCards()
    else
      @payjp_cards = []
    end
  end

  def new
    @payjp_card = PayjpCard.new
  end

  def create
    @payjp_card = PayjpCard.new(payjp_card_params)
    card_token = token_params[:card_token]
    require "payjp"
    # Pay.jpの秘密鍵をセット(要credentials)
    Payjp.api_key = Rails.application.credentials.payjp[:api_key]
    # Pay.jpの顧客情報が既に紐づいているかチェック
    @creditCard = CreditCard.find_by(user_id: current_user.id)
    if @creditCard
      # Pay.jpにカード情報を追加
      customer = Payjp::Customer.retrieve(@creditCard.customer_id)
      card = customer.cards.create(card: card_token)
      if card.respond_to? :error
        render :new
        return
      end
    else
      # Pay.jpにカードと顧客情報を追加
      customer = Payjp::Customer.create(email: current_user.email, card: card_token)
      if customer.respond_to? :error
        render :new
        return
      end
      # カード情報をデータベース登録
      @creditCard = CreditCard.new(customer_id: customer[:id], user_id: current_user.id)
      unless @creditCard.save
        render :new
        return
      end
    end
    # カード一覧画面に戻る
    redirect_to action: :index
  end

  def destroy
    creditCard = CreditCard.find(params[:id])
    # 自身のカードでない時消去を行わない
    if(creditCard&.user_id != current_user.id)
      redirect_to action: :index
      return;
    end

    # ユーザのカードを消去
    customer = Payjp::Customer.retrieve(creditCard.customer_id)
    card = customer.cards.retrieve(payjp_card_params[:id])
    res = card.delete

    redirect_to action: :index
  end

  private

  def payjp_card_params
    params.require(:payjp_card).permit(:number, :year, :month, :cvc, :id)
  end

  def token_params
    params.permit(:card_token)
  end
end
