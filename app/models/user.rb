class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_one :personal, dependent: :destroy
  has_one :delivery_address, dependent: :destroy
  has_many :items, class_name: 'Item', foreign_key: 'seller_id'
  has_many :buyer_deals, class_name: 'Deal', foreign_key: 'buyer_id'
  has_many :seller_deals, class_name: 'Deal', foreign_key: 'seller_id'
  has_many :item_comments
  has_many :item_likes
  has_one :credit_card, dependent: :destroy

  # 購入可能な情報を保持しているか判定する
  def can_purchase?
    return delivery_address != nil && credit_card&.getPayjpDefaultCard != nil
  end
end
