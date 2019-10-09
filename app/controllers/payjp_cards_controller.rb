class PayjpCardsController < ApplicationController

  # ログインしていない場合ログインページへ移動する
  before_action :authenticate_user!

  def index
    #ログインユーザーのカード情報を取得する
    @credit_card = current_user.credit_card
    @payjp_cards = @credit_card ? @credit_card.getPayJPCards() : []
  end

  def new
    @payjp_card = PayjpCard.new
  end

  def create
    # formのパラメータとpayjp.jsのカードtokenを取得
    @payjp_card = PayjpCard.new(payjp_card_params)
    card_token = token_params[:card_token]
    require "payjp"
    # PAY.JP APIの秘密鍵をセット
    Payjp.api_key = Rails.application.credentials.payjp[:api_key]
    # PAY.JPの顧客情報IDを既にデータベースに登録しているかチェック
    @credit_card = current_user.credit_card
    if @credit_card
      # PAY.JPにカード情報を追加登録
      customer = Payjp::Customer.retrieve(@credit_card.customer_id)
      card = customer.cards.create(card: card_token)
      # エラーレスポンスを含んでいないか確認
      if card.respond_to? :error
        render :new
        return
      end
    else
      # PAY.JPにカードと顧客情報を新規登録
      customer = Payjp::Customer.create(email: current_user.email, card: card_token)
      # エラーレスポンスを含んでいないか確認
      if customer.respond_to? :error
        render :new
        return
      end
      # PayJP顧客情報をユーザー情報と紐づけてデータベース登録
      @credit_card = CreditCard.new(customer_id: customer[:id], user_id: current_user.id)
      unless @credit_card.save
        render :new
        return
      end
    end
    # カード一覧画面に戻る
    redirect_to action: :index
  end

  def destroy
    # ログインユーザのカード情報を取得
    credit_card = current_user.credit_card
    # PAY.JPに登録されたユーザのカードを消去
    customer = Payjp::Customer.retrieve(credit_card.customer_id)
    card = customer.cards.retrieve(payjp_card_params[:id])
    response = card.delete
    #レスポンスにエラーレスポンスが含まれているか確認
    if response.respond_to? :error
      render :index
    end
    # カード一覧画面に戻る
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
