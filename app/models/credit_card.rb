class CreditCard < ApplicationRecord
  #Association
  belongs_to :user

  #PayJPのカード情報を取得する
  def getPayJPCards()
    require 'payjp'
    Payjp.api_key = Rails.application.credentials.payjp[:api_key]
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
    require 'payjp'
    Payjp.api_key = Rails.application.credentials.payjp[:api_key]
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
