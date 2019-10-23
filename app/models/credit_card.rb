class CreditCard < ApplicationRecord
  #Association
  belongs_to :user

  # インスタンス化された際に実行
  after_initialize do
    require "payjp"
    Payjp.api_key = Rails.application.credentials.payjp[:api_key]
  end

  #PayJPのカード情報を取得する
  def getPayJPCards()
    return [] if customer_id.nil?
    customer = Payjp::Customer.retrieve(customer_id)
    payjpCards = []
    customer.cards.all().each do |card|
      # Payjpから返ってきた値を自前のModelに変換
      payjpCard = PayjpCard.new(
                  number: "************" + card.last4,
                  month: card.exp_month,
                  year: card.exp_year,
                  brand: card.brand,
                  id: card.id)
       payjpCards << payjpCard
    end
    return payjpCards
  end

  #PayJPの顧客デフォルトカード情報を取得する
  def getPayjpDefaultCard()
    return nil if customer_id.nil?
    customer = Payjp::Customer.retrieve(customer_id)
    if customer.default_card
      card = customer.cards.retrieve(customer.default_card)
      payjpCard = PayjpCard.new(
        number: "************" + card.last4,
        month: card.exp_month,
        year: card.exp_year,
        brand: card.brand,
        id: card.id)
    else
      payjpCard = nil
    end
  end
end
