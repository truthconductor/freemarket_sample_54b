class Deals::PurchaseController < ApplicationController

  # ログインしていない場合ログインページへ移動する
  before_action :authenticate_user!
  # APIキーを使ってPayjpクラスを初期化する
  before_action :set_api_key, only:[:create]
  # 購入確認商品を取得する
  before_action :get_item, only:[:new, :create]

  def new
    # 商品が出品中でないのにリクエストが来た時商品詳細ページへリダイレクト
    return redirect_to item_path(id: @item.id) unless @item.sales_state_id == 1
    # ログインユーザーのカード情報を取得する
    @credit_card = current_user.credit_card
    @payjp_card = @credit_card&.getPayjpDefaultCard
  end

  def create
    # 商品が出品中でないのに購入リクエストが来た時商品詳細ページへリダイレクト
    return redirect_to item_path(id: @item.id) unless @item.sales_state_id == 1
    # 自分の出品商品なのに購入リクエストが来た時商品詳細ページへリダイレクト
    return redirect_to item_path(id: @item.id) if @item.seller == current_user
    #トランザクション開始
    ActiveRecord::Base.transaction do
      begin
        # 取引作成
        @deal = Deal.new(date: Time.now)
        @deal.item = @item
        @deal.buyer = current_user
        @deal.seller = @item.seller
        # 支払い金額の登録（現時点ではポイント管理機能がないためポイント支払いを０とする）
        @deal.build_payment(amount: @item.amount, point: 0)
        @deal.save!
        # 商品の販売状況を売り切れに変更
        @item.sales_state_id = 3
        @item.save!
        # ユーザーのpayjp顧客情報を取得
        customer = Payjp::Customer.retrieve(current_user.credit_card.customer_id)
        # デフォルトカードで支払いを行う
        charge = Payjp::Charge.create(
          :amount => @item.amount,
          :customer => customer.id,
          :currency => 'jpy',
        )
        # 支払い結果のエラーレスポンスを確認しエラー発生時は例外を発生
        if charge.respond_to? :error
          raise ActiveRecord::Rollback
        end
      rescue => error
        # 例外発生時は購入画面に戻りロールバックする
        render :new
        raise ActiveRecord::Rollback
      end
    end
  end

  private
  # PAY.JP APIの秘密鍵をセット
  def set_api_key
    require "payjp"
    Payjp.api_key = Rails.application.credentials.payjp[:api_key]
  end
  # 購入確認商品を取得する
  def get_item
    # 購入確認商品を取得する
    @item = Item.find(params[:item_id]).decorate
  end
end
